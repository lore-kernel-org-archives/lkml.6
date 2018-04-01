Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeDABjv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:39:51 -0400
Received: from ozlabs.org ([103.22.144.67]:33529 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbeDABju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:39:50 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sun, 1 Apr 2018 11:38:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20180401113828.05bf52d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Mw6kmUKCKhy7k7bSojDqmeQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mw6kmUKCKhy7k7bSojDqmeQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7127583a1b4b ("cifs: add server->vals->header_preamble_size")

is missing a Signed-off-by from its committer.

[I am assuming that smfrench@gmail.com =3D=3D stfrench@microsoft.com]

--=20
Cheers,
Stephen Rothwell

--Sig_/Mw6kmUKCKhy7k7bSojDqmeQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrAOBQACgkQAVBC80lX
0GxyAwf9EaEJUTwOC+LTuEXVMkBBUHXC2l60K30NLbi59HXjQEBCZRzPxh2R+GWZ
G/bj2Wotq7ABgVcfAIfLt/S0ML0lbecherseRiDooBpcQrqY/MpuKtWAAOzDaivD
pcR90JkLbejsMZsPro9LxQFA8IKsTMJ65n/2rtNSwi3CYFo2YUI34zQUwrYpc2Ja
to9N2NXt+gXtqR5NOpdZX+2C3hYEOAEGa/+nFz1c24v2d0O3Us2clggPcX6kD0P+
Bvc57P30B9xvrAkfDNgTtWaq4nUAOLANgsA9MaDDyACKIWPkY4IVhN0tz8rmEJTV
IFOiXuff7nzEFcGLyPEwuUNmnFsMKA==
=+5Py
-----END PGP SIGNATURE-----

--Sig_/Mw6kmUKCKhy7k7bSojDqmeQ--
