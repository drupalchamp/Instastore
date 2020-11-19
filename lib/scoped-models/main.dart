import 'package:scoped_model/scoped_model.dart';
import 'package:instastore/scoped-models/user.dart';
import 'package:instastore/scoped-models/cart.dart';

class MainModel extends Model with CartModel, UserModel {
}
