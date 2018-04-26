Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeDZAub (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 20:50:31 -0400
Received: from ozlabs.org ([203.11.71.1]:40687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751785AbeDZAua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 20:50:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 26 Apr 2018 10:49:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20180426104902.548c3fdb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SZJBMm3xf5aUcubd9unALkk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SZJBMm3xf5aUcubd9unALkk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/.gitignore

between commit:

  0abf854d7cbb ("selftests: bpf: update .gitignore with missing generated f=
iles")

from the net-next tree and commit:

  b6fd9cf796e6 ("selftests: bpf: update .gitignore with missing file")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/bpf/.gitignore
index 5e1ab2f0eb79,da19f0562bf8..000000000000
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@@ -12,6 -12,4 +12,7 @@@ test_tcpbpf_use
  test_verifier_log
  feature
  test_libbpf_open
+ test_btf
 +test_sock
 +test_sock_addr
 +urandom_read

--Sig_/SZJBMm3xf5aUcubd9unALkk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrhIf4ACgkQAVBC80lX
0GzizQf8D+RtAykYa/2oIEiLQQCuO94if/PLvdJBhN5bISiS96IexctZNGwtoRQe
Ib3jW4wRY9Jsta87L8/VIhj/489qh2EYJgutCRlmP4blbkIV2cuoPw6b4jFAENes
UqDZ9GNDmoDdlWjoi26INSJNddV21qtBpu+DGdtbmMfS5jL6xPnoJyxPIqxGwdoz
ce9YOpiXAjc2f2PXXuT6MlM4SUgTVtBYstgTZ0/lH4QksJsF8MqL66e5kuzSlR8x
mimsBbkchWxUMQfJmjMc83U4J0pbW3ypKeDBah1I9PGVe57O8MF+Ip90bL6+UWla
5Y5ou9MU+R9Sb53gR9Tg/IOI3Cm5Ng==
=qhdg
-----END PGP SIGNATURE-----

--Sig_/SZJBMm3xf5aUcubd9unALkk--
