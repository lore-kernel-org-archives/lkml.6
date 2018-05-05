Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeEEKk7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:40:59 -0400
Received: from dd26836.kasserver.com ([85.13.145.193]:38366 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeEEKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:40:58 -0400
Date: Sat, 5 May 2018 12:40:50 +0200
From: Danny Milosavljevic <dannym@scratchpost.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
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
Message-ID: <20180505124050.66f74999@scratchpost.org>
In-Reply-To: <20180503145408.yymk2ndt4sm2yt4i@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-9-dannym@scratchpost.org>
 <20180503145408.yymk2ndt4sm2yt4i@flea>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Exol.Wno/UhQybeCm87A+jH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Exol.Wno/UhQybeCm87A+jH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, 3 May 2018 16:54:08 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> > +static const char * const sun4i_codec_capture_source[] =3D {
> > +	"Line",
> > +	"FM",
> > +	"Mic1",
> > +	"Mic2",
> > +	"Mic1,Mic2",
> > +	"Mic1+Mic2",
> > +	"Output Mixer",
> > +	"Line,Mic1",
> > +}; =20
>=20
> Shouldn't that be defined in a more generic way? As far as I know,
> there's no way to tell what the difference between "Mic1,Mic2" and
> "Mic1+Mic2" would be from the userspace.

Sounds good - but how?

Here, "Mic1,Mic2" means the left channel captured is Mic1 and the right
channel captured is Mic2.

On the other hand, "Mic1+Mic2" means that the signals from Mic1 and
Mic2 are added together and that is captured (both as left and as right).

"Mic1" means both the left channel and the right channel captured is
from Mic1.  Likewise "Mic2".

--Sig_/Exol.Wno/UhQybeCm87A+jH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEds7GsXJ0tGXALbPZ5xo1VCwwuqUFAlrtijIACgkQ5xo1VCww
uqXnrAf/Xd0Yk0vL15fJLA/PwoWkuJBoKcYEX9enzceDXe+c63KP2DnPzRchI+Au
qmPk3pQg/1DmcgYuKINKf8iaynvJHprovYFWlc3/paYTa/Nf8buucOJvLaSpGX4d
4+WzB3XTSmHz/VXtYyBKPMof1/yUutS8JC8UYfKsAqQ2VfCzmYsS49TfYwRTAZmx
QHn7mC2VOLJNMURGUDs2YnQGykwaLaAQEgzD5cwHYZ9Sf6qADXcBEdOhWFGBVo8w
1hsl+lCQmM64ncbudP6eiZ8dZO0SDZgrTDKpSWrUlVXE8SGLzORaRZIZkf3OcttG
00X1m3gBGbb0pXEoZwUyXuE8dpgLSg==
=d3Hv
-----END PGP SIGNATURE-----

--Sig_/Exol.Wno/UhQybeCm87A+jH--
