Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeEPVhT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:37:19 -0400
Received: from ozlabs.org ([203.11.71.1]:54017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEPVhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:37:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 07:37:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Chen <jasonx.z.chen@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Alan Chiang <alanx.chiang@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>, Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the v4l-dvb tree
Message-ID: <20180517073702.5497e72e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DMzexEs34ryTjaDGznQFWtf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DMzexEs34ryTjaDGznQFWtf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  af76c93aa36d ("media: cadence: csi2rx: Fix csi2rx_start error handling")

is missing a Signed-off-by from its committer.

Commits

  c578c7710712 ("media: imx258: Add imx258 camera sensor driver")
  3a8fdc1426c3 ("media: dw9807: Add dw9807 vcm driver")
  2f9c1c88369f ("media: dt-bindings: Add bindings for Dongwoon DW9807 voice=
 coil")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/DMzexEs34ryTjaDGznQFWtf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr8pH4ACgkQAVBC80lX
0GzylQf9FBl5xIo19SpzlHUiUDH7DWTX4EGTdrLOjV8BXZEogY1YAe+P1+NEQ0BC
g1Hn2+d7ub0fkRcjTKS2bcmpuFNQdf3oETg4G87AfMZ8PCwX0qku5iBWpkqXrk+V
vNE3Pvvl+njU/+oHBKKX7vF9Oa8iknniBqFv0QsQdDHQPoWVKIE8Bo6dpLreOViG
ciDciQHlLgmBZngruv8UuNO+Upcc8HVgwPUAqxbUfUBphXzmDGYFij49WSXkVhM/
GbmQwrEf0JiSqfvYHNZTc5U/hl78wASBM9y7iq9/GUupVYN4LVJ40FVBNBwh3wzu
C/M3tnbmLLQWH4o/en+YDWr2PaEpcw==
=TY+K
-----END PGP SIGNATURE-----

--Sig_/DMzexEs34ryTjaDGznQFWtf--
