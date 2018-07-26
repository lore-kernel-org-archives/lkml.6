Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A3EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BDC20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BDC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbeGZN6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:58:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56171 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbeGZN6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:58:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 53F042097A; Thu, 26 Jul 2018 14:41:29 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 273512082B;
        Thu, 26 Jul 2018 14:41:19 +0200 (CEST)
Date:   Thu, 26 Jul 2018 14:41:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to
 rebase on M2 Ultra
Message-ID: <20180726124119.dwne2sncws2p3sdi@flea>
References: <20180724163655.61365-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e565z7acyzl3z52t"
Content-Disposition: inline
In-Reply-To: <20180724163655.61365-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e565z7acyzl3z52t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> Banana Pi designs the BPi M2 Berry board to be software compatible with
> BPi M2 Ultra,

Do you have a reference for this?

> so it's based on M2 Ultra with some function cuts, including:
>=20
> - 2048MiB DRAM -> 1024MiB (this should be proceed by the bootloader);
> - dropped a LED;
> - dropped eMMC;
> - dropped USB2 and connect USB1 to a 4-port HUB.

Is it the exhaustive list?

I'm a bit reluctant to merge that kind of patches usually, since that
would also imply that each time someone will commit something to the
M2-Ultra, it would automatically apply to the M2-Berry, without any
easy way to tell and / or test.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--e565z7acyzl3z52t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltZwW4ACgkQ0rTAlCFN
r3SY5BAAlr29SssLhgjzsPTNNhicMKLx4L9GuGbss5A4S3RJvBqyZpOF6k2QQsTM
THD9H/sbSmgTPMYBBZzpcW9O57uLgWduGHLusGQWBgiVj0rMt2wnCViYvIB/v3+4
6+EDedeQ51WSVMuDmX2/VEYGddwZ5JBWCdbyPFZbnwZ+Rr/GOIX4YdD6aWlqoKtk
c6yzfHv5F4dHaY5eybqD19nBs2uTM9yeOlW1djLwEbkE8L9aRKFnS2uZYJfcT7y4
eDp5lEeZlxign4BwThDnwAnIt32exz9VW3lUbqyWsQDDWUezgX/um2yaFnL7Ael7
Ffg8IHuAQURYAtX0XTz59g2U64ELiLKxAklCoh0ArnBRT4g1jY/VA87lmOnPeBmI
s/7nsZPDR8yFbJl9x5ybMsqH+kRrB2rI4O0Pp3yJcDaoJf9FRkwa4dFdd8xc6VSr
UWm2zdnhNqWe9q8Ec3tEP4GGXKAg9dv9AeOpoG44PinrwOwblawvotgZvsxatGUp
ZQkzhdwleyfHqhbT8US1Y23olMxZCU6QH3VVKd0OXyDT5SsPSWwnzOrTa+P4qb43
A+2kfWfBO9hx+J2iHZVqLox+ZGU3rulAAYrR4ttJi3bGyvy+ZuePqXjtf5Aq0KDZ
8eM2oVsO/3KZBna0JqeYWuBfIP+ThZB8ptCHZu1+/oBucWe/pBA=
=aScP
-----END PGP SIGNATURE-----

--e565z7acyzl3z52t--
