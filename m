Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934022AbeCMQVx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:21:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeCMQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:21:51 -0400
Date: Tue, 13 Mar 2018 09:21:38 -0700
From: Mark Brown <broonie@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: samsung: remove redundant pointer cpu_dai
Message-ID: <20180313162138.GQ2186@sirena.org.uk>
References: <20180313133626.31286-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3wfpuDtTLg8/Vq6g"
Content-Disposition: inline
In-Reply-To: <20180313133626.31286-1-colin.king@canonical.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3wfpuDtTLg8/Vq6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 01:36:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The pointer cpu_dai is assigned a value but the pointer is never
> read, hence it is redundant and can be removed.

There's some subsequent patches to that driver which I think provide an
alternative fix for this.

--3wfpuDtTLg8/Vq6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqn+pEACgkQJNaLcl1U
h9AKUgf5AcxCWJ0oHWoN6eTUV0BBsBklpteqtkqoe3+mF23ic+8fKLqHoXXy54Tf
oUBToMtJm86A5vtdpMiWn5bKoIhz00hlOoB6ifEzo8OVCqGVjfboFIm4jDe86U5M
2dOx+oTvjU1GkX4YmnXQT6ydSmDV2WRDJXooj2+oMw1c4oMpuRU8WasV42bd9EDw
G0lllykMwVDwq8K4OdoArGgsCyenkucFzG0FTig/qHn3fWhFsDDZwh58TxbG64Tn
VteJqoMrwc7biNYV1uTHk0lOz1c/u5lHD/LAr5U9keXNar7Qr72p9ILckZuJNmnM
/OJGur4cMcrVhVyHndO9/GOWPLhNNg==
=0SDV
-----END PGP SIGNATURE-----

--3wfpuDtTLg8/Vq6g--
