Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA99C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEF12082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEF12082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLGOIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:08:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60197 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeLGOIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:08:55 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1223220CC5; Fri,  7 Dec 2018 15:08:53 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id CC92520D23;
        Fri,  7 Dec 2018 15:08:42 +0100 (CET)
Date:   Fri, 7 Dec 2018 15:08:43 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] ARM: dts: sunxi: Fix PMU compatible strings
Message-ID: <20181207140842.kkqaqefrmgcx6nkw@flea>
References: <20181206191142.14118-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cjloinzbxygaj26u"
Content-Disposition: inline
In-Reply-To: <20181206191142.14118-1-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cjloinzbxygaj26u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 01:11:42PM -0600, Rob Herring wrote:
> "arm,cortex-a15-pmu" is not a valid fallback compatible string for an
> Cortex-A7 PMU, so drop it.
>=20
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cjloinzbxygaj26u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAp+6gAKCRDj7w1vZxhR
xdcWAP0SfKjQg2htIHVLOTja6/XP9vJlADsV5ayhochHcLEEPAD/Vo3ihG4M2T73
QOllzOlRh+1G+OZIeKwzgVgx9IGtugI=
=HuER
-----END PGP SIGNATURE-----

--cjloinzbxygaj26u--
