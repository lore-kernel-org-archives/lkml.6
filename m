Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeEHA0m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:26:42 -0400
Received: from ozlabs.org ([203.11.71.1]:55965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753416AbeEHA0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:26:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 8 May 2018 10:26:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the s390 tree
Message-ID: <20180508102638.1e19b7f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kXzFUC_=Cczq4v52YPlNUFN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kXzFUC_=Cczq4v52YPlNUFN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  arch/s390/net/bpf_jit.S

between commit:

  de5cb6eb514e ("s390: use expoline thunks in the BPF JIT")

from the s390 tree and commit:

  e1cf4befa297 ("bpf, s390x: remove ld_abs/ld_ind")

from the bpf-next tree.

I fixed it up (I just removed the file as the latter does) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/kXzFUC_=Cczq4v52YPlNUFN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrw7r4ACgkQAVBC80lX
0Gy4PAf8DgK2t+x5p9ltMzupAQvkJvFQ0YnwQ+AVZx2PUsoWQdPe/ucpwl8s3DJa
zxtDzbPFY6gauE4tLVMOZJPO6wMMtK2cE17h/VRMIvPZVO8TWhehIOPeFmzffBtB
qbKIP2aywKUwvOEzL4n+rNCvY9D1cNZzdljaJBeDU4iVZwHTmnx65+ldZK6jSmc7
ox/Ns986SwztFk8kGM65ywYz8u4NP3g5JlXQCKE1cOeW8eF27Ni7C/gknsoqXKHH
ai01w3xM6rD4S+K4D3FFW3BVw960VkE4gxjXimenI1qQnt4+w4sKQVmT8KDu/nXg
af44oXT7nWpfGg52X8eor9jEZJf1vA==
=VLxK
-----END PGP SIGNATURE-----

--Sig_/kXzFUC_=Cczq4v52YPlNUFN--
