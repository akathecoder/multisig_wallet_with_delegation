import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multisig_wallet_with_delegation/components/blockies/custom_blockie.dart';
import 'package:multisig_wallet_with_delegation/components/general/neu_box.dart';
import 'package:multisig_wallet_with_delegation/utils/modals/token_types.dart';

class NftTabView extends StatefulWidget {
  const NftTabView({
    super.key,
    required this.erc721Tokens,
    required this.erc1155Tokens,
  });

  @override
  State<NftTabView> createState() => _NftTabViewState();

  final List<ERC721Token> erc721Tokens;
  final List<ERC1155Token> erc1155Tokens;
}

class _NftTabViewState extends State<NftTabView> {
  @override
  Widget build(BuildContext context) {
    log(widget.erc1155Tokens.toString());

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.45,
      ),
      itemCount: widget.erc721Tokens.length + widget.erc1155Tokens.length,
      itemBuilder: (BuildContext context, int index) {
        bool is721 = index < widget.erc721Tokens.length;

        ERC721Token? nft721 = is721 ? widget.erc721Tokens[index] : null;
        ERC1155Token? nft1155 = is721
            ? null
            : widget.erc1155Tokens[index - widget.erc721Tokens.length];

        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: InkWell(
            onTap: () {},
            child: NeuBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: CustomBlockie(size: 128, data: "0xadssdsaress"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          is721 ? nft721!.contractName : nft1155!.contractName,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          is721 ? nft721!.nftName : nft1155!.nftName,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "#${is721 ? nft721!.tokenId.toString() : nft1155!.tokenId.toString()}",
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
