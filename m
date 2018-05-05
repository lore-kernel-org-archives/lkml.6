Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeEEGvy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 02:51:54 -0400
Received: from dd26836.kasserver.com ([85.13.145.193]:50438 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEEGvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 02:51:53 -0400
Date: Sat, 5 May 2018 08:51:43 +0200
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
Subject: Re: [PATCH v14 3/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls
Message-ID: <20180505085056.6c6011ca@scratchpost.org>
In-Reply-To: <20180503144618.oojhvmey44dtg5fa@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
        <20180502210800.1971-4-dannym@scratchpost.org>
        <20180503144618.oojhvmey44dtg5fa@flea>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vzt_SN1Zr8bWNbQ9ZXq_W+0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vzt_SN1Zr8bWNbQ9ZXq_W+0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, 3 May 2018 16:46:19 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Doesn't that mean that the controls will be shared between the right
> and left mixers now, which wasn't the case before?

Yes.  However Chen-Yu said that except for debugfs that cannot be
observed by user space anyway.

It's nice to have the NEW controls have multiple channels, which is what
this does.

>And also, wouldn't
> the controls be called "Left Mixer Left Mixer Left DAC Playback
> Switch" (for the first one) now?

No.  I checked using "amixer" - the names look fine,
"Left Mixer Left DAC Playback Switch".

With the patch series, amixer says:

numid=3D10,iface=3DMIXER,name=3D'FM Playback Switch'
numid=3D6,iface=3DMIXER,name=3D'FM Playback Volume'
numid=3D5,iface=3DMIXER,name=3D'Line Boost Volume'
numid=3D9,iface=3DMIXER,name=3D'Line Playback Switch'
numid=3D4,iface=3DMIXER,name=3D'Line Playback Volume'
numid=3D1,iface=3DMIXER,name=3D'Mic1 Boost Volume'
numid=3D11,iface=3DMIXER,name=3D'Mic1 Playback Switch'
numid=3D2,iface=3DMIXER,name=3D'Mic2 Boost Volume'
numid=3D12,iface=3DMIXER,name=3D'Mic2 Playback Switch'
numid=3D7,iface=3DMIXER,name=3D'Mic Playback Volume'
numid=3D18,iface=3DMIXER,name=3D'Capture Source'
numid=3D19,iface=3DMIXER,name=3D'Differential Line Source'
numid=3D8,iface=3DMIXER,name=3D'Left Mixer Left DAC Playback Switch'
numid=3D15,iface=3DMIXER,name=3D'Power Amplifier DAC Playback Switch'
numid=3D16,iface=3DMIXER,name=3D'Power Amplifier Mixer Playback Switch'
numid=3D17,iface=3DMIXER,name=3D'Power Amplifier Mute Switch'
numid=3D3,iface=3DMIXER,name=3D'Power Amplifier Volume'
numid=3D14,iface=3DMIXER,name=3D'Right Mixer Left DAC Playback Switch'
numid=3D13,iface=3DMIXER,name=3D'Right Mixer Right DAC Playback Switch'

--Sig_/Vzt_SN1Zr8bWNbQ9ZXq_W+0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEds7GsXJ0tGXALbPZ5xo1VCwwuqUFAlrtVH8ACgkQ5xo1VCww
uqWwlggAgfHEgljWfgiB2oJ5uYkyydqdJvrws9QwwzJV9d8I8gN0HD6W82Ok+0hr
Q6JewwOxjBsBZwyBM0uT1k3QJoQhBU0DDkTjAkP6H5ycTKofCUkplCUVhndnEBnF
XFab4ZlnpcAxtIFAQ62ALOSx8wkXojVNvamay+YfXc8iFas/XOMVwWFX2SFBZVUa
b79DCj4mKhvRXbWqvqOFZ1EelrLeFhNlEDcRb9kmcWDb1TDk1ZDaoK9SmDiM+ho/
PzoREKY8mrfho8iPHtW4i3VqyCn8gOXpA/qu/CdAUQ8vi8cfqgI2m//hTSO1HoyX
JDn5+cNaTIlMBiTuxya4Zjdc2wDg0A==
=bxuI
-----END PGP SIGNATURE-----

--Sig_/Vzt_SN1Zr8bWNbQ9ZXq_W+0--
