Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeAaRJE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:09:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43728 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeAaRJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:09:02 -0500
Date: Wed, 31 Jan 2018 17:08:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, alsa-devel@alsa-project.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        mihai.serban@gmail.com, cosmin.samoila@nxp.com, linux-imx@nxp.com,
        Mihai Serban <mihai.serban@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Message-ID: <20180131170859.GC7763@sirena.org.uk>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
X-Cookie: Disk crisis, please clean up!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 31, 2018 at 02:20:31PM -0200, Fabio Estevam wrote:
> On Wed, Jan 31, 2018 at 10:57 AM, Daniel Baluta <daniel.baluta@nxp.com> wrote:

> > +       dev_err(&i2c->dev, "%s(%d)\n", __func__, __LINE__);

> You certainly do not want an error message on every probe :-)

Sometimes you've just got to be honest with people about their hardware
choices! :)

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpx+CsACgkQJNaLcl1U
h9B2iwf+JFWIP6EjUfINlZZ7JvpAr96cX3SyKanWXBU4N+9peL1zDbwXYNT8+KVw
Mp03a2fClB7NgTqLR5xKF0vPecfKbKMzk0RUKaTBu/rsHTguEsen/EegKcn3s4Ix
vBIWXhoGry3m/XMlL/EgaDqAHRMRnFVlCJkzcYhXbdnjmnH3jxj9N6CMAyz1tMXa
KMzzMs7Y4PJOzG0eub5GzcxNmW9UKqUIkO0Hwheaxlzet41KB5Z0zCsbxOOM/y06
wcml2/tT80ekc/5v8Ldo9sl9pZRRDiWdv8TNIzfLf4XaeGPeY5LyQkd2SIM0kY7g
W2I6OBZ/gRuk80aTwXlohFxJL3iv2w==
=Jhgu
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
