Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F155C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AB120854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AB120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeKESAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:00:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56058 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:00:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39BCA207CF; Mon,  5 Nov 2018 09:42:04 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0B9CC206A1;
        Mon,  5 Nov 2018 09:41:54 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:41:54 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/7] clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
Message-ID: <20181105084154.l7g2dp33qlasgnrg@flea>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ecup2xmbdcmn2nj5"
Content-Disposition: inline
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ecup2xmbdcmn2nj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 12:06:28AM +0530, Jagan Teki wrote:
> MUX bits for MMC clock register range are 25:24 where 24 is shift
> and 2 is width So fix the width number from 3 to 2.
>=20
> Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU=
")
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied for 4.21, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ecup2xmbdcmn2nj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+ACUQAKCRDj7w1vZxhR
xbSRAQCN4bjLaSm1Tx9GEK/FzPNYkdkTMqXfRfLXvbveWy9ucQD+Oq7J8rOd35/N
BHp18t+Rq54zZLbqZitV+c/8pJuqmA0=
=k91D
-----END PGP SIGNATURE-----

--ecup2xmbdcmn2nj5--
