// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract DMMS {
    struct patient {
        string name;
        string addres;
        uint phoneNo;
        string bloodGroup;
        uint emergencyContact;
        uint[] treatmentId;
        uint treatmentCount;
    }
    
 struct treatment {
    uint patient_id;
    uint doctor_id;
    string diagnosis;
    string[] medicines;
    string[] medicineBrands;
    uint[] dosages;
    string[] medicineAdministrations;
    string doctorNotes;
    string med_duration;
    uint timestamp;
}
    struct doctor {
        uint doc_id;
        string name;
        string practice_type;
        string area_of_expertize;
        uint phone_no;
        string clinicAddress;
    }
    
    struct Prescription {
        string[] medicines;
        uint[] dosages;
    }
    
    mapping (uint => uint) entitie;
    mapping (uint => patient) p_info;
    mapping (address => uint) addresstoId;
    mapping (uint => address) IdtoAdress;
    mapping (uint => treatment) tid;
    mapping (uint => doctor) did;
    mapping (address => bool) public addressToDoctor;
    mapping (string => string[]) interactions;
    mapping (uint => Prescription) patientPrescriptions;
    mapping(uint => treatment) tidToTreatment;
    mapping(uint => uint[]) patientTreatments;
   
    event TreatmentCompleted(uint treatmentId);

    function addPatientInfo(uint _id, string memory _name, string memory _addres, uint _phoneNo, string memory _bloodGroup, uint _emergencyContact) public {
        require(entitie[_id] == 0 && addresstoId[msg.sender] == 0, "Account already exists!!! Use a Different Account");
        p_info[_id] = patient(_name, _addres, _phoneNo, _bloodGroup, _emergencyContact, new uint[](0), 0);
        entitie[_id] = 1;
        addresstoId[msg.sender] = _id;
        IdtoAdress[_id] = msg.sender;
    }

    function getPatientInfo(uint id) public view returns (string memory, string memory, uint, string memory, uint) {
        require(entitie[id] == 1 || entitie[id] == 2, "Patient does not exist");
        patient memory p = p_info[id];
        return (p.name, p.addres, p.phoneNo, p.bloodGroup, p.emergencyContact);
    }

uint private treatmentCounter = 0;

function createTreatmentID() public returns (uint) {
    treatmentCounter++;
    require(treatmentCounter <= 999999999, "Maximum number of treatments reached");
    return treatmentCounter;
}


function TreatPatient(uint patient_id, uint doctor_id, string memory diagnosis, string[] memory medicines, string[] memory medicineBrands, uint[] memory dosages, string[] memory medicineAdministrations, string memory doctorNotes, string memory med_duration) public returns (uint) {
    uint val = addresstoId[msg.sender];
    require(entitie[patient_id] == 1 || entitie[val] == 2);

    // Check for medicine interactions if the patient has previous treatments
    if (p_info[patient_id].treatmentCount > 0) {
        uint lastTreatmentId = p_info[patient_id].treatmentId[p_info[patient_id].treatmentCount - 1];
        treatment memory lastTreatment = tidToTreatment[lastTreatmentId];
        require(!checkInteractions(lastTreatment.medicines, medicines), "Medicine interaction detected. Please change the medicine.");
    }

    uint _tid = createTreatmentID();
    treatment memory newTreatment = treatment(patient_id, doctor_id, diagnosis, medicines, medicineBrands, dosages, medicineAdministrations, doctorNotes, med_duration, block.timestamp);
    tidToTreatment[_tid] = newTreatment;
    p_info[patient_id].treatmentId.push(_tid);
    p_info[patient_id].treatmentCount++;
    patientTreatments[patient_id].push(_tid);
    require(isDoctor(msg.sender), "Only doctors can treat patients.");

    emit TreatmentCompleted(_tid);
    return _tid;
}
function getTreatmentDetails(uint _tid) public view returns (uint timestamp, uint p_id, string memory p_name, uint d_id, string memory d_name, string memory diagnosis, string[] memory medicines, string[] memory medicineBrands, uint[] memory dosages, string[] memory medicineAdministrations, string memory doctorNotes, string memory med_duration) {
    treatment memory t = tidToTreatment[_tid];

    p_id = t.patient_id;
    d_id = t.doctor_id;
    p_name = p_info[p_id].name;
    d_name = did[d_id].name;
    diagnosis = t.diagnosis;
    medicines = t.medicines;
    medicineBrands = t.medicineBrands;
    dosages = t.dosages;
    medicineAdministrations = t.medicineAdministrations;
    doctorNotes = t.doctorNotes;
    med_duration = t.med_duration;
    timestamp = t.timestamp;
}

