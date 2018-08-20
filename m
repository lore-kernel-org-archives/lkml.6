Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D759CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8252421570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8252421570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeHTReL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:34:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42714 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTReL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:34:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EC23B20703; Mon, 20 Aug 2018 16:18:19 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id BBD0120618;
        Mon, 20 Aug 2018 16:18:09 +0200 (CEST)
Date:   Mon, 20 Aug 2018 16:18:10 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to
 MMC module clocks
Message-ID: <20180820141810.botskv2xkzpnd5t3@flea>
References: <20180820134013.16527-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wuwvpbr7iymq763q"
Content-Disposition: inline
In-Reply-To: <20180820134013.16527-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wuwvpbr7iymq763q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 09:40:13PM +0800, Icenowy Zheng wrote:
> On the H6, the MMC module clocks are fixed in the new timing mode,
> i.e. they do not have a bit to select the mode. These clocks have
> a 2x divider somewhere between the clock and the MMC module.
>=20
> To be consistent with other SoCs supporting the new timing mode,
> we model the 2x divider as a fixed post-divider on the MMC module
> clocks.
>=20
> This patch adds the post-dividers to the MMC clocks, following the
> approach on A64.
>=20
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wuwvpbr7iymq763q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6zaEACgkQ0rTAlCFN
r3RWghAAkhrVUQJTzPlKG8SkHqsIx4DqoBtRE+KNb4Z+fhoP6hOX17nHwZ12SZT+
DYtX2qp6UsqVtin6v0cDjOET73TB7e34rK/mgGI2XDGz2wsD0l6TrSxCE+klBNfW
5QYVzzg9YVEfY2yXKmu++UEdOPFPiXgv5xuBWqp72PhZQhBH0VvppVKxaIjRv8PX
/A5HMrXBaNi5nnYu82vWbuYtzw55fu5jNSppn0RYNmvr2pfGH0CtyH+uxIneMOQf
jzZnAZHWbwLHvSARgCse9w7R6R+C5FZCSNC+TtMZ9mI2gw8/uvyxZ2pm6/jDuLaM
WDpgpLblpQ7jqUR1iGfy4czR2PDPLHCnLdlJ28HFO4/tYVQiCjGABhPEaxorQOHt
VdLMXaobpwOqNI8l148DyCZ2aud+O5AHhMgGDvM/eOMaQNZ/wv8DezikVvZfB8k9
mJDSWN01vSQk+t+7xh7Jul/FP13bKhXoYVsPJkyugZIj0BSMYVxTh0puuvn3bnQC
8RyFNuP5kyQWWvfXn2304c1j1BzuJQIa29KnIe6E04KaZXzTLmesv+XGbiaQkHuc
H5OE6+XtmDOx17jopvWBlW7+VjcBC3XMXXSsCzkanHmQoU1jtx+qDbO0F9L+vl7y
f9yW1R76UaDfXpD/fcbkZ9qgn+sGn7gWzXxCDjVTaPrGsIr9fno=
=hD5r
-----END PGP SIGNATURE-----

--wuwvpbr7iymq763q--
