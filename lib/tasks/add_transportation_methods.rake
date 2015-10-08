desc 'adds transportation options for hackers'
task :addTransportationMethods => :environment do

  current_name = 'Carnegie Mellon/University of Pittsburgh -> Ohio St'
  if !TransportationMethod.find_by(name: current_name).present?
    cmu_ohio = TransportationMethod.create! name: current_name
    School.find_by(name: 'Carnegie Mellon University').update(transportation_method_id: cmu_ohio.id)
    School.find_by(name: 'University of Pittsburgh').update(transportation_method_id: cmu_ohio.id)
    School.find_by(name: 'Ohio State University').update(transportation_method_id: cmu_ohio.id)
  end

  current_name = 'University of Iowa -> UIUC'
  if !TransportationMethod.find_by(name: current_name).present?
    iowa_uiuc = TransportationMethod.create! name: current_name
    School.find_by(name: 'University of Iowa').update(transportation_method_id: iowa_uiuc.id)
    School.find_by(name: 'University of Illinois-Urbana-Champaign').update(transportation_method_id: iowa_uiuc.id)
  end

  current_name = 'Waterloo -> Michigan State'
  if !TransportationMethod.find_by(name: current_name).present?
    waterloo_michstate = TransportationMethod.create! name: current_name
    School.find_by(name: 'University of Waterloo').update(transportation_method_id: waterloo_michstate.id)
    School.find_by(name: 'Michigan State University').update(transportation_method_id: waterloo_michstate.id)
  end

  current_name = 'University of Michigan'
  if !TransportationMethod.find_by(name: current_name).present?
    umich = TransportationMethod.create! name: current_name
    School.find_by(name: 'University of Michigan').update(transportation_method_id: umich.id)
  end

  current_name = 'Georgia Tech -> Rose-Hulman'
  if !TransportationMethod.find_by(name: current_name).present?
    gt_rose = TransportationMethod.create! name: current_name
    School.find_by(name: 'Georgia Institute of Technology').update(transportation_method_id: gt_rose.id)
    School.find_by(name: 'Georgia State University').update(transportation_method_id: gt_rose.id)
    School.find_by(name: 'Rose-Hulman Institute of Technology').update(transportation_method_id: gt_rose.id)
  end

end
