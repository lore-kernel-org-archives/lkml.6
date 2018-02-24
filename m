Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeBXCKg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 21:10:36 -0500
Received: from ozlabs.org ([103.22.144.67]:51599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbeBXCKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 21:10:34 -0500
Date: Sat, 24 Feb 2018 13:10:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the kvm-fixes tree
Message-ID: <20180224131018.4f1fd758@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/toCtzXesCqjndJv6swp2I95"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/toCtzXesCqjndJv6swp2I95
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  99158246208b ("KVM: nVMX: preserve SECONDARY_EXEC_DESC without UMIP")
  103c763c72dd ("KVM/x86: remove WARN_ON() for when vm_munmap() fails")
  b28676bb8ae4 ("KVM: mmu: Fix overlap between public and private memslots")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/toCtzXesCqjndJv6swp2I95
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqQyYoACgkQAVBC80lX
0GzgBQf8CGIPbrJdtx1S/OB+NawqUrrtKO1vkYSCyUaEodUwN5RIjAl/i5Lybdll
A/xgSIoMQC9rca1zampbfs/8WP+ztis5kAxpTasdlHWiThUUW3NplSmwV8oWblII
FXtHcfBkp5oMP57hZJ25EfV52PFUCo7vQrbWwtbpE4eoUJP+j+ty8lJ8ASCcqfzq
uKrw5G3OshvokdPIwVHd8VVu90QLi9xCDQ5sSUf6X7UviLEnybiAh5cksPZ5dbQK
Ex9wnlf4Ghp/qUGD4U8EwR7ktRv4N1gzIGpZwBZriBwcVPbENtkY1XAJC8fcxQPv
XuHVQy5HeXV6uZi1d4JmbHK1sm1NNg==
=CfQX
-----END PGP SIGNATURE-----

--Sig_/toCtzXesCqjndJv6swp2I95--
