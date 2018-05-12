Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeELEQ0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 00:16:26 -0400
Received: from ozlabs.org ([203.11.71.1]:57495 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELEQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 00:16:25 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 12 May 2018 14:16:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: added the vfs-fixes tree
Message-ID: <20180512141622.11739c20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b3qlIRDS3.zT2NxawlK7D30"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b3qlIRDS3.zT2NxawlK7D30
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

As requested I have added the vfs-fixes tree
(git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git#fixes) to
linux-next from Monday.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/b3qlIRDS3.zT2NxawlK7D30
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr2apcACgkQAVBC80lX
0GzoHwf9E8gLUa4600j2L0uSZsxg5qwhHcBtGK6A7P/GT1IWrAAi1aCr+Ssohr+L
6ozMTrZ6Otp2v3c5CVhdDS4kAlc3OAEaWWwFHlPPCiTObcQ5UikSM2DoaUMT4X8W
L5WF4ocwinwoqW/fi/Yd+UAMbYPxjm2i7/7mFEWgFScKA40reB9XTMcPXOGwRnq1
M+JLPPCC9OQFPX5Hl9pltHjs1CvIZr73kdLxCO9Jsfo7AIg/Zba/q07RU5b8AF+2
rg15tvXHs5EO0IbmgdhXR8xZXdw+NdhPXiSLRTeInJoacow2mK19ASjy8LvZ6dbE
j4x3Uu77z+VVKyXrkTkhI3u79pdZWw==
=+m1h
-----END PGP SIGNATURE-----

--Sig_/b3qlIRDS3.zT2NxawlK7D30--
