Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28D32082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28D32082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLDI32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:29:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46439 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeLDI31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:29:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B4332207BF; Tue,  4 Dec 2018 09:29:24 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8468B20723;
        Tue,  4 Dec 2018 09:29:14 +0100 (CET)
Date:   Tue, 4 Dec 2018 09:29:14 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, airlied@linux.ie, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
Message-ID: <20181204082914.iyysctlftlgaffv3@flea>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <20181105094341.qedt7jvnxooiojki@flea>
 <14295738.m69morCfDC@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nick2en3or4insev"
Content-Disposition: inline
In-Reply-To: <14295738.m69morCfDC@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nick2en3or4insev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 07:09:50PM +0100, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 05. november 2018 ob 10:43:41 CET je Maxime Ripard napisa=
l(a):
> > On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> > > This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> > > can be found on H6 SoC.
> > >=20
> > > Display Engine 3.0 in comparison to 2.0 mostly adds features needed f=
or
> > > displaying and processing 10-bit and AFBC formats, which are not yet
> > > supported by this series.
> > >=20
> > > H6 is also the first SoC which supports IOMMU, but support for it is
> > > not yet added.
> > >=20
> > > This series is based on linux-next at next-20181102.
> > >=20
> > > I suggest all patches go through allwinner tree, except DRM patches,
> > > which should go through drm-misc tree.
> >=20
> > Applied all patches up to the 26. The two last one however should not
> > use the clk bindings define you added in the first clk patches, since
> > clk and dt patches are going through different tree.
>=20
> I think you forgot to merge patch "drm/sun4i: Add compatible for H6 displ=
ay=20
> engine". At least it is not in linux-next.

Sorry, I just applied it. thanks!
Maxime


--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nick2en3or4insev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAY62gAKCRDj7w1vZxhR
xccKAQDREKow//RUsju4juH/zjvD1TLHoS2siseRM84JC9rJNQEAx0PrxX1bzz1R
imBJVWh5FSLkywqxNMaZvX8zkPyE2wg=
=VwNa
-----END PGP SIGNATURE-----

--nick2en3or4insev--
