Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeDQLSS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:18:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeDQLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:18:16 -0400
Date: Tue, 17 Apr 2018 12:17:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Olivier MOYSAN <olivier.moysan@st.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>,
        "jsarha@ti.com" <jsarha@ti.com>
Subject: Re: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
Message-ID: <20180417111733.GG8973@sirena.org.uk>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
X-Cookie: Depart in pieces, i.e., split.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:

> I guess the blocking patch in this patchset is the patch "add IEC958=20
> channel status control helper". This patch has been reviewed several=20
> times, but did not get a ack so far.
> If you think these helpers will not be merged, I will reintegrate the=20
> corresponding code in stm driver.
> Please let me know, if I need to prepare a v2 without helpers, or if we=
=20
> can go further in the review of iec helpers patch ?

I don't mind either way but you're right here, I'm waiting for Takashi
to review the first patch.  I'd probably be OK with it just integrated
into the driver if we have to go that way though.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrV18wACgkQJNaLcl1U
h9BhwAf+K6KCxAJQ456jenbORVhomVdfTbV3KBBzJ6310IiR0Q2XU1ZwQVnWFRMU
H8RL0UKXcBN/d5vRHV2yETlmn57YR6C6Y+9mC+TAnX13jQpEMIpY1eQrJtlGl52y
V2jFR2JQsxoZULHSq79w+Hv7yC3nMMUvhz6Rtaz+3neQY7iIzJoIFkRkLKcudEnU
TzELW+CnwbqmtkQeIIAN2qdwL5EOZbHY3pSK6r5tiHd5A+CSkBLghyqgDGqbfXGI
Z/81b738xd69CHuZW7WJpmaMffwyrkw4RJotgB24Mmv0KWSVBYE3JzAqt4ymnRnd
oe8jOo3Xh1dcDYlAPIXu/oEWfYUvIg==
=gzqA
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
