Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeEMWCx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:02:53 -0400
Received: from ozlabs.org ([203.11.71.1]:50771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbeEMWCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:02:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 08:02:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20180514080248.307e6ee9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8LPdaPxppS/qlwsp4_/+knR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8LPdaPxppS/qlwsp4_/+knR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9cd00a8aa42e ("net: phy: phylink: Poll link GPIOs")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/8LPdaPxppS/qlwsp4_/+knR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr4tggACgkQAVBC80lX
0Gw/twgAnWFn8CXmP4jX2SsjY0vYIJSrGiyqAiN8PBlVLBeki/w6bybOyDg7aUO+
4Qi5u/NkYo5LLPmk/cOAGV8lRN0qv/P0oBHyQQD2mVsAa68wkRLh1qj2tga4+ldU
TIbJhgwsyphFAked19FHZaCg3PsnOBeKOt+XMunhr+8Y+HyDbKjSqZ0kpSoOeKbL
6+YaID16gc4dQeJ+Z5efRfN+5EFs1Kz00X1kMJ9WiqBTXcEWeLsaq5Q8g6D8dVSP
E0ktbJK9xrDQTltKEt764zTVE505OlGhtghPzfSZZcGWwJuC7F/J3lK1AXtXNCmq
PjojKBedOvnn0FQok0GKh8tNanXxIA==
=BZoM
-----END PGP SIGNATURE-----

--Sig_/8LPdaPxppS/qlwsp4_/+knR--
