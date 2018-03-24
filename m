Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeCXWtQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:49:16 -0400
Received: from sauhun.de ([88.99.104.3]:44634 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbeCXWtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:49:13 -0400
Date: Sat, 24 Mar 2018 23:49:11 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] i2c: i2c-stm32f7: Add initial SMBus protocols
 support
Message-ID: <20180324224911.xz3fz2jojcdrovb4@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-4-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sklbx3tvqlhdejsu"
Content-Disposition: inline
In-Reply-To: <1521650940-11651-4-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sklbx3tvqlhdejsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 05:48:57PM +0100, Pierre-Yves MORDRET wrote:
> This patch adds SMBus support for I2C controller embedded in STM32F7 Soc.

> All SMBus protocols are implemented except SMBus-specific protocols.

What does that mean?

>=20
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
>     v2:
>        * fix Kbuild test robot issue (Unneeded semicolon)
> ---
>=20
> fixup! i2c: i2c-stm32f7: Add initial SMBus protocols support
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 377 +++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 368 insertions(+), 9 deletions(-)

That is quite some complexity considering we have I2C_FUNC_SMBUS_EMUL. I
don't mind, but you really want that?


--sklbx3tvqlhdejsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq21ecACgkQFA3kzBSg
KbYJWA/9G6w2ZUnPfdk7YwmthkanC65ig0rBZGgM3uBJFQyV/OxyE45V0sgMwRAu
EjGo1mrQzNq5aXeBrWxmFferEWbAnaeSiryiZST+uhytRYCvsfpiqkvAI2Hctshg
KPJSVwejawKatbFt4BCb3CKtpEF2QdwyqOcAbdGbFi7zR84wtC+RDKSsH3ecFTgZ
uXGkpqszOwxJoiNYw518h0QpyRWJoQzrBU5M4VaJcFbK1JsEg6WSnGYzOQBLN/Eu
T4ZrAsMDoMulx1SSnx2irf19ihP5zonJD3il/yGN/V0j7SE84DwVTT+YXhzRO2Tg
tdoFIZCKUA2hsMHv7CQb+WU1PkKu2pUmuIp42MJVYM2qlQOof+pNOt/CaSChw70Q
qLvvwVNdtxKLJxrwubvFsnUcbVsnH3fUJXUxnVEJk+CZru1gg7IxYgJCQrVRke5E
xpyFZR9Tw/Rpf4AS8iv1v2XaOhI7OF4f8Z2Nzp7Tew93rqXWW3Ts1P/kPh0a+HdE
w34LgrKso1Q2l88c48x+9EBWndlc0OQIscYLMxR6wfIIQgWrSLZE+hmmnGUzPhZn
vV23qHG8IZrk6+SftWLGaftFE/RpJ10XklWPhYRUWnYgEv72DM+E+0YlGkU2mTMe
gMqROvjiHRknq+P3Y3tem6HSAqslxGaz4OysMq0X9YMiIpJcEs0=
=mEbP
-----END PGP SIGNATURE-----

--sklbx3tvqlhdejsu--
