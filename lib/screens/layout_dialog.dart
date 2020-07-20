import 'package:fast_shopping/l10n/l10n.dart';
import 'package:fast_shopping/widgets/widgets.dart';
import 'package:flutter/material.dart' hide SimpleDialog;

class LayoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: S.of(context).layout_dialog_title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _AppearanceButton(
                  title: S.of(context).layout_dialog_one_list_title,
                  preview: _OneListPreview(),
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _AppearanceButton(
                  title: S.of(context).layout_dialog_multiple_lists_title,
                  preview: _MultipleListsPreview(),
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            S.of(context).layout_dialog_content,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
      primaryButton: const SizedBox(),
    );
  }
}

class _AppearanceButton extends StatelessWidget {
  final String title;
  final Widget preview;
  final VoidCallback onTap;

  const _AppearanceButton({
    Key key,
    @required this.title,
    @required this.preview,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: preview,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OneListPreview extends StatelessWidget {
  const _OneListPreview();

  @override
  Widget build(BuildContext context) {
    final item = Container(
      height: 6,
      width: 100,
      color: Colors.white,
    );

    return Center(
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2), color: Colors.black12),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            item,
                            const SizedBox(height: 3),
                            Container(
                              height: 18,
                              width: 100,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 3),
                            item,
                            const SizedBox(height: 3),
                            item,
                            const SizedBox(height: 3),
                            item,
                            const SizedBox(height: 3),
                            item,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 2), color: Colors.black12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MultipleListsPreview extends StatelessWidget {
  const _MultipleListsPreview();

  @override
  Widget build(BuildContext context) {
    final item = Container(
      height: 6,
      width: 100,
      color: Colors.white,
    );

    return Center(
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2), color: Colors.black12),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            item,
                            const SizedBox(height: 3),
                            Container(
                              height: 18,
                              width: 100,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 3),
                            item,
                            const SizedBox(height: 3),
                            item,
                            const SizedBox(height: 3),
                            item,
                            const SizedBox(height: 3),
                            item,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 10,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 2), color: Colors.black12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
