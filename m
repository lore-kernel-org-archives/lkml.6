Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeCRNpG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 09:45:06 -0400
Received: from ozlabs.org ([103.22.144.67]:49047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754054AbeCRNpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 09:45:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 00:44:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the kvm tree
Message-ID: <20180319004421.44b18d1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/doOM47Y7bOWvP_3kqrHL.9+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/doOM47Y7bOWvP_3kqrHL.9+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There is a series if commits

  e84b7119e891 ("x86/msr: Add AMD Core Perf Extension MSRs")
to
  e1de91ccab31 ("KVM: VMX: WARN on a MOV CR3 exit w/ unrestricted guest")

that are missing a Signed-off-by from their committer.  It looks like
they have been rebased?

--=20
Cheers,
Stephen Rothwell

--Sig_/doOM47Y7bOWvP_3kqrHL.9+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqubTUACgkQAVBC80lX
0GwfPwf/ZJ7WDY7gv6uE+mBG0GBcbTikuEb/BFBOIBMtLdy8MJv+UPJauFmDDvu0
u9s+0T/U6LCq91M9xThBpjIiemQdkOSMJOZh2CslG/YCdyceihKP0yy+3NMdAKj3
SeqXHfXIYm+HsXTNzIAkJIyQmIkjEBuZgCuUzrNB4aJdOZdray2EQRmTKn2jOAFG
uTVRD60iJo0xuDcRT7OQMhrWZOG1eEZnNnBSjSyOiKayWhJ3DUDn9HFMSmssrfdZ
TPVp7tynVMU2v/3zHXPQ1M/kL5mvW49AwZwREgcLw/OL+63rjJ7ukOIdfEl1SxHT
+xxG1JEB14Xire8FJle4WXuk73N0eA==
=kcaQ
-----END PGP SIGNATURE-----

--Sig_/doOM47Y7bOWvP_3kqrHL.9+--
