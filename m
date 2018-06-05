Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbeFEXsr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:48:47 -0400
Received: from ozlabs.org ([203.11.71.1]:45629 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbeFEXsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:48:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 09:48:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: merge window
Message-ID: <20180606094843.6980d508@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SA3goG=MrB_lZ9KutUO7TKv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SA3goG=MrB_lZ9KutUO7TKv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do *not* add any v4.19 related material to your linux-next
included branches until after v4.18-rc1 has been released i.e. during
the current merge window.

--=20
Cheers,
Stephen Rothwell

--Sig_/SA3goG=MrB_lZ9KutUO7TKv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXIVsACgkQAVBC80lX
0GxdOQgAkKFbdsbA2kP/lVV6OCAaot7iRziAZwn5IyEitpgnr9eSRgS0TG8OaIID
TtePPEEJ2ElIwKcrd2f4vBy98e78UFxyEIHNwBEd0bT+OvRFWOwKKxYjRFCYTIEO
O3rEpmn76BzvJL76SyzvyHEFSyLMLW0/FoABmFUKr+cRjQyjBrnVu90+uoGpvoNq
BG8Oe8/9Hm/QjjmRs20EVlp0Wixevzn0OtTLqKXRo1GR7O+GwmNRMuesBBl8busn
zvSYpQN1ldABFOuIzzo/7CmqJ3zO4TnBrDKQ+e8IhWd7uihPN1TpckXutZI4egXd
ub5gpUOPc9ndoMT6cB95TcECwwy/4g==
=Uazg
-----END PGP SIGNATURE-----

--Sig_/SA3goG=MrB_lZ9KutUO7TKv--
