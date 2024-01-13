String mapFirebaseCode(String code) {
  switch (code) {
    //sign in errors
    case 'invalid-email':
      return 'The email is not valid';
    case 'invalid-credential':
      return 'The user do not exist or has expired';
    case 'user-disabled':
      return 'The user has been disabled';
    //register errors
    case 'user-not-found':
      return 'There is no user account with the given email';
    case 'email-already-in-use':
      return 'The email is already in use';
    case 'operation-not-allowed':
      return 'The operation cannot be performed';
    case 'weak-password':
      return 'The password is not strong enough';
    //others errors
    case 'no-app':
      return 'The application do not exist';
    case 'channel-error':
      return 'An error has occurred while establishing connection to the channel';
    default:
      return 'Error: $code';
  }
}
