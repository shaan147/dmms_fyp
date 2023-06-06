// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "../contracts/DMMS.sol";

contract TestDMMS {
    DMMS dmms;
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

    function beforeEach() public {
        dmms = new DMMS();
    }

    function testAddPatientInfo() public {
        dmms.addPatientInfo(1, "John Doe", "123 Main St", 1234567890, "A+", 9876543210);

        (string memory name, string memory addres, uint phoneNo, string memory bloodGroup, uint emergencyContact) = dmms.getPatientInfo(1);

        require(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("John Doe")), "Patient name should match");
        require(keccak256(abi.encodePacked(addres)) == keccak256(abi.encodePacked("123 Main St")), "Patient address should match");
        require(phoneNo == 1234567890, "Patient phone number should match");
        require(keccak256(abi.encodePacked(bloodGroup)) == keccak256(abi.encodePacked("A+")), "Patient blood group should match");
        require(emergencyContact == 9876543210, "Patient emergency contact should match");
    }

 function testCreateTreatmentID() public {
    uint treatmentId = dmms.createTreatmentID();
    uint expectedTreatmentId = 1;
    require(treatmentId == expectedTreatmentId, "Treatment ID should match");
}

function testGetPatientInfo() public {
    // Add a patient
    dmms.addPatientInfo(1, "John Doe", "123 Main St", 1234567890, "A+", 9876543210);

    // Retrieve the patient info
    (string memory name, string memory addres, uint phoneNo, string memory bloodGroup, uint emergencyContact) = dmms.getPatientInfo(1);

    // Verify the patient info
    require(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("John Doe")), "Patient name should match");
    require(keccak256(abi.encodePacked(addres)) == keccak256(abi.encodePacked("123 Main St")), "Patient address should match");
    require(phoneNo == 1234567890, "Patient phone number should match");
    require(keccak256(abi.encodePacked(bloodGroup)) == keccak256(abi.encodePacked("A+")), "Patient blood group should match");
    require(emergencyContact == 9876543210, "Patient emergency contact should match");
}
function testAddDoctor() public {
    // Add a doctor
    dmms.addDoctor(1, "Dr. John Smith", "General Practice", "Internal Medicine", 1234567890, "123 Main St");

    // Retrieve the doctor details
    (uint docId, string memory name, string memory practiceType, string memory areaOfExpertise, uint phoneNo, string memory clinicAddress) = dmms.getDoctorDetails(1);

    // Verify the doctor details
    require(docId == 1, "Doctor ID should match");
    require(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("Dr. John Smith")), "Doctor name should match");
    require(keccak256(abi.encodePacked(practiceType)) == keccak256(abi.encodePacked("General Practice")), "Practice type should match");
    require(keccak256(abi.encodePacked(areaOfExpertise)) == keccak256(abi.encodePacked("Internal Medicine")), "Area of expertise should match");
    require(phoneNo == 1234567890, "Doctor phone number should match");
    require(keccak256(abi.encodePacked(clinicAddress)) == keccak256(abi.encodePacked("123 Main St")), "Clinic address should match");
}

function testGetDoctorDetails() public {
    // Add a doctor
    dmms.addDoctor(1, "Dr. John Smith", "General Practice", "Internal Medicine", 1234567890, "123 Main St");

    // Retrieve the doctor details
    (uint docId, string memory name, string memory practiceType, string memory areaOfExpertise, uint phoneNo, string memory clinicAddress) = dmms.getDoctorDetails(1);

    // Verify the doctor details
    require(docId == 1, "Doctor ID should match");
    require(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("Dr. John Smith")), "Doctor name should match");
    require(keccak256(abi.encodePacked(practiceType)) == keccak256(abi.encodePacked("General Practice")), "Practice type should match");
    require(keccak256(abi.encodePacked(areaOfExpertise)) == keccak256(abi.encodePacked("Internal Medicine")), "Area of expertise should match");
    require(phoneNo == 1234567890, "Doctor phone number should match");
    require(keccak256(abi.encodePacked(clinicAddress)) == keccak256(abi.encodePacked("123 Main St")), "Clinic address should match");
}


function testIsDoctor() public {
    // Add a doctor
    dmms.addDoctor(1, "Dr. John Smith", "General Practice", "Internal Medicine", 1234567890, "123 Main St");

    // Check if sender is a doctor
    bool isDoctor = dmms.isDoctor(address(this)); // Use the contract's address as the sender

    // Verify if sender is a doctor
    require(isDoctor, "Sender should be a doctor");
}

}
