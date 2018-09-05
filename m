Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBFBC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D791A2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D791A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeIELu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:50:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34932 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIELu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:50:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4F71720756; Wed,  5 Sep 2018 09:21:37 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1A9B0203DC;
        Wed,  5 Sep 2018 09:21:37 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:21:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 06/11] dt-bindings: display: Add compatible for A64
 HDMI
Message-ID: <20180905072136.kzky22gkpkvjh35z@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-7-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4xrw2dfl335tthev"
Content-Disposition: inline
In-Reply-To: <20180904044053.15425-7-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4xrw2dfl335tthev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 12:40:48PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>=20
> The HDMI controller on Allwinner A64 is similar on the one on
> H3/H5/A83T (although the PHY is different with A83T).
>=20
> Add A64 compatible and append A83T compatible as fallback.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> [Icenowy: refactor commit log]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4xrw2dfl335tthev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPg/8ACgkQ0rTAlCFN
r3TfqBAAh+KfQix0sYDpcqb0FchTDdVxqzewRs6mDTgJRLlXVoL2mjdxHwPHHXta
SVp0lr1nDrHWE9s2Qmkf2ckp/s3A4nBL20AVTon3xHsCusZh3mGmu0su30VSw7iw
aZD473t6VYRdhVYZyrzqS1/cjp4s1mKzjoVd5TSfGgUm+ltvw5tBHNuSIyIQqCoq
TeJ3L0tRS7ybbUAEeJTGvw6lS2qmZzGFQsqRHx24Dt/mi6nqk9oS3bRqrjmQ8yHs
0fLQ7kEzLzmzolS1F97pf8V1svWfTEU412GaNsoV/W2K37kZyrTfRzaG8RC6RNFG
TVnmqlZP/0kJ2v4O4UoDb2qixVyQ3vb8oqKo85hMkQsQANfsKTewfYsP+hoTlX5T
+wGumT2l+d4Yci6r6xUROvsqbNwVdcOHf1/knDYO+bDiJJrUzaJoBLe0mEzCHE18
QThZbDCLuizK+zCtojjOLyYDslOWEufwCmODdAsx1WvM031Iyix4Uk1t8fTYtbQd
Pae1KLhoDQZJKvpGxmXiYPYJO4Et1TBXtWem4z2AgI7AK657lIpUbQ/r9YZnd2D5
IF2Mm7xVGAYQCC6lsQXYQrA98xxCOVn8jyc6mcruSh9MqV/FOUHEZeEAdrZJKQFz
siVzxPRJQNfwoXFDlu16YUFqXX/muBLiABdvzstlNAGQsx3aAwI=
=Turg
-----END PGP SIGNATURE-----

--4xrw2dfl335tthev--
