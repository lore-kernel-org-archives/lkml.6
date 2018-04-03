Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeDCP0H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:26:07 -0400
Received: from sauhun.de ([88.99.104.3]:43166 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbeDCP0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:26:05 -0400
Date: Tue, 3 Apr 2018 17:26:04 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] i2c: i2c-stm32f7: Add slave support
Message-ID: <20180403152604.udgh4v2erpsupgo3@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-3-git-send-email-pierre-yves.mordret@st.com>
 <20180325181600.vehqe3xcx55qxtd7@katana>
 <94737125-c0b7-08ca-c2f7-feb4e5d0498c@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qfvqwuivg7flquuk"
Content-Disposition: inline
In-Reply-To: <94737125-c0b7-08ca-c2f7-feb4e5d0498c@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qfvqwuivg7flquuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 10:41:51AM +0200, Pierre Yves MORDRET wrote:
>=20
>=20
> On 03/25/2018 08:16 PM, Wolfram Sang wrote:
> > On Wed, Mar 21, 2018 at 05:48:56PM +0100, Pierre-Yves MORDRET wrote:
> >> This patch adds slave support for I2C controller embedded in STM32F7 S=
oC
> >>
> >> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> >> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> >=20
> > Looks OK from a first look. What kind of tests did you do?
>=20
> As mentioned for 10-bit, I'm using 2 I2C instances from the SoC.
> Here are the tests I dit:
>  - Master/slave send in 7 and 10 bits
>  - master/slave recv in 7 and 10 bits
>  - E2PROM Read/Write

As far as I understand the code now, both instances can be master /
slave simultanously on the same bus?


--qfvqwuivg7flquuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDnQgACgkQFA3kzBSg
KbaRKA/8DwUMYUgeaNpboD15JOfVpRCDDVJIphlon3oRKvBxH4ryR4xkQT7fsueH
xvCnK0w+C10pjKDWIf52iIzcsnjDtvGYb5b4ZZCeGhC+5bnuit3pgXg9pmbWVFmH
POBTVxBsB+gyhNACSNsahZ2QyHOyy6wLreaQlJHtbOAU3s7mCHWSsmb9cyeElq6v
V9JNyiuI+3rcWUQy2oqtmZ4GoJ0Rs3doCHIE9YjxXSQS/dNuSdJ+mbgMX2Qe4lCf
KLqyUaxERuAiMgbEURXn+MAp7+nTJ3QZJekyrXE+DwvXI/zsdbLjcDoCN+l85hcc
GmB+/CpIos7XkEM+QYq8lPfNk7yUeRp6j8U3qt6tgiLIh02f6RhXc9MvXssqCl6k
/4SkeccuyP0Sapft/it16D/bQU23skuZMhu84k49TV5fAHfNGovIVa8kLQ6o2g+A
NspD0GxObOPqIbwh3lPXkgStmTneZvzw5Y2rPkUjC7KlEiLgmItGybOJfnR6c2Dr
byni7FmvZ1OGNHFiTINZVFU6AVRV18+HdYlO2sejkVjHDdiB7XKmJ6EAutPDqHzk
lefYT9/29ePoL3M5zNxXS13tKAdMJlaKW6q2HEii1fvAiV2n2aHyClPZOMVzCHHk
fcQhjoJFHnrb61qHYlfFO1kYAfn59cdrfalMF7phvx0ZHrsSV8w=
=y8Qs
-----END PGP SIGNATURE-----

--qfvqwuivg7flquuk--
