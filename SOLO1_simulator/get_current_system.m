function system = get_current_system(results)
    system.Cancer = results.Cancer;
    system.WBC = results.WBC(end);
    system.parpi = results.olaparib(end); 
    system.carboplatin = results.carboplatin(end);
    system.time = results.time(end);
end