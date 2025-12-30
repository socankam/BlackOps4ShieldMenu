VehicleMenu()
{
    init_vehicles();

    self createMenu("VehicleMenu", "Vehicle Menu");
    if(Multiplayer()){
        self addOption("VehicleMenu", "Spawn Controllable Helicopter", &SpawnVehicleModel, "CHC");
        self addOption("VehicleMenu", "Spawn Controllable Mantis", &SpawnVehicleModel, "MQT");
        self addOption("VehicleMenu", "Spawn Gunship", &SpawnVehicleModel, "GSP");
        self addOption("VehicleMenu", "Spawn RC-XD", &SpawnVehicleModel, "RCX");
        self addOption("VehicleMenu", "Spawn Transport Helicopter", &SpawnVehicleModel, "THC");
        self addOption("VehicleMenu", "Spawn Helicopter 2", &SpawnVehicleModel, "CHHH");
    }
    if(Blackout()){
        if(level.CurrentMap == "wz_open_skyscrapers"){
            self addOption("VehicleMenu", "Muscle Cars", &OpenSubMenu, "SpawnMuscleCars");
            self addOption("VehicleMenu", "Motorcycles", &OpenSubMenu, "SpawnMotorcycles");
            self addOption("VehicleMenu", "Helicopters", &OpenSubMenu, "SpawnHelicopters");
            self addOption("VehicleMenu", "Tanks", &OpenSubMenu, "SpawnTanks");
            self addOption("VehicleMenu", "ATVs", &OpenSubMenu, "SpawnATVs");
            self addOption("VehicleMenu", "Cargo Trucks", &OpenSubMenu, "SpawnCargoTrucks");
            self addOption("VehicleMenu", "SUVs", &OpenSubMenu, "SpawnSUVs");
        }
        self addOption("VehicleMenu", "Boats", &OpenSubMenu, "SpawnBoats");

        self createMenu("SpawnMuscleCars", "Muscle Cars");
        self addOption("SpawnMuscleCars", "Spawn Heist Muscle Car", &SpawnVehicleModel, "HMC");
        self addOption("SpawnMuscleCars", "Spawn Blue Muscle Car", &SpawnVehicleModel, "BMC");
        self addOption("SpawnMuscleCars", "Spawn Green Muscle Car", &SpawnVehicleModel, "GMC");
        self addOption("SpawnMuscleCars", "Spawn Orange Muscle Car", &SpawnVehicleModel, "OMC");
        self addOption("SpawnMuscleCars", "Spawn Red Muscle Car", &SpawnVehicleModel, "RMC");
        self addOption("SpawnMuscleCars", "Spawn White Muscle Car", &SpawnVehicleModel, "WMC");
        self addOption("SpawnMuscleCars", "Spawn Yellow Muscle Car", &SpawnVehicleModel, "RMC");
        self addOption("SpawnMuscleCars", "Spawn Black Muscle Car", &SpawnVehicleModel, "BMC2");

        self createMenu("SpawnMotorcycles", "Motorcycles");
        self addOption("SpawnMotorcycles", "Spawn White Motorcycle", &SpawnVehicleModel, "WM1");
        self addOption("SpawnMotorcycles", "Spawn Grey Motorcycle", &SpawnVehicleModel, "GM1");
        self addOption("SpawnMotorcycles", "Spawn Green Motorcycle", &SpawnVehicleModel, "GM2");
        self addOption("SpawnMotorcycles", "Spawn Dark Motorcycle", &SpawnVehicleModel, "DM1");
        self addOption("SpawnMotorcycles", "Spawn Light Grey Motorcycle", &SpawnVehicleModel, "LG1");

        self createMenu("SpawnHelicopters", "Helicopters");
        self addOption("SpawnHelicopters", "Spawn Helicopter 1", &SpawnVehicleModel, "H1");
        self addOption("SpawnHelicopters", "Spawn Helicopter 2", &SpawnVehicleModel, "H2");
        self addOption("SpawnHelicopters", "Spawn Helicopter 3", &SpawnVehicleModel, "H3");
        self addOption("SpawnHelicopters", "Spawn Helicopter 4", &SpawnVehicleModel, "H4");

        self createMenu("SpawnTanks", "Tanks");
        self addOption("SpawnTanks", "Spawn Dark Grey Tank", &SpawnVehicleModel, "TankDarkGrey");
        self addOption("SpawnTanks", "Spawn Green Tank", &SpawnVehicleModel, "TankGreen");
        self addOption("SpawnTanks", "Spawn Light Grey Tank", &SpawnVehicleModel, "TankLightGrey");
        self addOption("SpawnTanks", "Spawn White Tank", &SpawnVehicleModel, "TankWhite");

        self createMenu("SpawnATVs", "ATVs");
        self addOption("SpawnATVs", "Spawn ATV 1", &SpawnVehicleModel, "ATV1");
        self addOption("SpawnATVs", "Spawn ATV 2", &SpawnVehicleModel, "ATV2");
        self addOption("SpawnATVs", "Spawn Green ATV", &SpawnVehicleModel, "ATVGreen");
        self addOption("SpawnATVs", "Spawn Police ATV", &SpawnVehicleModel, "ATVPolice");

        self createMenu("SpawnCargoTrucks", "Cargo Trucks");
        self addOption("SpawnCargoTrucks", "Spawn Dark Cargo Truck", &SpawnVehicleModel, "CargoDark");
        self addOption("SpawnCargoTrucks", "Spawn Green Cargo Truck", &SpawnVehicleModel, "CargoGreen");
        self addOption("SpawnCargoTrucks", "Spawn Grey Cargo Truck", &SpawnVehicleModel, "CargoGrey");

        self createMenu("SpawnSUVs", "SUVs");
        self addOption("SpawnSUVs", "Spawn Police SUV", &SpawnVehicleModel, "SUVPolice");
        self addOption("SpawnSUVs", "Spawn Black SUV", &SpawnVehicleModel, "SUVBlack");
        self addOption("SpawnSUVs", "Spawn Grey SUV", &SpawnVehicleModel, "SUVGrey");
        self addOption("SpawnSUVs", "Spawn Silver SUV", &SpawnVehicleModel, "SUVSilver");
        self addOption("SpawnSUVs", "Spawn White SUV", &SpawnVehicleModel, "SUVWhite");
        self addOption("SpawnSUVs", "Spawn Black Light SUV", &SpawnVehicleModel, "SUVBlackLight");

        self createMenu("SpawnBoats", "Boats");
        self addOption("SpawnBoats", "Black Raft", &SpawnVehicleModel, "BlackRaft");
        self addOption("SpawnBoats", "Grey Raft", &SpawnVehicleModel, "GreyRaft");
        
        if(level.CurrentMap == "wz_open_skyscrapers"){
            self addOption("SpawnBoats", "Tan Military Boat", &SpawnVehicleModel, "TanBoat");
            self addOption("SpawnBoats", "Tan Military Boat", &SpawnVehicleModel, "BlackBoat");
            self addOption("SpawnBoats", "Police Military Boat", &SpawnVehicleModel, "PoliceBoat");
        }
    }
}

