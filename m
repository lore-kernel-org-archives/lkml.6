Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966775AbeCHFlW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:41:22 -0500
Received: from ozlabs.org ([103.22.144.67]:47863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966217AbeCHFlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:41:20 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 16:40:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: Signed-off-by missing for commit in the rdma-fixes tree
Message-ID: <20180308164058.2ad5a158@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LOUguDnAkTR=NI_M=g1/QPq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LOUguDnAkTR=NI_M=g1/QPq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/LOUguDnAkTR=NI_M=g1/QPq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqgzOoACgkQAVBC80lX
0Gw+ZQf/S+3Y14ncFD0P5ZqMdoXsRV8L9vRel6hRM2zhMsZLxBxc9vc0lbKQzi3P
xX6E/bmKP36bTDL+AztCN5rBr9ZJWFSqrIBh930n7lweevAVgueUhreUfQ7c2DdW
DPRjZAFO2ZHFC4AH5++vYpxlkp+wxnWsFPExRjkQTpL4LYXu611SMQH6SxxsU2Vh
cWq7W1GkTEOPbSLdYnDnRDBvHgLdjHYAFknLiq5715oHPvAOTY3X9GDI9uUt4W0E
chxZUznEoZC3lvJBVj/sduQrBeOG4Fw1X4HMJny5ilUiVY0C/faMK9wKi/oMuNXi
nIo5SQD2jQz9MGd73lieknBeQH4wIA==
=J6cZ
-----END PGP SIGNATURE-----

--Sig_/LOUguDnAkTR=NI_M=g1/QPq--
