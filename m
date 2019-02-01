Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF073C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF80218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfBANFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:05:51 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48866 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfBANFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:05:50 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 990013A62EA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 13:50:25 +0100 (CET)
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 46B5EFF809;
        Fri,  1 Feb 2019 12:50:23 +0000 (UTC)
Date:   Fri, 1 Feb 2019 13:50:22 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 2/2] arm64: defconfig: Enable SUN6I Camera sensor
 interface
Message-ID: <20190201125022.mw5yhbahq6afsal7@flea>
References: <20190131152035.7138-1-jagan@amarulasolutions.com>
 <20190131152035.7138-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oqbxszzbap7bcgns"
Content-Disposition: inline
In-Reply-To: <20190131152035.7138-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oqbxszzbap7bcgns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 08:50:35PM +0530, Jagan Teki wrote:
> Enable Camera sensor interface for Allwinner SUN6I SoC's.
>=20
> This support enable V4L2 platform drivers static and
> VIDEO_SUN6I_CSI as module.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--oqbxszzbap7bcgns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFRAjgAKCRDj7w1vZxhR
xZp0APMFqFQfWjRqJ5G3MIO8D19D+wYzghofLq0fiXxXeXf8AP9HuN2jQF/XELbC
tn081/UB9lUC5K8Sd8bj6AwL4HaYBQ==
=yV1B
-----END PGP SIGNATURE-----

--oqbxszzbap7bcgns--
