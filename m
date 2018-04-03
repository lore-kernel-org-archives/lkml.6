Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755369AbeDCIwW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:52:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51535 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755154AbeDCIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:52:20 -0400
Date: Tue, 3 Apr 2018 10:52:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5,5/5] ARM: dts: omap4-droid4: add soundcard
Message-ID: <20180403085218.GE3926@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20180322234832.o24ut5ahon46mdu4@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I think I should have the required options enabled...=20
> >=20
> > CONFIG_SND_OMAP_SOC=3Dy
> > CONFIG_SND_OMAP_SOC_DMIC=3Dy
> > CONFIG_SND_OMAP_SOC_MCBSP=3Dy
> > CONFIG_SND_OMAP_SOC_MCPDM=3Dy
> > CONFIG_SND_OMAP_SOC_HDMI_AUDIO=3Dy
>=20
> That's the SoC (OMAP) side.
>=20
> > # CONFIG_SND_OMAP_SOC_RX51 is not set
> > # CONFIG_SND_OMAP_SOC_N9 is not set
> > CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dy
> > CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dy
>=20
> That's not needed (but does not hurt). The Droid 4
> has no TWL companion chip and uses CPCAP instead.

Umm. AFAICT CONFIG_SND_OMAP_SOC_MCBSP=3Dy can not be selected without
selecting one of the other options... right?

Seems like bug in Kconfig.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDQMIACgkQMOfwapXb+vLTiACcDv6TtEK9ryYimDnVGYlJW2hL
EJYAoL9FdxvEmzcirNb9gF78MuPpgeNE
=zY3Q
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
