Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031273AbeBPNbU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:31:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33342 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031222AbeBPNbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:31:18 -0500
Date: Fri, 16 Feb 2018 14:31:14 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA <alsa-devel@alsa-project.org>, linux-omap@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Message-ID: <20180216133114.6ynx36b5cpfvkebd@earth.universe>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
 <CAOFm3uFJC2Xb0PuNECJ-Tvg2gQS==tMSc77p_keQoCexNqOkDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xxkkzaapssgvi4et"
Content-Disposition: inline
In-Reply-To: <CAOFm3uFJC2Xb0PuNECJ-Tvg2gQS==tMSc77p_keQoCexNqOkDg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xxkkzaapssgvi4et
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Thu, Feb 15, 2018 at 10:50:22AM +0100, Philippe Ombredanne wrote:
> Dear Sebastian,
>=20
> On Wed, Feb 14, 2018 at 11:07 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > Motorola CPCAP is a PMIC with audio functionality, that can be
> > found on Motorola Droid 4 and probably a few other phones from
> > Motorola's Droid series.
> >
> > The driver has been written from scratch using Motorola's Android
> > driver, register dumps from running Android and datasheet for NXP
> > MC13783UG (which is similar to Motorola CPCAP, but not the same).
> >
> > The chip provides two audio interfaces, that can be muxed to two
> > different audio codecs. One provides support for stereo output
> > (named StDAC or HiFi), while the other only provides mono output
> > (named Voice). Only the Voice codec provides a Capture interface.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> <snip>
>=20
> > --- /dev/null
> > +++ b/sound/soc/codecs/cpcap.c
> > @@ -0,0 +1,1588 @@
> > +/*
> > + * ALSA SoC CPCAP codec driver
> > + *
> > + * Copyright (C) 2017 - 2018 Sebastian Reichel <sre@kernel.org>
> > + *
> > + * Very loosely based on original driver from Motorola:
> > + * Copyright (C) 2007 - 2009 Motorola, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
>=20
> Could you consider using the new SPDX tags instead of this fine but
> long legalese? [1]

Sure. Thanks for the hint.

> <snip>
>=20
> > +MODULE_ALIAS("platform:cpcap-codec");
> > +MODULE_DESCRIPTION("ASoC CPCAP codec driver");
> > +MODULE_AUTHOR("Sebastian Reichel");
> > +MODULE_LICENSE("GPL");
>=20
> This does not match your license: per module.h, GPL means GPL-2.0 or
> later. You notice above is GPL-2.0, not "or later"

Indeed. I will fix this in the next revision.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/license-rules.rst

-- Sebastian

--xxkkzaapssgvi4et
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqG3SIACgkQ2O7X88g7
+pqMmA//aa05Eg+Q58TcnFoWA7tjVdypd3uwmzsRCqFMLOj6TC8iPSv5yz4JU+Dp
YQp8e42B+eN61XNhEf/HWu3HRvLlCwHgEMYmElUPzSOr/L0p2RF+Uy1YfpDq46M+
baVlNYYM0u5pu+vMWqvGUU2g409X9eaNHfCFrErNuBdDNpUADVYIgQ67Pe2eQtqp
q6y13qWgYn9ol9r4bIrKxS/Em2zyZKZjNYxGhUzXDr3ui8qVZnKLosJISCJOcHZi
RkR481/psP0APoAJ4HcDvlcAbIGQ+xBHdmEsIGROHtBN84gcsoWbBjhXfks/UKa9
RR34y45aGRdRdNVhIXEFov5W6C35OlTWoNrOm/28Xd3VIrdlXbn7j9PIkA+pbAvP
zTDDrUP8ptlm075Ns15HET+ZWv5PpugYrEmYYYksMLfr3OOSyExbuLStxsDh9lNn
Bzap6YLWvA+0XL9MYTyKTT7kbuhv4wEerHVpVCo4hC0bb3JmPZMYS07VSepu5MdS
A/oFi0h2XLmCb8305MifunnWMwZ7tLVlygfd65h+IV5sHGLs/be7lvQuCSZfd6GR
3Ee50G8x+EzCUiQ54vMsTtC+gGTgE1eIlLnx5n9fkzBbAIA9upibURUvWJgWAJ3N
7w3c1f+65e/hyO5XyZYeusrgUmv+Rqaa6XDn9L/6CPebv721Ruo=
=SxCo
-----END PGP SIGNATURE-----

--xxkkzaapssgvi4et--
