Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755733AbeEHVPl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:15:41 -0400
Received: from sauhun.de ([88.99.104.3]:59258 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbeEHVPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:15:40 -0400
Date: Tue, 8 May 2018 23:15:37 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: axxia: enable clock before calling clk_get_rate()
Message-ID: <20180508211536.3lacmi4izgduaniy@ninjato>
References: <20180430144929.ld6wjyyrorrj5kcr@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="smmjfqopkswbny7v"
Content-Disposition: inline
In-Reply-To: <20180430144929.ld6wjyyrorrj5kcr@agrajag.zerfleddert.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--smmjfqopkswbny7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 04:49:29PM +0200, Tobias Jordan wrote:
> axxia_i2c_init() uses clk_get_rate() for idev->i2c_clk. clk_get_rate()
> should only be called if the clock is enabled, so ensure that by moving
> the clk_prepare_enable() call before the call to axxia_i2c_init().
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Fixes: 08678b850cd0 ("i2c: axxia: Add I2C driver for AXM55xx")
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>

Applied to for-next, thanks!


--smmjfqopkswbny7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlryE3gACgkQFA3kzBSg
KbYSkQ//QsqjcnnA4Ik2bofaQ2Ug2XbkrPKrlmi5hx5MxVP3RVNmbB+5UNwUJ4P4
tSI8QWqlv/UHmBDsp+PEC5+jMnSsR0Nt7dzrnxUiAge7fad9ILCp1pHODkDmwm5o
6q29WT7UoyEGc/wvRnCo2k0OISoxNVdGBrxsNK8F7Mjkrhl55CsLvVpbvw1ij+Dh
BEQky5fEoJNmAp0bDTcwDClKBXwKw3uomm4WSHh1boERD4jCjc5tTlzUSQpoJNUM
4gEFq2W+Fh3GMJ88LyNUv4bRIdmu/d4MN4atE0WnONwhU6M20BiiZwmogHwmAzza
dRSCum9k2dvFbzSVPyamLddSOQY0jnXGeUZq8wxzdcH5cZNHeHg209DDNckblm1V
E+mxZVoQomP/dKPH7Lz8vWLABu4N/JH09GRBzmkAIKyyF//96CPeI/igyfq4NNtD
OOqlVgWO2EZrBQtPcqsvQTYYm7kPbiZW2noJbq3AK/iTJOJymXcbL01yJaukUIAe
n8QVWIkoFpF+GiAyas1mkcaUQRZ4oBDSgYS9dx/Qt4AJEwAhNLjK3dtfJztm0nn1
lt2UQ5Sd2zfPqR2cKW2avlradjrZQGT67B2yuc5HLCLL7l/ROPfI1RGd9JnVg5XR
YibhNj60gRapWJgm2d22UBN+8XJYWy52LwZJ95dRNXpQ3dq4vRM=
=Do/k
-----END PGP SIGNATURE-----

--smmjfqopkswbny7v--
