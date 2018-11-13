Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E00C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173062243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173062243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbeKMXIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:08:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52002 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbeKMXIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:08:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4C5F7207CF; Tue, 13 Nov 2018 14:10:11 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C707206A7;
        Tue, 13 Nov 2018 14:10:11 +0100 (CET)
Date:   Tue, 13 Nov 2018 14:10:11 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: a64: Add device node for
 Mali-400 GPU
Message-ID: <20181113131011.t7r5m3vks4cyec4v@flea>
References: <20181113120054.17639-1-jagan@amarulasolutions.com>
 <20181113120054.17639-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kvvdvqhnycdvcqfh"
Content-Disposition: inline
In-Reply-To: <20181113120054.17639-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kvvdvqhnycdvcqfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 05:30:54PM +0530, Jagan Teki wrote:
> Add support for Allwinner A64 has Mali-400MP2.
>=20
> All interrupt lines are mentioned in the manual so used the same.
> Used 408MHz as assigned clock rate used by BSP, so used the same as
> well.

You're not using that frequency anywhere.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kvvdvqhnycdvcqfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+rNMwAKCRDj7w1vZxhR
xVAOAQDnSLzA3nieBEdVcsQlpnwKkUKZqAnrYVqb/xr3See13gD7BknYTq0ttldm
zAyvI/5lzsFvYbitLg1b5gAeljVMdgU=
=zSBl
-----END PGP SIGNATURE-----

--kvvdvqhnycdvcqfh--
