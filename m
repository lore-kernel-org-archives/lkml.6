Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeECOyt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:54:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57783 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeECOyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:54:46 -0400
Date: Thu, 3 May 2018 16:54:08 +0200
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
Message-ID: <20180503145408.yymk2ndt4sm2yt4i@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-9-dannym@scratchpost.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="odizj5wdfscxpmbv"
Content-Disposition: inline
In-Reply-To: <20180502210800.1971-9-dannym@scratchpost.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--odizj5wdfscxpmbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 02, 2018 at 11:08:00PM +0200, Danny Milosavljevic wrote:
> Add Left Capture Select and Right Capture Select for Allwinner A10 and
> Allwinner A20.
>=20
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 50 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 45dcb80a1da9..1a4ba3bae5da 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -706,6 +706,25 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp=
_gain_scale,
>  			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
>  			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
> =20
> +static const char * const sun4i_codec_capture_source[] =3D {
> +	"Line",
> +	"FM",
> +	"Mic1",
> +	"Mic2",
> +	"Mic1,Mic2",
> +	"Mic1+Mic2",
> +	"Output Mixer",
> +	"Line,Mic1",
> +};

Shouldn't that be defined in a more generic way? As far as I know,
there's no way to tell what the difference between "Mic1,Mic2" and
"Mic1+Mic2" would be from the userspace.

I guess the larger issue is that you'd need to have controls that are
common to both channels (ie that would change the routing of both
mixers), but aren't sharing the same controls structure since the
label would be different.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--odizj5wdfscxpmbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrrIo8ACgkQ0rTAlCFN
r3R4ihAAjeNAv1d3i+hQ8vO6K4uLt/wziSi+/U0/a8axRtU4M0XrmgIdoE2BIAJK
clXkJWbn/CU9k5ooKT9c55hUV3oLrgCzmRNzczBTEpfGxN7aJVlOWNZAOMeMn/Mc
zDC/pupLe/vXHu7GyGOV4Osw8vON18SUcIy60dN6PcXbqYeujMnaEBQufJ2ny1ld
ltn4Q/AAK6GsgIkn4O3dMZeiuadYe6FwEr8SjWgwoqSLyE2/I+7tNfhvdvfPrT9J
1H4euJ+KPjabeBX6tro3lsQjKDZtlJ9N+CmpKOdwvH1Bi0j80Ai8Zi0NRZ698UCy
MFJGpk5AxBwnZ2A3lrSvNWjKNa79/Ehwkghx5QxlrKculDTRBp9SxSEZPeTxBHiO
fTjpU7rsSv4YhZ/8Rod12nyQIBu8mh7IIiqJKdWnFBXtOp+JEV2hjBgwc2bh+Fkf
mxVYHVhbO8EzZ1xGr+ENt24zFw1uvtItcRHzAqGaMlBTEql+wIa2ngMAiQ+oE8Ey
6QBuDWTYHOHz1sIzfDxIhp84aO5HDdhV+eJiJwP28LvtRC1IPRoomoxTNC48LNaX
q0ZeMm+4fGgb+ZbOyMNMBS/M5Axj4+vJLG6N5X9PosDbBg6JeNYhoHcAviY8wbpm
jjS69VenVoYvGJh2/0wLOdrXwL1uUoZzsSTiYJP3pOPvquD6j1o=
=T22u
-----END PGP SIGNATURE-----

--odizj5wdfscxpmbv--
