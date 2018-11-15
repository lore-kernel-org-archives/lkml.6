Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F3420818
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F3420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbeKPBOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:14:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44997 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387839AbeKPBOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:14:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E0DA220893; Thu, 15 Nov 2018 16:06:10 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id B30FD20379;
        Thu, 15 Nov 2018 16:06:10 +0100 (CET)
Date:   Thu, 15 Nov 2018 16:06:10 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 2/2] arm64: dts: allwinner: a64: Add device node for
 Mali-400 GPU
Message-ID: <20181115150610.5vmfa66u6tx4s3ig@flea>
References: <20181114042837.15149-1-jagan@amarulasolutions.com>
 <20181114042837.15149-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="evhggvtbhqzuc3d5"
Content-Disposition: inline
In-Reply-To: <20181114042837.15149-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--evhggvtbhqzuc3d5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 09:58:37AM +0530, Jagan Teki wrote:
> Add support for Allwinner A64 has Mali-400MP2.
>=20
> All interrupt lines are mentioned in the manual so used the same.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--evhggvtbhqzuc3d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+2LYgAKCRDj7w1vZxhR
xYE9AP9BHK+vnMRtUM7t6IWkvWKGxpYEXwTSef07kJdDsuhdYgEA7vrJSVRBrt1Y
ERnHlF8ITXFethj4gTxt4nFzhr+obAc=
=kXC1
-----END PGP SIGNATURE-----

--evhggvtbhqzuc3d5--
