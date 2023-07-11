import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/core/utils/modal_manager_utils.dart";

class AuthService {
  Future<User?> userIsLoggedIn() async {
    if (FirebaseAuth.instance.currentUser == null) {
      debugPrint("O usuário está desconectado no momento!");
      return null;
    } else {
      debugPrint("O usuário está conectado!");
      return FirebaseAuth.instance.currentUser;
    }
  }

  Future<(UserCredential?, String)> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return (credential, "Cadastro realizado com sucesso!");
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return (null, "A senha fornecida é muito fraca.");
      } else if (e.code == "email-already-in-use") {
        return (null, "Já existe uma conta cadastrada com este e-mail.");
      } else if (e.code == "invalid-email") {
        return (null, "Conta de e-mail inválida.");
      } else if (e.code == "operation-not-allowed") {
        return (null, "Operação não permitida.");
      }
    } catch (e) {
      return (null, "Ocorreu um erro! Tente novamente. $e");
    }
    return (null, "");
  }

  Future<(UserCredential?, String)> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return (credential, "Login realizado com sucesso!");
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return (null, "Nenhum usuário encontrado para esse e-mail.");
      } else if (e.code == "wrong-password") {
        return (null, "Senha incorreta fornecida para esse usuário.");
      } else if (e.code == "invalid-email") {
        return (null, "E-mail inválido.");
      } else if (e.code == "user-disabled") {
        return (null, "Usuário desabilitado.");
      } else if (e.code == "user-not-found") {
        return (null, "Usuário não foi encontrado.");
      }
    } catch (e) {
      return (null, "Ocorreu um erro! Tente novamente. $e");
    }

    return (null, "");
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseAuthException catch (e) {
      ModalManagerUtils.closeModal();
      if (e.code == "auth/invalid-email") {
        CCSnackBar.error(message: "Endereço de e-mail não é válido.");
      } else if (e.code == "auth/missing-android-pkg-name") {
        CCSnackBar.error(
            message:
                "Um nome de pacote Android deve ser fornecido se o aplicativo Android precisar ser instalado.");
      } else if (e.code == "auth/missing-continue-uri") {
        CCSnackBar.error(
            message:
                "Uma URL de continuação deve ser fornecida na solicitação.");
      } else if (e.code == "auth/missing-ios-bundle-id") {
        CCSnackBar.error(
            message:
                "Um ID de pacote iOS deve ser fornecido se um ID da App Store for fornecido.");
      } else if (e.code == "auth/invalid-continue-uri") {
        CCSnackBar.error(
            message:
                "A URL de continuação fornecida na solicitação é inválida.");
      } else if (e.code == "auth/user-not-found") {
        CCSnackBar.error(
            message: "Nenhum usuário correspondente ao endereço de e-mail.");
      }
    } catch (e) {
      ModalManagerUtils.closeModal();
      CCSnackBar.error(message: "Ocorreu um erro! Tente novamente.");
    }

    return false;
  }

  Future<void> deleteUser({required UserCredential credential}) async {
    await credential.user?.delete();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void profileUser(User user) {
    debugPrint(user.uid);
    debugPrint(user.displayName);
    debugPrint(user.email);
    debugPrint(user.photoURL);
  }
}
