part of 'widgets.dart';

Widget buildInfo(User user) {
  int age = calculateAge(DateTime.parse(user.birthday));

  return Column(
    children: <Widget>[
      Text(
        '${user.firstName} ${user.lastName}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'Edad $age años',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      const SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.email_outlined, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      const SizedBox(height: 4),
      if (user.userType == 'Nutriólogo') _nutritionistInfo(user),
      if (user.userType == 'Paciente') _patientInfo(user),

      //if(user.userType == 'Nutriólogo')
    ],
  );
}

Widget _nutritionistInfo(User user) {
  Nutritionist profile =
      Nutritionist(user.nutritionistProfile as ResourceObject);

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_city_outlined, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            profile.address,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.credit_card_rounded, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            'No. Cédula: ${profile.identificationCard}',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.phone, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            profile.phoneNumber,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ],
  );
}

Widget _patientInfo(User user) {
  Patient profile = Patient(user.patientProfile as ResourceObject);

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.phone, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            profile.phoneNumber,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ],
  );
}
