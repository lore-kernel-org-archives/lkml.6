Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeENOLj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:11:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50509 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753504AbeENOLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:11:38 -0400
Date: Mon, 14 May 2018 16:11:26 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrea Bondavalli <andrea.bondavalli74@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v14 8/8] ASoC: sun4i-codec: Add Left Capture Select,
 Right Capture Select
Message-ID: <20180514141126.mv7iso2d4xrfnsax@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-9-dannym@scratchpost.org>
 <20180503145408.yymk2ndt4sm2yt4i@flea>
 <20180505124050.66f74999@scratchpost.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="udenmhxour2wcgz2"
Content-Disposition: inline
In-Reply-To: <20180505124050.66f74999@scratchpost.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udenmhxour2wcgz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 12:40:50PM +0200, Danny Milosavljevic wrote:
> Hi Maxime,
>=20
> On Thu, 3 May 2018 16:54:08 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > > +static const char * const sun4i_codec_capture_source[] =3D {
> > > +	"Line",
> > > +	"FM",
> > > +	"Mic1",
> > > +	"Mic2",
> > > +	"Mic1,Mic2",
> > > +	"Mic1+Mic2",
> > > +	"Output Mixer",
> > > +	"Line,Mic1",
> > > +}; =20
> >=20
> > Shouldn't that be defined in a more generic way? As far as I know,
> > there's no way to tell what the difference between "Mic1,Mic2" and
> > "Mic1+Mic2" would be from the userspace.
>=20
> Sounds good - but how?
>=20
> Here, "Mic1,Mic2" means the left channel captured is Mic1 and the right
> channel captured is Mic2.
>=20
> On the other hand, "Mic1+Mic2" means that the signals from Mic1 and
> Mic2 are added together and that is captured (both as left and as right).
>=20
> "Mic1" means both the left channel and the right channel captured is
> from Mic1.  Likewise "Mic2".

Right, and my point isn't that it is difficult to understand or
remember once you get it, but that it's difficult to get it in the
first place, and that this convention is solely based on the one used
in the datasheet, which is an abstraction violation in itself.

I guess that's really up to Mark here, but one solution would be to
allow to couple the controls explicitly instead of relying solely on
the fact that they share the same controls array pointer.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--udenmhxour2wcgz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5mQ0ACgkQ0rTAlCFN
r3QsDg/9EdT0/2F7120H272q4Ar3OgoeKeo7tmox58o6moOKy1Do0r+5b9el4RrE
p6eFZp0wBaY9HaiW4gGso9x7fLSV1bOlbuZUUDzfQKpzaBdmhEeRpypMlxqqdqoT
0oKCw0TGEduOTsdVAUn7UQsBfjyGsoac5ag1V6mUWas8E7ZT8ySJx5q4QX5zhTie
nmTCGVXeFGjgS12ZVGhFKArf/zyF7ShPN2bPovVgYaLVAWwZx1JUXKm5XAu4po6o
lNswFO8vDrgbyhJt0IaBnwTCzn2ikvKfhIX/9QLBsMFIU+6gMkxgyVUZY68UVG9F
zm32dyF8OTm/rvf7ZLb0lexPIBVMeP7E6dguI9fMbP1y5wHAFrlWQQjyH79DCxsX
tHbjuw19cDpaqBtYE/H2bFnBQNde8Z+RX1jnjTY0maZPKKPc0a+lmGE5Fll7lJ91
GEos2FLKKdvY9uIrYqGgyN2HEUyT3Qb/+oHVydmq6ZDNQm+mIfx95vdFaLvKq7Z1
urcBKxb5Lw7MRr8g++MYZkBs4JJDSigYn8i/ZzFZhL0NvBXNmQwGGSIUD95vN5Oz
mAirCKcNHv1r3Fo9V3S8epBDk/HXAdCmTtOHAB+76lD/HYuRpWE+4eTfE7vgW+DY
O6RX6Ji+IZfU7xQXYaW9Le9Ah8kfmvOBjRisJBoeNaObLSMpgfw=
=hOx9
-----END PGP SIGNATURE-----

--udenmhxour2wcgz2--
