Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCNUns (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:43:48 -0400
Received: from ozlabs.org ([103.22.144.67]:56389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCNUnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:43:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 07:43:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nvdimm tree
Message-ID: <20180315074316.3bd7c719@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CQ_gA1KSnkNKxfjfpSGpzG3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CQ_gA1KSnkNKxfjfpSGpzG3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Commit

  07974c130d5d ("libnvdimm: remove redundant assignment to pointer 'dev'")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/CQ_gA1KSnkNKxfjfpSGpzG3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpiWQACgkQAVBC80lX
0GyqgAf9E2noHJXueyHLG94DtoRUvOZBP159BVaQyj/CWOhkUzlFrS+/2vnm1hlV
AHb95iVvGB1Ziq9jlDMcUIVm9f93hkffkBpMktEXyLGvVNU6iJ//A2KGzl0rojLb
03AJD4Zn0OCc6d3+UjRI6u19OWg24JjUMKVYjnO5Pa/8eDIoAtqMrGrsbKpUuuus
eX6VIYUXfpgtvWxRQ/u+ba+JTVNVKuDwNC+cCKIbUtWA96NGSv9c6u3R5Gwq0/4p
MpHcJJHCVups6Z6tP8ZWTxWn8rgJjy9RcsMwNTvzxxqNc7ush/MpY+QHUc0QY1eb
qNS8cS3cRy4713eokZh6TlAbPVe8mQ==
=P1ak
-----END PGP SIGNATURE-----

--Sig_/CQ_gA1KSnkNKxfjfpSGpzG3--
