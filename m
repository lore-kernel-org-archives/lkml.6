Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966236AbeBPMOx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:14:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965852AbeBPMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:14:51 -0500
Date: Fri, 16 Feb 2018 12:14:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, fabio.estevam@nxp.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, wakasugi.jb@om.asahi-kasei.co.jp,
        shengjiu.wang@nxp.com, mihai.serban@gmail.com, cosmin.samoila@nxp.com,
        linux-imx@nxp.com, daniel.baluta@gmail.com,
        Mihai Serban <mihai.serban@nxp.com>
Subject: Re: [PATCH v4 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Message-ID: <20180216121445.GH5886@sirena.org.uk>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
 <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline
In-Reply-To: <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
X-Cookie: To order, call toll-free.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:29:33PM +0200, Daniel Baluta wrote:

> +++ b/sound/soc/codecs/ak5558.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*

Just make this a C++ commment, don't mix C and C++ - it looks neater.
Otherwise this looks good so I'll apply, please send a followup patch
for the above.

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGyzUACgkQJNaLcl1U
h9DT7Af/Umwkug7QvVOl/p5SxKtPTAhEmUo7COO9Mf4yIYyVYDSMzfETYdtTz54v
JblysLH1WXtSw6E532leFC8EGn/3Na+Y5AcZRTWImf1Vzo2KFUji12MrWptK15W/
HdxwZZRFVgVGrvSZrfGju2h68bveFHQf+vh3QQH3Lx/bKQiWAcEnzS0M8upBIYd8
hHll8RqqAzc2so2P5O5tGWsK9TtNIAf18TnKo87xQ7+pJAv5ZBxcI59qxdnYXwQj
Rdss+sLVRF+93wff9KfShVOX8Yu4aUP1Sb9uQGqS6f5HcBxbe1Xz0189HW9GXoDQ
i3FCfAdV0ntR5HHmJpV+CId6tLsQdg==
=DTcU
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
