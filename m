Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeCXWvl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:51:41 -0400
Received: from sauhun.de ([88.99.104.3]:44674 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbeCXWvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:51:40 -0400
Date: Sat, 24 Mar 2018 23:51:38 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] i2c: i2c-stm32: Add generic DMA API
Message-ID: <20180324225138.d5yipagxiouoyqtl@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-5-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uvdlpempsejo3jkt"
Content-Disposition: inline
In-Reply-To: <1521650940-11651-5-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uvdlpempsejo3jkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 05:48:58PM +0100, Pierre-Yves MORDRET wrote:
> This patch adds a generic DMA API to implement DMA support for i2c-stm32fx
> drivers
>=20
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

In case you haven't read it so far, there is a new document about I2C &
DMA -> Documentation/i2c/DMA-considerations

Just so you know...


--uvdlpempsejo3jkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq21noACgkQFA3kzBSg
KbZfCA//csz1K6/xNL93FGj0k8zT7EGw3CG/A3Tguihl5MTuXwAh5L+rcf+J+JDT
VApbBKSNRjvdhr5FG6/csansoVjHMkEnUWtcGsJF0ahuQBuD8Hg6Z3nE6SO44IXn
10bqkRoLmm2ij6LYPkeKAM0wEIzVe2C6PWuPmNqfMvVp1zcXR3wk/cPdlStMoP59
fJfAlMoZ2xG+BOtSYs9e+FuEAz4znycNpKpzf5+QtuQcWjJW8BeyYJxf0k2mBRo4
JWAGWoV7oVIiY9aUU1gEjPBJ6Vy04JJLTdU2gN/Z7Cg1DrbRwlyU03B6M+aSBm9B
HFl09ixvx/9VeZ9jLoSyWdlsg5Q+oDGXXFYA0cRlmfUEXWPlsgBZ8moPi9xn9dIW
Bivrbpheerox3oIlbTia0VyhG4Ox8zMc1gU4FKupCcLTMS3A/mN6t7d29qqDnoAO
m+4rseAPcFb3ogAGBdPYnaP1U9AV77CZB/bDw7m+yodiI6IUDpJlUSfZwEba1X+0
J9SH+3nUqkjiH4zUhCu+1BAU4SzgJFaQlh2jjDhlmWIwM5lBzWSDT4KTvTkQeDJ5
lQOuf2WQ7DCnbvvUmrgd4AzJdJ9INkocIUcBoGZ4u/QqSvFG6GpvyudBsZGsChex
MrWLfG70XPpuIW35RGpFadV47zhdDCK8Q4JgagNsprAS7IJ0Sds=
=ItZT
-----END PGP SIGNATURE-----

--uvdlpempsejo3jkt--
