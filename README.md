# DMMS


Welcome to DMMS (Decentralized Medication History Management)! This decentralized application is built using Truffle and React.

## Prerequisites

Before getting started, ensure you have the following prerequisites installed on your machine:

- Node.js and npm
- Ganache (for local development)
- Truffle Framework
- MetaMask or any other Ethereum wallet extension

## Installation
Clone the repository:
git clone <repository-url>
cd dmms
  
Install dependencies:
npm install

Smart Contract Deployment
Start Ganache:

Open Ganache and start a local blockchain network. Make note of the network details, such as the RPC server URL and port number.

Configure Truffle:

Update the Truffle configuration file truffle-config.js or truffle.js with the appropriate network settings. 
Ensure that the network configuration matches your Ganache network details.
  
truffle compile
truffle migrate --reset

Running the React App
Start the development server:
cd client
npm start
 
Usage
Registering a Patient and a Doctor
On the homepage, click on the "Register" button.
Fill out the required information in the registration form to create a new patient or doctor account.
Click the "Submit" button to register.

Doctor's Functions
Prescribing Medication
Log in to the dApp using your doctor credentials.
Navigate to the "Prescription" section.
Click on the "Create Prescription" button.
Fill out the details of the prescription, including the patient's information, medication details, dosage, and duration.
Click the "Submit" button to prescribe the medication.
It will generate prescription ID. It will be used to view and modify prescriptions.
Viewing Prescriptions
Log in to the dApp using your doctor credentials.
Go to the "Prescription" section.
You will see a list of prescriptions associated with your account.
Click on a prescription to view its details, including the patient's information, prescribed medication, dosage, and duration.

Modifying a Prescription
Log in to the dApp using your doctor credentials.
Go to the "Prescription" section.
Locate the prescription you want to modify and click on it.
Update the necessary fields such as medication details, dosage, or duration.
Click the "Update" button to save the changes to the prescription.

Troubleshooting
If you encounter any issues while setting up or running the dApp, refer to the following troubleshooting tips:

Issue: Unable to Connect to Ganache
  
Solution 1: Check if Ganache is running and the RPC server details (URL and port) match the configuration in truffle-config.js or truffle.js.
Solution 2: Ensure that you have selected the correct network in your MetaMask or Ethereum wallet extension that corresponds to your Ganache network settings.
Solution 3: Verify that your firewall or antivirus software is not blocking the connection to the Ganache RPC server.

Issue: Smart Contract Deployment Failed
  
Solution 1: Double-check your Truffle configuration (truffle-config.js or truffle.js) to ensure that the network settings and contract details are correctly specified.
Solution 2: Confirm that Ganache is running and accessible with the correct network configuration.
Solution 3: Check for any compilation errors in your smart contracts by running truffle compile and resolving them before attempting deployment.

Issue: Unexpected Behavior or Error Messages
  
Solution 1: Review the console output in your web browser's developer tools (e.g., Chrome DevTools) for any error messages or warnings.
Solution 2: Consult the application logs, typically available in the browser console or the server terminal, to identify any errors or relevant information.
Solution 3: Search the project's issue tracker or online forums for similar issues and their resolutions. If necessary, post a detailed description of the problem to seek assistance from the community.

Issue: Dependency Errors or Version Mismatch

Solution 1: Run npm install to ensure that all dependencies are properly installed and up to date.
Solution 2: Verify that the required versions of Node.js, npm, and Truffle are compatible with the project's configuration. Refer to the project's documentation or the respective websites for version compatibility information.
Solution 3: Check for any conflicting dependencies in your project's package.json file and resolve them by updating or removing conflicting packages.

If the above troubleshooting tips do not resolve your issue, please seek assistance from the project's support channels or create an issue in the project's GitHub repository, providing detailed information about the problem you are facing, including any error messages or logs.
Remember to update this section with specific troubleshooting tips and solutions that are relevant to your dApp and the potential issues users may encounter during the setup or usage of your application.

Contact
If you encounter any issues, have questions, or need further assistance, please feel free to reach out to me.
You can contact me via email at Shaanemustafa8@gmail.com. I'll be happy to help!
