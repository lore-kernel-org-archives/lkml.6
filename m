Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEC5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AC7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbfAIPd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:33:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47164 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730652AbfAIPd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:33:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0D937209C2; Wed,  9 Jan 2019 16:33:56 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id D1AF520750;
        Wed,  9 Jan 2019 16:33:45 +0100 (CET)
Date:   Wed, 9 Jan 2019 16:33:46 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/5] ARM: dts: sunxi: Enable Broadcom-based Bluetooth w/
 serdev
Message-ID: <20190109153346.j5pdwiemr2hm5zwp@flea>
References: <20190109150257.12602-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7isc5e2z7w7wkzjn"
Content-Disposition: inline
In-Reply-To: <20190109150257.12602-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7isc5e2z7w7wkzjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 11:02:52PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This is the second batch of patches enabling Bluetooth for Broadcom
> (AMPAK) modules using the new serdev bindings.
>=20
> The patches are self-explanatory, so I won't go into the details here.
>=20
> This pretty much covers all the boards I have that have AMPAK modules.
> The only ones missing are the A80-based boards, which I haven't gotten
> working yet.

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7isc5e2z7w7wkzjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDYUWQAKCRDj7w1vZxhR
xVihAQClCnG8x0raI5CQ7dKaKeoWKQwGo8H+6WpIn0b+8O4bdwD+LnwurzsULmms
zM+Mk2jGqBp3tj1ZPgsayaA7rV3oBAI=
=/Icm
-----END PGP SIGNATURE-----

--7isc5e2z7w7wkzjn--
