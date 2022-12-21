import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/favorite/favorite_model.dart';
import 'package:text/ui/theme/theme_app.dart';

import '../../../object/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FavoriteModel>();
    final items = model.items;
    final product = context.read<ProductModel>();
    return Scaffold(
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 15,
                  child: Text('${index + 1}'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(ThemeSize.kRadius))),
                    child: ListTile(
                      onTap: () => product.showDetail(context, items[index]),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                      title: Text(
                        items[index].name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: InkWell(
                        onTap: () {
                          model.justdelfavorite(items[index]);
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                      leading: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(ThemeSize.kRadius)),
                        child: Image(
                          image: AssetImage(
                            items[index].imgUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
      ),
    );
  }
}
