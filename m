Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BDEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFBE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFBE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeLCMnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:43:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35703 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeLCMnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:43:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A53022071D; Mon,  3 Dec 2018 13:42:17 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73E5920379;
        Mon,  3 Dec 2018 13:42:07 +0100 (CET)
Date:   Mon, 3 Dec 2018 13:42:07 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: gpu: add Allwinner H6 Mali Midgard
 binding
Message-ID: <20181203124207.qqasvbio67u7bhvz@flea>
References: <20181127074249.15204-1-icenowy@aosc.io>
 <20181127074249.15204-2-icenowy@aosc.io>
 <11894938.HOUtrQJeEF@phil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ojmp36grwkvkfun"
Content-Disposition: inline
In-Reply-To: <11894938.HOUtrQJeEF@phil>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ojmp36grwkvkfun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 01:25:21PM +0100, Heiko Stuebner wrote:
> >  - reg : Physical base address of the device and length of the register=
 area.
> > =20
> > @@ -44,6 +45,18 @@ Optional properties:
> >    for details.
> > =20
> > =20
> > +Vendor-specific bindings
> > +------------------------
> > +
> > +The Mali GPU is integrated very differently from one SoC to
> > +another. In order to accomodate those differences, you have the option
> > +to specify one more vendor-specific compatible, among:
> > +
> > +  - allwinner,sun50i-h6-mali
> > +    Required properties:
> > +      * resets: phandle to the reset line for the GPU
>=20
> While this paragraph is similar to how it is done in Utgard, I'm
> wondering why we cannot just describe the "resets" as regular
> optional property above that.

Because it's not really optional, it's mandatory on some platforms
(like this one) and has no significance on others.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4ojmp36grwkvkfun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAUkmwAKCRDj7w1vZxhR
xfl8AP9eEXNY5xIbtx2dqNcTn12a+QC2Iv3/9PHj3/jjTVNebAEAiX2EcPiPUGlv
v0/MyAv2hBilA+flGAcN2PAqrG39pgU=
=3fvL
-----END PGP SIGNATURE-----

--4ojmp36grwkvkfun--
