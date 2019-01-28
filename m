Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA47FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965262083B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfA1Kx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:53:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50167 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1Kx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:53:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BBFF4209BF; Mon, 28 Jan 2019 11:53:53 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8A2A3209A7;
        Mon, 28 Jan 2019 11:53:43 +0100 (CET)
Date:   Mon, 28 Jan 2019 11:53:44 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: dts: sun5i: q8-tablet: Use
 bananapi,s070wv20-ct16 panel compatible
Message-ID: <20190128105344.y7m5gruyamsp3r7s@flea>
References: <20190127144838.3578-1-wens@csie.org>
 <20190127144838.3578-6-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="twqhz7ijjeox7jmv"
Content-Disposition: inline
In-Reply-To: <20190127144838.3578-6-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twqhz7ijjeox7jmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:48:38PM +0800, Chen-Yu Tsai wrote:
> The compatible string for the LCD panel used for the Q8 tablets are just
> a placeholder that was shown to be compatible with the actual panels
> found on these devices. The real panels do not have any identifiable
> markings and vary between production runs.
>=20
> The compatibe string previously used had a pixel clock that could not
> be accurately reproduced on Allwinner hardware, and discussions on
> whether a margin should be added to the display drivers and how large
> a margin was acceptable had stalled.
>=20
> Now that we have a panel model that is actually used with Allwinner
> hardware, has the same dimensions, and the timings have been shown to
> work with the nameless panels, we can use that one instead.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--twqhz7ijjeox7jmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7fOAAKCRDj7w1vZxhR
xb0SAQCen0HJZMPM7YPMTT/lFOVFjJ1E275HdjloKPHfl2nYZgD/V66ZJEYxbzdi
9BAQshREanIdghSWrwSpXbURp4wd9Qc=
=GUyW
-----END PGP SIGNATURE-----

--twqhz7ijjeox7jmv--
