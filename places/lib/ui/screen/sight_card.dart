import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/res.dart';
import 'package:places/ui/screen/sight_details_screen.dart';

import 'select_category_screen.dart';

class SightCardMeta {
  Sight sight;
  bool wantVisit;
  bool visited;

  SightCardMeta(this.sight, {this.wantVisit = false, this.visited = false});

  SightCardMeta copyWith({bool wantVisit, bool visited}) {
    return SightCardMeta(
      this.sight,
      wantVisit: wantVisit ?? this.wantVisit,
      visited: visited ?? this.visited,
    );
  }
}

class SightCard extends StatefulWidget {
  final SightCardMeta sightMeta;
  final VoidCallback onDelete;

  SightCard(this.sightMeta, {Key key, this.onDelete}) : super(key: key);

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Card(
        margin: EdgeInsets.all(16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(children: [
          Column(
            children: [
              Container(
                  height: 96,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.sightMeta.sight.url,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CupertinoActivityIndicator.partiallyRevealed(
                              progress:
                                  loadingProgress.expectedTotalBytes != null
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
                          widget.sightMeta.sight.type.toText(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 108,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      widget.sightMeta.sight.name,
                      maxLines: 2,
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ),
                    SizedBox(height: 4),
                    _buildDetailInfo(context, widget.sightMeta),
                    if (widget.sightMeta.wantVisit || widget.sightMeta.visited)
                      _buildSightStatus(context),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
              child: new Material(
                  color: Colors.transparent,
                  child: new InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, SightDetailsScreen.routeName,
                        arguments: widget.sightMeta),
                  ))),
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              children: [
                SightCardTools(
                  widget.sightMeta,
                  onDelete: widget.onDelete,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildSightStatus(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 2,
          ),
          Text(
            'закрыто до 09:00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText1
                .copyWith(color: lmSecondary2Color),
          ),
          SizedBox(height: 12)
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
      sightMeta.sight.details,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).primaryTextTheme.bodyText1,
    );
  }
}

class SightCardTools extends StatelessWidget {
  final SightCardMeta sightMeta;
  final VoidCallback onDelete;

  const SightCardTools(this.sightMeta, {this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (sightMeta.visited)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: btnIcon(
                icon: iconShare,
                onClick: () {
                  print('on click iconShare');
                }),
          ),
        if (sightMeta.wantVisit)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: btnIcon(
                icon: iconCalendar,
                onClick: () {
                  print('on click iconCalendar');
                }),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: (sightMeta.visited || sightMeta.wantVisit)
              ? btnIcon(icon: iconClose, onClick: onDelete)
              : btnIcon(
                  icon: iconHeart,
                  onClick: () {
                    print('on click iconShare');
                  }),
        ),
      ],
    );
  }

  Widget btnIcon({icon, onClick}) {
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            onTap: onClick,
            child: SvgPicture.asset(icon)));
  }
}
