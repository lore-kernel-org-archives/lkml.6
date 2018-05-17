Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeEQNy4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:54:56 -0400
Received: from sauhun.de ([88.99.104.3]:51438 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeEQNyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:54:55 -0400
Date: Thu, 17 May 2018 15:54:53 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: fix unused-function warning
Message-ID: <20180517135453.ori4uopsqnxn6wte@ninjato>
References: <20180510152719.6e37b10e@endymion>
 <20180514093326.30314-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vro5bi3toditkjgc"
Content-Disposition: inline
In-Reply-To: <20180514093326.30314-1-anders.roxell@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vro5bi3toditkjgc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 11:33:26AM +0200, Anders Roxell wrote:
> With CONFIG_PM, we get a harmless build warning:
> drivers/i2c/busses/i2c-i801.c:1723:12: warning: =E2=80=98i801_resume=E2=
=80=99 defined but not used [-Wunused-function]
>  static int i801_resume(struct device *dev)
>             ^~~~~~~~~~~
> drivers/i2c/busses/i2c-i801.c:1714:12: warning: =E2=80=98i801_suspend=E2=
=80=99 defined but not used [-Wunused-function]
>  static int i801_suspend(struct device *dev)
>             ^~~~~~~~~~~~
>=20
> Follow design pattern from other drivers like i2c-brcmstb, i2c-mpc,
> i2c-ocores, i2c-pnx, i2c-puv3, i2c-st, i2c-stu300 and i2c-mux-pca954x
> and changing the ifdef CONFIG_PM to CONFIG_PM_SLEEP.
>=20
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtim=
e PM")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to for-next, thanks!


--vro5bi3toditkjgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9ia0ACgkQFA3kzBSg
KbadwA/9GsKwsmiOW7KLc3Cfv86pVOZaEF8HPeccuW+fkZk4hu+9mEtta6fE43bH
rBFAGAcbzU7Uv73zZ8OEogLPB+EnI3r/vrMD+3dvpBLlQOJ2sp1uzBg1JiZz+MsR
OJa1a+WFC3s2J3AYCWUNJ2cc83YLSiImQQLJfgtDyCUJGPcMrTetx3r85lZfM0Dd
Nvaab1Pg7gkbuAsaynTs7NUPqngSc3lHkKUfB1TW0Dx2rGFVg3lw342pfh//VJwq
wfBm2CsNwGY1EN5xXcN6A+FQVhUYCfGKq9FvaawGCya6c7jDapOTe86AN16FbnUw
bfyWmudlVrnPg8a4KdGiDpmNinUHcCdvgh4zrWES45Z5Sp7PvXKKjy746ziULZRe
stdel7ov36WtghkLl9ncABWuZLXJPoE34GRem2xwqisvLqSTGvRTTNlq5zpyTQv9
m2TTlAmbvxEzZShf0EU7BFbZ/LUKXK3ThRgMogrulp4H3DhP1xSq0umx5F/3x8o7
zmrlxB1bft2L/DLqxmYffRF8Qe4yjQeAc61/RNrfmdu7HYseuYs00cC9ZYHS1f1v
pydbP5ECgGszAgeBJOLeCQ8rwt2enPTMarPMy6svRKBu3kw1zMau0jrq8bLM6dfJ
zD2BSL3Wwyqsau8pBV8xVzCZtZ8LUbtDFEtsAoEEeKbfddnX0wQ=
=X2Ca
-----END PGP SIGNATURE-----

--vro5bi3toditkjgc--
