Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeCQUTI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:19:08 -0400
Received: from sauhun.de ([88.99.104.3]:38532 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeCQUTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:19:06 -0400
Date: Sat, 17 Mar 2018 21:19:04 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 35/47] i2c: remove bfin-twi driver
Message-ID: <20180317201903.ii4aiefgcxs6dzow@ninjato>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-36-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qqu3qz442oagv6g6"
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-36-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qqu3qz442oagv6g6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 04:35:48PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so the
> twi driver can also be removed.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--qqu3qz442oagv6g6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqteDcACgkQFA3kzBSg
Kbbi8RAAiEb6dCViOvLtYVhr+SgvklfKU1hgJ4SlE/+ZWR/Ho2F2tkhg15FthK6R
yIRH+VNWP281bHkNir8R0hrRaLmVZAnNAaHtXrQ5HzX/51XxCI8jZ0X2QnKTePkE
RaDzNg5hc2Peb5+/siHYpGzbkTg4U9CN/31+RyRyyRXtFfNB4aIW0ZkTjjIk9xHJ
a/OXJKjS1TPU8AinVgQVAQpTgpPd8UXnmC1I22BxC6eLRYW3TbmPFEJO6QW79D/a
GRIY7BmY9NzsM3qETB868j1GxitTygPTHQeEN+BwHN9uWf2nQUARGyGWmI1Px2Uq
GkQZUvVEffyHabLpoHYA3u9+rcblswsDR/Bip418KaGb1PA9lddZ+W3XRG5QrB1n
lbnNZGxsEs1uimGOwGOwTumkgShVpyfFFNEDqK477y5yoIsTesQJBCF5Uy53D3T+
9vIBfVGB1Lyh0bRnHTCfNZwyoeG569NBvFmwB3hP3mTgbhk7jfy616ES/rve7kDM
tGgEax6/6BULeDQZ59ZVLwpI5p4CVKKYvPyxfxNhf3jvehwAWfV0NjTtYQsSlcg5
bcP1g2eWfID7T8g6zLJ4kIXLQMXerCJRgs5hjb6VmrnTX13ud21z/iSPFnRPR8NV
8p6qIae9tvUegdm3X/0o+XDaPCR+KKuSYh3kCrztC5mm+WsfOSQ=
=FvHd
-----END PGP SIGNATURE-----

--qqu3qz442oagv6g6--
