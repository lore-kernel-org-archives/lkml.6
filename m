Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeENOIA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:08:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50247 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932421AbeENOG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:06:58 -0400
Date: Mon, 14 May 2018 16:06:40 +0200
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
Subject: Re: [PATCH v14 3/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls
Message-ID: <20180514140640.oig6hqbh5utvzhmd@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-4-dannym@scratchpost.org>
 <20180503144618.oojhvmey44dtg5fa@flea>
 <20180505085056.6c6011ca@scratchpost.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nskfsqj542gg4f7l"
Content-Disposition: inline
In-Reply-To: <20180505085056.6c6011ca@scratchpost.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nskfsqj542gg4f7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 08:51:43AM +0200, Danny Milosavljevic wrote:
> Hi Maxime,
>=20
> On Thu, 3 May 2018 16:46:19 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > Doesn't that mean that the controls will be shared between the right
> > and left mixers now, which wasn't the case before?
>=20
> Yes.  However Chen-Yu said that except for debugfs that cannot be
> observed by user space anyway.
>=20
> It's nice to have the NEW controls have multiple channels, which is what
> this does.
>=20
> >And also, wouldn't
> > the controls be called "Left Mixer Left Mixer Left DAC Playback
> > Switch" (for the first one) now?
>=20
> No.  I checked using "amixer" - the names look fine,
> "Left Mixer Left DAC Playback Switch".
>=20
> With the patch series, amixer says:
>=20
> numid=3D10,iface=3DMIXER,name=3D'FM Playback Switch'
> numid=3D6,iface=3DMIXER,name=3D'FM Playback Volume'
> numid=3D5,iface=3DMIXER,name=3D'Line Boost Volume'
> numid=3D9,iface=3DMIXER,name=3D'Line Playback Switch'
> numid=3D4,iface=3DMIXER,name=3D'Line Playback Volume'
> numid=3D1,iface=3DMIXER,name=3D'Mic1 Boost Volume'
> numid=3D11,iface=3DMIXER,name=3D'Mic1 Playback Switch'
> numid=3D2,iface=3DMIXER,name=3D'Mic2 Boost Volume'
> numid=3D12,iface=3DMIXER,name=3D'Mic2 Playback Switch'
> numid=3D7,iface=3DMIXER,name=3D'Mic Playback Volume'
> numid=3D18,iface=3DMIXER,name=3D'Capture Source'
> numid=3D19,iface=3DMIXER,name=3D'Differential Line Source'
> numid=3D8,iface=3DMIXER,name=3D'Left Mixer Left DAC Playback Switch'
> numid=3D15,iface=3DMIXER,name=3D'Power Amplifier DAC Playback Switch'
> numid=3D16,iface=3DMIXER,name=3D'Power Amplifier Mixer Playback Switch'
> numid=3D17,iface=3DMIXER,name=3D'Power Amplifier Mute Switch'
> numid=3D3,iface=3DMIXER,name=3D'Power Amplifier Volume'
> numid=3D14,iface=3DMIXER,name=3D'Right Mixer Left DAC Playback Switch'
> numid=3D13,iface=3DMIXER,name=3D'Right Mixer Right DAC Playback Switch'

Great then :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nskfsqj542gg4f7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5l+8ACgkQ0rTAlCFN
r3RI/Q/+PAO/voPZOI7mkTKuiCT0j4SLs3Xn9K1UojwPx0gbCrLScJBgCWpOuB8l
erMFBAd0LiNbfl1SpWrpigb0euBUVZyy4UL6vMOFtuq6HgI4qP7ix25pYC/PXCPg
Ph9hd91fztZePKz3cEhZwy2qkQR7EeBtwnKyjdOV3dokFarDZRT6QixUsLQTHvxa
lVnGraTARzVY3JPuPCdfIPTQVAPlHm5BHBotXZlWHf7+LYmpyKAdBtY6JsnhzWSX
UJq1A2HPylD/yl5mJm3UHKBlUS/C6sJQhjsYkycQWBSxV7smyLq1P2RQl8O5e6vx
vnTYWGHjyIIotqNzavICLMAQTgLU1hDJFlHm3kj972W8D/mk1XOJshjC8RWCqbhg
8vNwAtMxMgsVynMXau6254EUd1OAGUsiodsPUubBvJaYA8HcIgz5bmcTMrQwXeny
Rwlv9l7KOP7FTQhN3oboi95RKFzEZeFUz9VSD8WJdRwXgyTMuMRp2rJBW6eG1ai7
+cGulZJSyLV/7wlIY18JhqlNeVfbiTXe+FJCRZDD7m6X6HyPRY7K4/dSfezxNksE
1bt+u/j7tYuxdHGAJSvi+ZkXShkxpnG1DY/HV6Anq2DcXmY76fRWB8s+0dRyWume
Dxyd75qYuX2KGYAfo/nGxnBO+VNgWbglm0l6bMUoCbiEPXuGjDs=
=vAgz
-----END PGP SIGNATURE-----

--nskfsqj542gg4f7l--
