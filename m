Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932356AbeCMWZO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:25:14 -0400
Received: from ozlabs.org ([103.22.144.67]:44037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeCMWZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:25:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 09:24:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: James Hogan <james.hogan@imgtec.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the metag tree with the syscalls tree
Message-ID: <20180314092435.1dbbf06f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wrgOkv9iIxJaUeajJ08nJzp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wrgOkv9iIxJaUeajJ08nJzp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

Today's linux-next merge of the metag tree got a conflict in:

  arch/metag/kernel/sys_metag.c

between commits:

  fabbf34a610d ("mm: add ksys_fadvise64_64() helper; remove in-kernel call =
to sys_fadvise64_64()")
  a302a8524798 ("mm: add ksys_mmap_pgoff() helper; remove in-kernel calls t=
o sys_mmap_pgoff()")
  9608ec858cdd ("fs: add ksys_sync_file_range helper(); remove in-kernel ca=
lls to syscall")

from the syscalls tree and commit:

  bb6fb6dfcc17 ("metag: Remove arch/metag/")

from the metag tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wrgOkv9iIxJaUeajJ08nJzp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqoT6MACgkQAVBC80lX
0GwT7Af6AqHMbfPOVvCtAQnWwYjFt61bkAAuggMcFRSLFPPiB/njK1UVdC0bbIZs
4moIKcYguBNNSRdwqkuIsp/HDPo83gDbX/55F5hCHrIZmTXrzb0YIAh7yo4ErFaV
IHzTMwiRPDpkxd5hk20BznLMdEIYpZtaF3Wi1lQvXTPgZyJzvYoAzgfKvr1hPHKf
2NRRGu7gaYTIOklj8WqNOn7wy/VoZiMMClAOz/gyYv6bgmjrMm6UyrS/NSt3tbzS
wVjnxQzHGAoGewgUatP5ILKVKIGrS0V484+rlqWDhZmpvbpCXDSuWUV+H9dAf0ds
esw6sTSn7JlL7UprNhmM/XHaOBo6Tg==
=s6cY
-----END PGP SIGNATURE-----

--Sig_/wrgOkv9iIxJaUeajJ08nJzp--
