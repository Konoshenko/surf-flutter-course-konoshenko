import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/res.dart';
import 'package:places/ui/screen/sight_details_screen.dart';

class SightCardMeta {
  SightCardMeta(this.sight, {this.wantVisit = false, this.visited = false});

  Place sight;
  bool wantVisit;
  bool visited;

  SightCardMeta copyWith({bool wantVisit, bool visited}) {
    return SightCardMeta(
      sight,
      wantVisit: wantVisit ?? this.wantVisit,
      visited: visited ?? this.visited,
    );
  }
}

enum SightCardState { drag, simple }

class SightCard extends StatefulWidget {
  const SightCard(
    this.sightMeta, {
    Key key,
    this.onDelete,
    this.sightCardState = SightCardState.simple,
  }) : super(key: key);

  final SightCardMeta sightMeta;
  final VoidCallback onDelete;
  final SightCardState sightCardState;

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: _cardSight(context),
    );
  }

  Widget _cardSight(BuildContext context) {
    final isDismissed = widget.sightMeta.visited || widget.sightMeta.wantVisit;

    return Stack(
      children: <Widget>[
        const Positioned.fill(child: _DismissBackground()),
        isDismissed
            ? Dismissible(
                onDismissed: (value) {
                  widget.onDelete();
                },
                direction: DismissDirection.endToStart,
                key: ObjectKey(widget.sightMeta),
                child: _cardBody(context),
              )
            : _cardBody(context),
      ],
    );
  }

  ClipRRect _cardBody(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(children: [
          Column(
            children: [
              _cardHeaderImage(context),
              _cardContent(context),
            ],
          ),
          Positioned.fill(
            child: _cardClickArea(context),
          ),
          if (widget.sightCardState == SightCardState.simple)
            Positioned(
              right: 16,
              top: 16,
              child: SightCardTools(
                widget.sightMeta,
                onDelete: widget.onDelete,
              ),
            ),
        ]),
      ),
    );
  }

  Widget _cardClickArea(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => showModalBottomSheet<void>(
          context: context,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          isScrollControlled: true,
          builder: (_) => SightDetailsScreen(sight: widget.sightMeta),
        ),
      ),
    );
  }

  Widget _cardContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            widget.sightMeta.sight.name,
            maxLines: 2,
            style: Theme.of(context).primaryTextTheme.subtitle1,
          ),
          const SizedBox(height: 4),
          _buildDetailInfo(context, widget.sightMeta),
          if (widget.sightMeta.wantVisit || widget.sightMeta.visited)
            _buildSightStatus(context),
        ],
      ),
    );
  }

  Widget _cardHeaderImage(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.sightMeta.sight.urls.first,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return Center(
                child: CupertinoActivityIndicator.partiallyRevealed(
                  progress: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Text(
              widget.sightMeta.sight.placeType,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSightStatus(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 2),
          Text(
            'закрыто до 09:00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText1
                .copyWith(color: lmSecondary2Color),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDetailInfo(BuildContext context, SightCardMeta sightMeta) {
    if (sightMeta.visited) {
      return Text(
        'Цель достигнута 12 окт. 2020',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).primaryTextTheme.bodyText1,
      );
    }
    if (sightMeta.wantVisit) {
      return Text(
        'Запланировано на 12 окт. 2020',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .primaryTextTheme
            .bodyText1
            .copyWith(color: lmGreenColor),
      );
    }

    return Text(
      sightMeta.sight.description,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).primaryTextTheme.bodyText1,
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: lmRedColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconBucket,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 8),
            Text(
              'Удалить',
              style: Theme.of(context)
                  .primaryTextTheme
                  .caption
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class SightCardTools extends StatelessWidget {
  const SightCardTools(this.sightMeta, {this.onDelete, Key key})
      : super(key: key);

  final SightCardMeta sightMeta;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (sightMeta.visited)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: _BtnToolIcon(
              icon: iconShare,
              onClick: () {
                //print('on click iconShare');
              },
            ),
          ),
        if (sightMeta.wantVisit)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: _BtnToolIcon(
              icon: iconCalendar,
              onClick: () {
                //print('on click iconCalendar');
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: (sightMeta.visited || sightMeta.wantVisit)
              ? _BtnToolIcon(icon: iconClose, onClick: onDelete)
              : _BtnToolIcon(
                  icon: iconHeart,
                  onClick: () {
                    //print('on click iconShare');
                  },
                ),
        ),
      ],
    );
  }
}

class _BtnToolIcon extends StatelessWidget {
  final VoidCallback onClick;
  final String icon;

  const _BtnToolIcon({this.icon, this.onClick, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onClick,
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