function getPatientTreatments(uint patient_id) public view returns (treatment[] memory) {
    uint[] storage treatmentIds = patientTreatments[patient_id];
    treatment[] memory treatments = new treatment[](treatmentIds.length);

    for (uint i = 0; i < treatmentIds.length; i++) {
        uint treatmentId = treatmentIds[i];

        treatments[i] = tidToTreatment[treatmentId];
    }

    return treatments;
}


    function treatmentExists(uint patient_id, uint treatment_id) public view returns (bool) {
        uint[] storage treatments = p_info[patient_id].treatmentId;
        for (uint i = 0; i < treatments.length; i++) {
            if (treatments[i] == treatment_id) {
                return true;
            }
        }
        return false;
    }
    function patientExists(uint patient_id) public view  returns (bool) {
        return p_info[patient_id].treatmentCount > 0;
    }

    function isDoctor(address sender) public  view returns (bool) {
        // Check if the sender's ID is in the `did` mapping
        return did[addresstoId[sender]].doc_id != 0;
    }

    function addDoctor(uint doc_id, string memory name, string memory practice_type, string memory area_of_expertise, uint phone_no, string memory clinicAddress) public {
        require(entitie[doc_id] == 0 || addresstoId[msg.sender] == 0, "Account already exists!!! Use a Different Account");
        require(!addressToDoctor[msg.sender], "Only one doctor can register per account address");
        did[doc_id] = doctor(doc_id, name, practice_type, area_of_expertise, phone_no, clinicAddress);
        entitie[doc_id] = 2;
        addresstoId[msg.sender] = doc_id;
        IdtoAdress[doc_id] = msg.sender;
        addressToDoctor[msg.sender] = true;
    }

    function getDoctorDetails(uint _d_id) public view returns (uint, string memory, string memory, string memory, uint, string memory) {
        require(entitie[_d_id] == 2, "Doctor does not exist");
        uint val = addresstoId[msg.sender];
        require(entitie[val] == 2 || entitie[val] == 1, "Access denied");
        doctor memory d = did[_d_id];
        return (d.doc_id, d.name, d.practice_type, d.area_of_expertize, d.phone_no, d.clinicAddress);
    }

function modifyPrescription(uint treatment_id, string[] memory medicines, string[] memory medicineBrands, uint[] memory dosages, string[] memory medicineAdministrations, string memory duration, string memory doctorNotes) public {
    require(isDoctor(msg.sender), "Only doctors can modify prescriptions");

    treatment storage t = tidToTreatment[treatment_id];
    require(t.patient_id != 0, "Treatment does not exist");
    require(!checkInteractions(t.medicines, medicines), "New medicines interact with current medicines");

    t.medicines = medicines;
    t.medicineBrands = medicineBrands;
    t.dosages = dosages;
    t.medicineAdministrations = medicineAdministrations;
    t.med_duration = duration;
    t.doctorNotes = doctorNotes;
}


    function checkInteractions(string[] memory medicines, string[] memory newMedicines) public returns (bool) {
        interactions["Advil"] = ["Warfarin"];
        interactions["Bactrim"] = ["Warfarin"];
        interactions["Panadol"] = ["Ibuprofen", "Aspirin"];
        interactions["Ibuprofen"] = ["Panadol", "Aspirin"];
        interactions["Aspirin"] = ["Panadol", "Ibuprofen"];
        interactions["Simvastatin"] = ["Fluconazole"];
        interactions["Fluconazole"] = ["Simvastatin"];

        for (uint i = 0; i < medicines.length; i++) {
            string memory previousMedicine = medicines[i];

            for (uint j = 0; j < newMedicines.length; j++) {
                string memory newMedicine = newMedicines[j];

                if (keccak256(abi.encodePacked(interactions[previousMedicine][j])) == keccak256(abi.encodePacked(newMedicine))) {
                    revert("Interaction detected. Please change the medicine.");
                }
            }
        }
        return false;
    }
    
}
