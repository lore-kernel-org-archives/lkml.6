Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971394AbeEXUP6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:15:58 -0400
Received: from sauhun.de ([88.99.104.3]:48604 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935330AbeEXUP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:15:57 -0400
Date: Thu, 24 May 2018 22:15:55 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: robotfuzz-osif: remove pointless local variable
Message-ID: <20180524201555.x6ayvjjayfqmjvma@ninjato>
References: <20180509194658.29106-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bdxkkb7hphylmgqs"
Content-Disposition: inline
In-Reply-To: <20180509194658.29106-1-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bdxkkb7hphylmgqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 09:46:57PM +0200, Peter Rosin wrote:
> Just use the value directly instead of assigning it to a
> variable first. And then drop the unused variable.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--bdxkkb7hphylmgqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsHHXsACgkQFA3kzBSg
KbboEg/8DH5FJaUJt1oW4VDJmfHirFvcJCpYvWlp6kUITNJGONJx/ZDTSfhtx2jf
TSLFnu5w1BdEra3M8A6yB5kldYdDZ88q1FtfvOtj3UZtXfMqzNyWE2PoKHu59G3p
0Zbtugja+cWIZcodykUwIg25CLJ6OUWW2Tzryc7A1cJIwi9MiGh8xSAHCVpr4TsG
yncd/MtnMXus4Z6DAPMoP4HPpKQ2KHafcKI5xjWKGCo4bToawHaS49VltBX5wmHg
umU3LPUdiHnuFlP8HGNNCJ5KuqfFA3qOjKLgvz+jKFtxxdmuhyBjNS89WITvhzl2
mf6ZVSehzMrYWy0NFWHEucjHMlsDuowjRQyykeM7vcd8pUfKuHjMMypux0yMWbOv
brd1BoCQOVGaVEBcbRmh7V6c7+QMoRPz43vkqaeh2L2RKMLk8wlV43RCJaen8A9h
+/OxZxnaXVKAC3DUoJzjgSUnD3KUu9gglEI+ur1AQguLP3Za66vzn+y4OXGshCsV
kOuFIenfDhnNRDE/wWgMNvSuhmzXg+cfGm1frLOP+c9jX4ChVcfkfLEHOHqeXSJi
knqSt2DcegayStoSAIISbt/5c5XwfLisqHqowqlvDKK+t2FGzdiUiYQW01sNLP4Y
QBO4jK2Zqqo3hNS3oKgfYhIEMG6ODDnKVJqQnAAdroCBzfshSfU=
=Gtvl
-----END PGP SIGNATURE-----

--bdxkkb7hphylmgqs--
