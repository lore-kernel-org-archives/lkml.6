Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeEVMKs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:10:48 -0400
Received: from sauhun.de ([88.99.104.3]:58550 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753004AbeEVMIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:08:34 -0400
Date: Tue, 22 May 2018 14:08:32 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        jglauber@cavium.com, kamlakant.patel@cavium.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH 1/4] i2c: xlp9xx: Add support for SMBAlert
Message-ID: <20180522120832.cuw5lbxafq4cl6bo@ninjato>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
 <1526454019-32714-2-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w63k2kyc4gozi7sv"
Content-Disposition: inline
In-Reply-To: <1526454019-32714-2-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w63k2kyc4gozi7sv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 12:00:16AM -0700, George Cherian wrote:
> Add support for SMBus alert mechanism to i2c-xlp9xx driver.
> The second interrupt is parsed to use for SMBus alert.
> The first interrupt is the i2c controller main interrupt.
>=20
> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> Reviewed-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--w63k2kyc4gozi7sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsECEAACgkQFA3kzBSg
KbbGlQ//WbJQtJsqg3aMDclF5UnKjutNvNGUKc+tMjz/XyWzbEdADv/JI/oo+Bsd
ArcMs+gmMWZKKpY4c3mlTEsbcuE9/KXIw1q3Ht7vnUhQdvOFa0lUa9xuX2xbAqc/
hOeEve1+tBJO4bPWKf9jwqttLJcBYvP7FHYJgWWYPrfNfUbTEgc2owKWH79TbniZ
uZj2fLopGdCnY86sKE92pDzkCdAe32b+acTkmDkCM6/xGcc9RO6sU2E+5WIV1A2D
bA6HdGBS5his48iav/asU5y8+/VBU1aWPbv/y2wdiF9p9vFc9Dy0XMpOK/DnBT5d
PQtRM6RrbA1kzgjmWzLpeuWrlHlrVcpd+GQDVfGG0+EoG/bN8f6GFn1YNrzZagFw
ezhWXsBW07Hyvgu8DhECkyGFCZNTARqvhimedJrwUk1ImKFsZbEOI5WjMjh/xxxp
g7dOhUB0WGSQhYDyYwX/V8EgGrIEu8ytlaIwerlMQZEn+sVA+8Pjru8SEUNMeL3N
1anTOsFjnQ5A8gRVX0w0dKRRkhcjkhSAtzSGOtGRo94el7yEnxKDxLoctq1Aeoo6
ztMlPwoe5AQlq0b/Hm+l8GNZr9QFLmKTeiKqTELcEKf6m8TDdTadJ7XOkXaZXwXv
Zb5950053OLOBIqxWjRSO8pAWS8/2BKZxo/5nL6KKpMoFpV02Ag=
=L+4g
-----END PGP SIGNATURE-----

--w63k2kyc4gozi7sv--