init_vehicles() {
    self.Vehicles = array(
        array("HMC", #"hash_4e73f59c7e21ce5a"), array("BMC", #"hash_2f8f4f949bf9ac15"),
        array("GMC", #"hash_15ddcb948d817b45"), array("OMC", #"hash_516b7a9466fa5c12"),
        array("RMC", #"hash_25efdc944e4cca5b"), array("WMC", #"hash_cd755944056a13d"),
        array("YMC", #"hash_56e75c94213b20da"), array("BMC2", #"hash_2f8f41949bf9944b"),

        array("WM1", #"hash_6125436f40323d0c"), array("GM1", #"hash_27cb5ec4239072e2"),
        array("GM2", #"hash_1420be7cd22fba24"), array("DM1", #"hash_7450e3a35eaf7c7d"),
        array("LG1", #"hash_187ccca8e5fca987"), array("DM2", #"hash_7709d71ab3699f7e"),

        array("H1", #"hash_371dca31a8d2a390"), array("H2", #"hash_1f38eb47b13ae0a2"),
        array("H3", #"hash_7473bb4a4fe9a17f"), array("H4", #"hash_a32b2557c188dbe"),

        array("TankDarkGrey", #"hash_660785b539889002"), array("TankGreen", #"hash_54bf3cd56e8c5c4a"),
        array("TankLightGrey", #"hash_6fdb3b0114439974"), array("TankWhite", #"hash_327d1f9834b6b91e"),

        array("ATV1", #"hash_232aa3a4e81249c6"), array("ATV2", #"hash_1d6e04a52d9a5fe2"),
        array("ATVGreen", #"hash_7acdf9a4d20bca08"), array("ATVPolice", #"hash_2c40642bbbab460d"),

        array("CargoDark", #"hash_50df12a3f608295f"), array("CargoGreen", #"hash_2321fdb723c1833e"),
        array("CargoGrey", #"hash_1207be62f5586002"),

        array("SUVPolice", #"hash_54469210eb79f8fa"), array("SUVBlack", #"hash_fd30bfe9c72da01"),
        array("SUVGrey", #"hash_762e82fe8e052b0e"), array("SUVSilver", #"hash_6a5a5607b259798f"),
        array("SUVWhite", #"hash_6d35ebfe40e6564f"), array("SUVBlackLight", #"hash_2e86e4a61f2237f6"),

        array("BlackRaft", "vehicle_boct_mil_boat_tactical_raft_wz_blk"),
        array("GreyRaft", "vehicle_boct_mil_boat_tactical_raft_wz_blk"),
        array("GreenRaft", "vehicle_boct_mil_boat_tactical_raft_wz_gry"),
        array("TanBoat", "vehicle_boct_mil_boat_pbr_wz_tan"),
        array("PoliceBoat", "vehicle_boct_mil_boat_pbr_wz_police"),
        array("BlackBoat", "vehicle_boct_mil_boat_pbr_wz_black"),

        array("MQT", "archetype_mini_quadtank_mp"), array("CHC", #"hash_3b01d9d0e5525c7e"),
        array("GSP", "veh_t8_ac130_gunship_mp"), array("RCX", "vehicle_t8_drone_recon"),
        array("THC", "vehicle_t8_mil_helicopter_transport_mp"), array("TURR", "spawner_bo3_mini_raps"),
        array("CHHH", #"hash_472293f2e996f42d")
    );
}

SpawnVehicleModel(VehicleItem) {
    foreach (entry in self.Vehicles) {
        if (entry[0] == VehicleItem) {
            AssetLoaded = isassetloaded("vehicle", VehicleItem);
            Look = self GetLookPosition();
            Vehicle = spawnvehicle(entry[1], Look, (0, 0, 0));
            Vehicle makeusable();

            if (isairborne(Vehicle)) {
                Vehicle setrotorspeed(1.0);
            }
            return;
        }
    }
}