Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeEJVkx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:40:53 -0400
Received: from ozlabs.org ([203.11.71.1]:33823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752104AbeEJVkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:40:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 11 May 2018 07:40:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the jc_docs tree
Message-ID: <20180511074049.26072ec8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BA03Ek0kRyOd/q5Mz/CcKq1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BA03Ek0kRyOd/q5Mz/CcKq1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Commit

  5a779c40a8ad ("Revert "Documentation/features/vm: Remove arch support sta=
tus file for 'pte_special'"")

is missing a Signed-off-by from its author and committer.  Reverts are
commits too. ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/BA03Ek0kRyOd/q5Mz/CcKq1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr0vGEACgkQAVBC80lX
0GwEDggAi1vAYk7B6yPUh8XbPuHLdCjwgOOms2Gyd5QcPW8gzut67xr7uKNcqBKr
1JNtAy91vzkdKSTPfa/UCX5u4MsUCXbmgIjK2KM9fQ1ISy3aZ9LHpATnhSdAxJFU
45TeeMucGm8UjZUqPcetd0LDzxQSKzzwtK6meaBDr5JzJADBNFMa+v3u5nI+Bbzg
fZ+XOuo2ezPxdr488RNpLvuz/AczuDiWGNjdSDLDmKS/MLxlc1Ol0FwiZHsfZf0M
Y/GUjq8x6LMx5uItsBxlHWf1Q5GPLEQp2zFNUfHOjMifisvVWikR0yVUyDDfrmvm
drtxG7IOHv/3GEOWjt+oFBAxwPSW1w==
=aZ6W
-----END PGP SIGNATURE-----

--Sig_/BA03Ek0kRyOd/q5Mz/CcKq1--
