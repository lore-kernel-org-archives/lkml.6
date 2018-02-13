Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934932AbeBMLzm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:55:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59026 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeBMLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:55:41 -0500
Date: Tue, 13 Feb 2018 11:55:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Message-ID: <20180213115537.GB5988@sirena.org.uk>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
 <20180131170330.GB7763@sirena.org.uk>
 <1518513744.25655.8.camel@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <1518513744.25655.8.camel@nxp.com>
X-Cookie: Blend until smooth.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 09:22:24AM +0000, Cosmin Samoila wrote:

> This is used to set the codec in Manual Setting Mode, meaning that
> the default sampling speed is set based on DFS0 and DFS1 bits. In
> Auto Setting Mode, the MCLK frequency is detected automatically and
> DFS bits are ignored.

But why is it a compile time option?

> This compile time option is used to know when to set the ACKS bit in
> init_reg function that switches between modes.
> At this moment we are only using Auto Mode and I can remove it if
> you think is not necessary.

Yes, just remove it - if there needs to be some control it should
probably be done by the machine driver, or through DT.

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqC0jgACgkQJNaLcl1U
h9CQjQf+M5k3oleXSIIJLz+kivFTuF85SmVDYszett34gGRAIn9hVAemj93eEcZ2
zyIHAowZSNsXtjiVOARzZwori0NhDi7QYYLP58gREpR93g7A/4uxScHOWXNAFmfB
rQGcfgOJzvIH5m72Uq8EP+B+0H1FYr657FpIadcueX1kMqV2APZggtpAQ2u3Lqaq
yp4fWuXKTeEd6xzoH6QOb9MGthvi/BS+iJiFeEPJCT35fBKQXlwr1qY0UaXQmdg8
GgPTx2Vt9RKG/Xcba2TX3XlFzpVkgUhBC1vlWotVJVNpwA9+bfq2IixkmRfjG6UG
g7SuOgqXZRxuAIxKck4lntRsi5utBw==
=kmAm
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
