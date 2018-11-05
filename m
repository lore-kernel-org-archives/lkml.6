Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB305C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B82082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5B82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeKETCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:02:35 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59518 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKETCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:02:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 45705207B0; Mon,  5 Nov 2018 10:43:41 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 161B3206A1;
        Mon,  5 Nov 2018 10:43:41 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:43:41 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, airlied@linux.ie, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
Message-ID: <20181105094341.qedt7jvnxooiojki@flea>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="46or3tqg6zho2rip"
Content-Disposition: inline
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--46or3tqg6zho2rip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> can be found on H6 SoC.
>=20
> Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> displaying and processing 10-bit and AFBC formats, which are not yet
> supported by this series.
>=20
> H6 is also the first SoC which supports IOMMU, but support for it is
> not yet added.
>=20
> This series is based on linux-next at next-20181102.
>=20
> I suggest all patches go through allwinner tree, except DRM patches,
> which should go through drm-misc tree.

Applied all patches up to the 26. The two last one however should not
use the clk bindings define you added in the first clk patches, since
clk and dt patches are going through different tree.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--46or3tqg6zho2rip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AQzQAKCRDj7w1vZxhR
xVIMAP4qGI+8fBa+vQxXwJp/m/0eAS+8LQd22DCU9THY6PWzggEAtx48VjehKIZJ
QEmvOcA8rTqxZSzuAnclZTVr676CdQQ=
=9xxI
-----END PGP SIGNATURE-----

--46or3tqg6zho2rip--
