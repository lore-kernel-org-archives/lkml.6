Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeCFPlU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:41:20 -0500
Received: from sauhun.de ([88.99.104.3]:44450 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbeCFPlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:41:15 -0500
Date: Tue, 6 Mar 2018 16:40:59 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jan Glauber <jglauber@cavium.com>
Cc: George Cherian <george.cherian@cavium.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/3] i2c: xlp9xx: Check for Bus state before every
 transfer
Message-ID: <20180306154056.p3vapgvctxpijitm@ninjato>
References: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
 <20180306084829.GB11729@wintermute>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvkl5gyybjujn7rj"
Content-Disposition: inline
In-Reply-To: <20180306084829.GB11729@wintermute>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvkl5gyybjujn7rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I don't know how valuable same-company reviewed-by's are in the end,=20

Case by case. And in your case, I trust you.

> but the patches look good to me with the small change in SMBalert, so you
> could add:
>=20
> Reviewed-by: Jan Glauber <jglauber@cavium.com>

Thanks.


--mvkl5gyybjujn7rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqetoMACgkQFA3kzBSg
Kba1Iw/+Mxxuy/sbxjLZb4Jl02YQHBneo6jdbOunV16Ucg9v3JQa8OAqUFgLyVnJ
hiTCFki8XsM9tCbBlenxb/h3pSKkNXivOXnM/P5tyNetg9cL/vu/zAIpdFHuQYi2
NmkKxraGgTDjRZTyVSwzrURgUOu517H6q9tl4djXEMCN3rLgWFKjO4NaZEtwkf0y
z09ra51C6ARCbCeRyn1B7+BARVcCr4rJjWR+H2yZIsRJC82ChC6nvAVuBJErcqcC
sVVG/3wkxp3JUpuQnQDPfxy43zROx595pc+hYkGL9usi+ioZQWTnYO58XqG/6QaP
Wo1wLZz+R+T6CyOOiQs0sNZZ5QibtMWgIrAYstzZgVL2/k/9b3yXEsTP7o2Y3q6c
R+1OhPhOPRMHXvMXeJWdw4BIYM/3DlG73HyVYq8zkmTh/7EnmgyUd3qebUjI5wVu
rMfaPhecNnWm1iHsrweKHtOxdvNZhVXR7TuGR9IT2Q03apSYOrnvPYMHJyRaXJ+X
nzriEWOWGlWIBxjAnH9HZsE9UT97ZcihBSzCUK5KrArqvMZwtptsIvIQg8HgZm3v
fewdL78VWVkgiKt/pbatuvgBcUbS49pZJTUpQ7D4gL2MRa+ugc9xNS9pCcan7Bvn
atAp1U+/gsc+1rItOnTke3QynuWegjTYADURFq1pt4VQxgHz5mI=
=RVGg
-----END PGP SIGNATURE-----

--mvkl5gyybjujn7rj--
