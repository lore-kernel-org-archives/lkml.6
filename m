Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DE420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DE420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeGXJuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:50:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51650 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeGXJuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:50:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 82DA3207B0; Tue, 24 Jul 2018 10:44:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 50DCD203D9;
        Tue, 24 Jul 2018 10:44:47 +0200 (CEST)
Date:   Tue, 24 Jul 2018 10:44:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] mmc: sunxi: allow 3.3V DDR when DDR is available
Message-ID: <20180724084447.bbqxchp5yamzc54i@flea>
References: <20180722125407.43107-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jlvfgcrbutgcc7oa"
Content-Disposition: inline
In-Reply-To: <20180722125407.43107-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jlvfgcrbutgcc7oa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 08:54:07PM +0800, Icenowy Zheng wrote:
> Some Allwinner boards feature an on-board eMMC with fixed 3.3V voltage
> (e.g. Banana Pi M2+), and in this case both the eMMC and the SoC are
> capable of doing 3.3V DDR transmission.
>=20
> Add capability of 3.3V DDR when DDR is available (extra clock or new
> timing).
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jlvfgcrbutgcc7oa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltW5v4ACgkQ0rTAlCFN
r3SyYA/8DVawbWwGR8txH535feCmlWevhR2gV6kbrGRzTKJoVgIIcHuDn0IfZW2c
YBQkfOD0t2azL+YEstvW3kEOWdA+8jPVCTqCGgKTn6JtiGnoOctUpNIrMK+75YOH
RFCtpe28qZDvqsZ76tuXihJTAYdfSCU1Q+PQ7dy0USvuhfqcsFZ9kCkUHTWHk3tS
JOU+U8BN4DXY8DaKsgcKWHMzCVNsjqY4MQkrvWaeh6+c+2PObAGV52QTJGJ9Dxxz
B6jKwRGL1Xi270ULJ9fSL0BBK1WEIiCnOp9j4EavEKd7/w9EcbHhD8nmoMNW3QCi
vF71hEUGST2xpYX2yBgh9iwOfn367yZAn7B44mYatzeo/TPneNYCzQJdehRoa+P6
fBHnFdCbBKISIwAQJrMKUb4/5tE3Lj0sRK6zTyFePrXSzCCwrJEcgbU552gCL4DD
21k0z7+S0CGGFbfr4NaCMYX2Rq4v/PQ/OVlF3GYQ73VVwbjEsUotMH35rw6c11wq
KprCN5kj5oC0NUrsSV7OupENn8oWs25z5nCAU+emLPlf+XTuujNWCJ2YwkiYOLjk
0K9hwerUSXWSMxwoExoZ06+7zdMj6tMtfeWjAOG9M02WQXspupu+TOMUq9U4nKQw
lwGfFeCt6P6jTUqAeFCNctrV/zcQ8t7rqQ0PNL77AfqrE+4N4E4=
=fItK
-----END PGP SIGNATURE-----

--jlvfgcrbutgcc7oa--
