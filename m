Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeCCEoc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 23:44:32 -0500
Received: from ozlabs.org ([103.22.144.67]:37359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbeCCEoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 23:44:30 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 3 Mar 2018 15:44:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20180303154414.695b814c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8qoDeWtpQKDewipKAfuTRlM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8qoDeWtpQKDewipKAfuTRlM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Commit

  a1a9f434c900 ("PCI: Rename pci_flr_wait() to pci_dev_wait() and make it g=
eneric")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/8qoDeWtpQKDewipKAfuTRlM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqaKB4ACgkQAVBC80lX
0Gw6agf/cQF5+7q8mMEhhH0Jzri5/uMWQYleYz24ueDOwKd+Cj3fa4wMJfv/wQSS
GD+OC1NQMxWlT3i1WhmShdjMZF5qTpsCKNe9F37IwtKOMDPQoS+Rjnh2UvZjaCOA
/uP9/UMQHngvcDZBIFsW2Vrt/AaBR+Bfyf6Vnt0ovqpBW1TukMKZDk9HNIphg38K
6Y8eBYADFUQXrqHo4Lm59L5mkOKRLJzYXSVWF3b5wwRaE5RaVaS/Ql7dbN1347bQ
dOhcf+5KRmUZsaT321NaHThKrSmaFs+9ICfVZHDiX83F9a0ITRdyf1JS+Fr41kTZ
XBGCh35xqCzOLrPl9Rs968lm8mlPvw==
=QJon
-----END PGP SIGNATURE-----

--Sig_/8qoDeWtpQKDewipKAfuTRlM--
