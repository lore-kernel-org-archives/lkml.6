Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162968AbeCAXKT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:10:19 -0500
Received: from ozlabs.org ([103.22.144.67]:53963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162938AbeCAXKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:10:13 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 2 Mar 2018 10:09:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karsten Graul <kgraul@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180302100927.0928653a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uFkRDOJnzDg0/xUaFdbOYIT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uFkRDOJnzDg0/xUaFdbOYIT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/smc/smc_core.c

between commit:

  2be922f31606 ("net/smc: use link_id of server in confirm link reply")

from the net tree and commit:

  52bedf37bafe ("net/smc: process add/delete link messages")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/uFkRDOJnzDg0/xUaFdbOYIT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqYiCcACgkQAVBC80lX
0GwPZwgAnFA+0KcFtBpX+v7cG29U7YxF5GztEyC2RKFyOKYtJc5ND8qX2E/5mQuB
R9diot6GDj+C3Yb82IifLsCF3OtvkJgFdiSqb94aPljqNrzZVHFbjEnMAhWb01IP
IP7Ij0TqwyejX4dEAP9xg3i/hyMdpvrRolXehcnmHHv7/3SRX+vL+WQmczXucA97
4cfdO5xiiIYfLk2ryniRLuPQSLGxggtThWug4oHCd3gjDAmtrjRFwUNLzGd5mWbO
ePyIZe9jkaM3/llModmEwwH0G8nWIYK20RvSeXDDvpmIFVipYCrpk6MjSEkyVKn5
skPcdrminFnVO05C/HPyiUH6K+umKw==
=CCUm
-----END PGP SIGNATURE-----

--Sig_/uFkRDOJnzDg0/xUaFdbOYIT--
