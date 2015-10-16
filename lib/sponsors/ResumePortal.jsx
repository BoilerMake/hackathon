import React from 'react';
import Paginator from 'react-pagify';
import { Table, Search, sortColumn, formatters } from 'reactabular';
import request from 'superagent';


const highlight = formatters.highlight;


module.exports = React.createClass({
  getInitialState() {
    var data = [];

    var highlighter = (column) => highlight((value) => {
      return Search.matches(column, value, this.state.search.query);
    });

    return {
      data: data,
      search: {
        column: '',
        query: ''
      },
      header: {
        onClick: (column) => {
          sortColumn(
            this.state.columns,
            column,
            this.setState.bind(this)
          );
        },
      },
      sortingColumn: null,
      columns: [
        {
          property: 'name',
          header: 'Name',
          cell: [highlighter('name')],
        },
        {
          property: 'school',
          header: 'School',
          cell: [highlighter('school')]
        },
        {
          property: 'major',
          header: 'Major',
          cell: [highlighter('major')]
        },
        {
          property: 'gender',
          header: 'Gender',
          cell: [highlighter('gender')]
        },
        {
          property: 'email',
          header: 'Email',
          cell: [highlighter('email')]
        },
        {
          property: 'resume',
          header: 'Resume',
          cell: value => this.resumeLink(value)
        }
      ],
      pagination: {
        page: 0,
        perPage: 10
      }
    };
  },

  resumeLink: function(value) {
    let link;

    if (value.length > 2) {
      link = <a href={value}>Download</a>;
    } else {
      link = <span>N/A</span>;
    }
    return { link };
  },

  onSearch(search) {
    this.setState({
      search: search
    });
  },

  onSelect(page) {
    var pagination = this.state.pagination || {};

    pagination.page = page;

    this.setState({
      pagination: pagination
    });
  },

  onPerPage(e) {
    var pagination = this.state.pagination || {};

    pagination.perPage = parseInt(e.target.value, 10);

    this.setState({
      pagination: pagination
    });
  },

  componentDidMount: function() {
    var self = this;
    request.get('/sponsors/hackers.json')
      .end(function(err, res) {
        self.setState({
          data: res.body
        });
      });
  },

  render() {
    var header = this.state.header;
    var columns = this.state.columns;

    var pagination = this.state.pagination;

    var data = this.state.data;

    if (this.state.search.query) {
      data = Search.search(
        data,
        columns,
        this.state.search.column,
        this.state.search.query
      );
    }

    data = sortColumn.sort(data, this.state.sortingColumn);

    var paginated = Paginator.paginate(data, pagination);

    return (
      <div>
        <div className='controls'>
          <div className='search-container'>
            Search <Search columns={columns} data={this.state.data} onChange={this.onSearch} />
          </div>
        </div>

        <Table
          className='table table-striped'
          header={header}
          columns={columns}
          data={paginated.data}
          row={(d, rowIndex) => {
            return {
              className: rowIndex % 2 ? 'odd-row' : 'even-row'
            };
          }}
        >
        </Table>

        <div className='pagination'>
          <div className='per-page-container'>
            Per page <input type='text' defaultValue={pagination.perPage} onChange={this.onPerPage}></input>
          </div>
          <Paginator
            className='btn-group'
            page={paginated.page}
            pages={paginated.amount}
            beginPages={3}
            endPages={3}
            onSelect={this.onSelect}
          />
        </div>
      </div>
    );
  }
});
