import 'package:flutter/material.dart';
import 'package:rick_morty_app/ui/characters_list/view_model/characters_viewmodel.dart';

class CharactersListScreen extends StatelessWidget {
  final CharactersViewModel viewModel;

  CharactersListScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.92), 
          child: Container(
            height: 130.96,
            color: Colors.deepPurpleAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.menu), onPressed: (){}, iconSize: 20.97, padding: EdgeInsets.symmetric(horizontal: 13.48, vertical: 17.48), color: Colors.white,),
                Column(children: [
                                  IconButton(icon: Icon(Icons.menu), onPressed: (){}, iconSize: 76.99, padding: EdgeInsets.symmetric(horizontal: 39.48, vertical: 6), color: Colors.white,),
                                  Text('rick and morty api')

                ],),
                IconButton(icon: Icon(Icons.person), onPressed: (){}, iconSize: 20.97, padding: EdgeInsets.symmetric(horizontal: 13.48, vertical: 17.48), color: Colors.white,),



              ],
            )
          )),
          
//           PreferredSize(
//             preferredSize: Size.fromHeight(130.92), // altura desejada
//             child: AppBar(
//               leading: Padding(
//                 padding: const EdgeInsets.only(left: 13.98, top: 17.48, bottom: 17.48),
//                 child: SizedBox(width: 20.97, height: 20.97, child: IconButton(onPressed: (){}, icon: Icon(Icons.menu, color: Colors.white,))),
//               ),
//               actions: [
//                 IconButton(onPressed: () => print('A'), icon: Icon(Icons.abc), color: Colors.white,)
//               ],
//               backgroundColor: Colors.deepPurple,
//               // flexibleSpace: Row(
//               //                   children: [IconButton(onPressed: () => print('A'), icon: Icon(Icons.abc, size: 50, color: Colors.white))
//               //                   ]
//               // ),
//   ),
// ),
          body: Center(
            child: Text('olá mundo'),
          ),
        ),
      ),
    );
  }
  
}