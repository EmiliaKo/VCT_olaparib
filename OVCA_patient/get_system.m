function system = get_system(results)

    system.Cancer = results.Cancer;    
    system.WBC = results.WBC(end);
    system.carboplatin = results.carboplatin(end);
    system.parpi = results.olaparib(end);
    system.time =results.time(end);



end