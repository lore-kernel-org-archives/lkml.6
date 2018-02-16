Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965474AbeBPLyn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:54:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965036AbeBPLyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:54:41 -0500
Date: Fri, 16 Feb 2018 11:54:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        robh@kernel.org, mihai.serban@gmail.com, linux-imx@nxp.com,
        shegjiu.wang@nxp.com, daniel.baluta@nxp.com,
        linux-kernel@vger.kernel.org,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for AK4458 DAC driver
Message-ID: <20180216115436.GF5886@sirena.org.uk>
References: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
 <1518614467-20613-2-git-send-email-cosmin.samoila@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline
In-Reply-To: <1518614467-20613-2-git-send-email-cosmin.samoila@nxp.com>
X-Cookie: To order, call toll-free.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2018 at 03:21:06PM +0200, Cosmin-Gabriel Samoila wrote:

> --- /dev/null
> +++ b/sound/soc/codecs/ak4458.c
> @@ -0,0 +1,659 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Audio driver for AK4458 DAC
> + *

Please don't mix C and C++ comments line this, just make the entire
block a C++ comment.  Since this looks otherwise good I'll apply this,
please send a followup patch fixing the above.

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGxnsACgkQJNaLcl1U
h9A0cwf+M273FLdr5luerf/pSFQ8Ill9TfoBPOaPdnMWysZTvUhHiCrx5/okTE4C
m8gS2iBV7pF09JiC5+NjJu8n8mAdQQQ6ISTJewZVsRMEuDoBE022DIXVrCTzaCZO
WtaT+nemH/7RA6E4gzHaY17Rl00+xlKER6PdM6jj8sTwNJ2Z3dsUq64Q6wEOJzrZ
6fxcGkWdrfrwqvmmI6U8ipqXThDII4SCfIm5TDtmhsOTnzYcCM5NYNQlGbsDoseI
rHK02ILoHYXDUQQodHJSmm/7/8bD+CuIcFVoI1eyWPr6n/M4cwWutTi5tYrDzQGz
ybJthCJww6lsxe6vWy4xkfq3+BSOcQ==
=YIZA
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
