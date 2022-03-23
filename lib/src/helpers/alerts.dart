part of 'helpers.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text('Espere...'),
      content: LinearProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}

showConfirmAlert({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String confirmText,
  required String cancelText,
  required void Function() onTap,
}) {
  CoolAlert.show(
    context: context,
    borderRadius: 30,
    title: title,
    type: CoolAlertType.confirm,
    text: subtitle,
    confirmBtnColor: Theme.of(context).colorScheme.secondary,
    barrierDismissible: false,
    cancelBtnText: cancelText,
    confirmBtnText: confirmText,
    onConfirmBtnTap: onTap,
  );
}

showErrorAlert(BuildContext context, String title, String subtitle) {
  CoolAlert.show(
    context: context,
    borderRadius: 30,
    title: title,
    type: CoolAlertType.error,
    text: subtitle,
    confirmBtnColor: Theme.of(context).colorScheme.secondary,
  );
}

showSuccessAlert(BuildContext context, String title, String subtitle) {
  CoolAlert.show(
    context: context,
    borderRadius: 30,
    title: title,
    type: CoolAlertType.success,
    text: subtitle,
    confirmBtnColor: Theme.of(context).colorScheme.secondary,
  );
}
