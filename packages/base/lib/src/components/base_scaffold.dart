part of base_lhe;

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    this.backgroundColor,
    this.body,
    this.backgroundImage,
    this.resizeToAvoidBottomInset,
    this.appBar, this.bottomNavigationBar,
  }) : super(key: key);

  final Color? backgroundColor;
  final Widget? body;
  final String? backgroundImage;
  final bool? resizeToAvoidBottomInset;
  final Widget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor ?? bg_4,
        bottomNavigationBar: bottomNavigationBar,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: appBar != null ? appBar! : const SizedBox.shrink(),
        ),
        body: Stack(
          children: [
            if ((backgroundImage ?? "").isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage!),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
            body ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
