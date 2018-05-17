Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeEQOHV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:07:21 -0400
Received: from sauhun.de ([88.99.104.3]:51534 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQOHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:07:20 -0400
Date: Thu, 17 May 2018 16:07:18 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add entry for STM32 I2C driver
Message-ID: <20180517140718.jd2q6vybugjsjnkp@ninjato>
References: <1526026959-3255-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gmyaanfqt5pmxqf5"
Content-Disposition: inline
In-Reply-To: <1526026959-3255-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gmyaanfqt5pmxqf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 10:22:39AM +0200, Pierre-Yves MORDRET wrote:
> Add I2C/SMBUS Driver entry for STM32 family from ST Microelectronics.
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Please always include the i2c-list for such messages, too. Nearly missed
this one because it didn't show up in patchwork.

Applied to for-current, thanks for stepping up!


--gmyaanfqt5pmxqf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9jJYACgkQFA3kzBSg
KbbPPA/+P8C02eo2CkwVlO7udKHfua5wlEeisunoUGEapVl37NtMQhc+o/824gWz
oboH6gmCXDZmnK03fRg19iEK7Xe8Kq3Sa94qr4oOkIO+V6vb+MME2bte/LZwZZDX
j5rGRWYeUFHMAmxmGuoEZ77pC8SQ41VMmuqmdf3U2lj/ZelCGbIcpoIbSgsZJxqJ
1XcbDUDfl6f0F6iFKfui752NTHkWdmSL4+F2/sQ7GvJrW/P88GKLCXQh/IMDV7nq
CsOZDUN+dlpp3PTte8oz+q/mJtbYpCvuSecr5MrP71mSqTiDj9cfUzJkTZV87iWE
kNFaTc5wFjmWkMgwh3/D5ZhmXdi2oysUZ95Zhvd9biKF0VaDHCU6fEatuvWkUr97
JB6K2W9LeuGHYRkPeQFrmMiWe/4rYAzsQmiTElJJj9DJY+4qrgM3aZlkftApnfw5
V3vPg7JYicXi+2uQocv1Ke7xlKUsYOXK8A3DCLfkGomWN7qGYNIS4SxMEt5SBqjX
wh3cVeDiOg8a+eD7EfBI4EggSD4MrhcuE6n2enDLvERnhVZi+WxXJgAvdTH84a+U
aWMGn8ip95g6Pp334AeypQzoZ2g2Ag/fLuSCNYmYxPVXiD5UUKaN8JwiRxkuTCbN
zKwC1E3llwxsPl1dYCv9eU9AITQS5RD64na6Qyv2HifBllB1xE4=
=Y4MH
-----END PGP SIGNATURE-----

--gmyaanfqt5pmxqf5--
