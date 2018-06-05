Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeFEVzk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:55:40 -0400
Received: from ozlabs.org ([203.11.71.1]:32849 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbeFEVzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:55:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 07:55:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the y2038 tree
Message-ID: <20180606075535.09b41c23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j=PtaNusB7jYa.fl=Ei3Jgj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j=PtaNusB7jYa.fl=Ei3Jgj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Commit

  0f0d83b99ef7 ("pstore: Convert internal records to timespec64")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/j=PtaNusB7jYa.fl=Ei3Jgj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXBtcACgkQAVBC80lX
0Gyp3Af+JCLDvWOF909q0UmKlQe1sbZFOoT/6x6JI6RKZ82g1omGh5KgBhh/7biQ
HutXUEQ91R1y275AtGJ60vPp8Wg+hi2pToqDqyU2PB6RQYcqTiigPY5oJhvEMzKM
A27EJSUCHlsoVz8JdH/Prn/cwVDXL/Plc8I1mYm3NRnvXnwuuKh57pbFG3BDoQFP
u/pPG47RKXivXod7gHfYA169Q7NJchECdf4td6hr6fVIMdwKWcpfI6JQrThVYlzQ
ceAJgW7Tc5KfG0Ok/bpaIL2h2lMnRmJbGHOecx1r0GmQsB8OEhSSFZaQO/qhIpj+
nDPWNIKKfVgaO3gqDH0hxzJeQlMjfA==
=iqOB
-----END PGP SIGNATURE-----

--Sig_/j=PtaNusB7jYa.fl=Ei3Jgj--
