
const String baseUrl="http://10.0.2.2/educational_institute/api";
const String serverAi ="http://10.0.2.2:5000/predict";

// const String baseUrl="http://192.168.72.51/educational_institute/api";
// const String serverAi ="http://192.168.72.51:5000/predict";

// const String baseUrl="http://192.168.72.128:9000/educational_institute/api";
// const String serverAi ="http://192.168.72.128:5000/predict";

const String studentUrl="$baseUrl/student";
const String markUrl="$baseUrl/marks";
const String alertUrl="$baseUrl/alerts";

const String loginUrl="$baseUrl/student/login.php";
const String loginSupervisorUrl="$baseUrl/supervisors/login.php";

const String registerUrl="$studentUrl/registration.php";
const String getMarksUrl="$markUrl/getAllMark.php";
const String getAlertsUrl="$alertUrl/getAllAlert.php";

const String getFilePdf="$baseUrl/information_bank/getFilePdf.php";

const String getDisclosure="$baseUrl/financial_disclosure/getDisclosure.php";
const String addDisclosure="$baseUrl/financial_disclosure/addDisclosure.php";

const String addAlert="$baseUrl/alerts/addAlert.php";

const String addSection="$baseUrl/section/addSection.php";

const String getStatus="$baseUrl/marks/getStudentStatus.php";

const String getAllStudentT="$baseUrl/marks/getAllStudentT.php";
const String getAllStudentB="$baseUrl/marks/getAllStudentB.php";
const String getAllSubjectT="$baseUrl/marks/getAllSubjectT.php";
const String getAllSubjectB="$baseUrl/marks/getAllSubjectB.php";
const String addMarkStudent="$baseUrl/marks/addMark.php";

const String addPackage="$baseUrl/registration_records/addFullPackage.php";

const String addTeacherAPI ="$baseUrl/teachers/addTeachers.php";
const String getAllTeachers ="$baseUrl/teachers/getTeachers.php";
const String getTeacherSubjects ="$baseUrl/teachers/getSubjectTeacher.php";
const String addTeachingSchedule ="$baseUrl/teachers/addTeacherDates.php";


const String getClassesByGrade ="$baseUrl/section/getSection.php";

const String getSubjectsByGrade ="$baseUrl/subject/getSubjectsByClass.php";

const String getTeachersBySubject ="$baseUrl/teachers/getTeachersBySubject.php";

const String addTeachingSection ="$baseUrl/teachers/addTeacherToSection.php";

const String getSectionDetails ="$baseUrl/section/getSectionDetails.php";

const String getSubjectStudent ="$baseUrl/registration_records/getSubjectStudent.php";

const String getAllStudentByClass ="$baseUrl/student/getAllStudentByClass.php";

const String addPayments ="$baseUrl/financial_disclosure/addDisclosure.php";

const String addPdf ="$baseUrl/information_bank/addFilePdf.php";





const Map<String,String> headerApi={"Content-Type": "application/json"};