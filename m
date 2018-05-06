Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEFW2B (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 18:28:01 -0400
Received: from ozlabs.org ([203.11.71.1]:49315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeEFW16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 18:27:58 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 7 May 2018 08:27:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the netfilter-next
 tree
Message-ID: <20180507082748.5824d830@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FvsIWsxrX=5O.Vuu6LOU+eX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FvsIWsxrX=5O.Vuu6LOU+eX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  75e72f05418a ("netfilter: nft_numgen: enable hashing of one element")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/FvsIWsxrX=5O.Vuu6LOU+eX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrvgWQACgkQAVBC80lX
0GzTYQf9ETlPJmUU5zqQfSagVxbSlRYxKQSEzhxZFx4JUWS55HQMah9/8tkE08r5
zerjM7CYR8LnpnvTVcXmsa/MYZLcuIg7l/ApcSJ0R5tJcRnTLNSdVoQbH2mw5lj4
wEATzMexsKlRzp3oVqCHXoulrLfmIR9KCbbWUaxNJ25j15chiaW5HhfR9fbEw06m
zeDR1rLj0vn8BnZIGfbQr92UO2fG3Qy1ONic+a0Y/wdQO9uG825rM68M2ipmBJoX
0aEXe4cTsPljNNmX/li2BP1dwaZfgT58P2kqosEZFYxfWkWHCD7B1hgZbp2t8U3c
kzieqWWjitfXF4qSq2Vic6K/CbmIdw==
=0fOX
-----END PGP SIGNATURE-----

--Sig_/FvsIWsxrX=5O.Vuu6LOU+eX--
