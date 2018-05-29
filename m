Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161416AbeE2DKo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:10:44 -0400
Received: from ozlabs.org ([203.11.71.1]:40111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932479AbeE2DKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:10:40 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 13:10:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20180529131036.09e95ef2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qzAxrcJtsb24Z8bXAfIoZo0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qzAxrcJtsb24Z8bXAfIoZo0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

net/core/filter.c: In function 'sk_msg_convert_ctx_access':
net/core/filter.c:6450:6: warning: unused variable 'off' [-Wunused-variable]
  int off;
      ^~~

Introduced by commit

  303def35f64e ("bpf: allow sk_msg programs to read sock fields")

--=20
Cheers,
Stephen Rothwell

--Sig_/qzAxrcJtsb24Z8bXAfIoZo0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsMxKwACgkQAVBC80lX
0GyHxAf+JpYuH0Lc1dCMuDEwC8b/l/VJL19zR5D9P+50NmUF48IuoDwSoZPDYPqr
zYQ1VWkw5Sl55yPCqQbcKwP2/yVudODaEFSX7Yg0YSLN5WjQOfKUxIWaoZfQw2Q1
Hs2nfgkUf1uOSKud9pN7eVWCcV4wt+cZpBiTuxiJ5uHqqoR/7qOiC3+afyI2qaV1
T4Yl0ZNAmfGxp0aoq3WK+9mA64jXW3F68ESKixFwunYu8jQ/plEOegcyiZtPizCv
Ui5ZfzFw4FJwqksO1YtAXCVrTbWUS1lKU7QmXhg7Z6qcWP+SGPOjAq6DwXkFAWWO
89eQHk7zEZu2z30F4bUETImZDVpXXA==
=Nl9J
-----END PGP SIGNATURE-----

--Sig_/qzAxrcJtsb24Z8bXAfIoZo0--
