Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3169C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F3220449
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfADKmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:42:22 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:40522 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfADKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:42:22 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43WLvc4SVKz6pH;
        Fri,  4 Jan 2019 11:42:20 +0100 (CET)
Date:   Fri, 4 Jan 2019 11:42:17 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] doc: networking: convert offload files into RST
Message-ID: <96206de881ddec8e5618aa7d906038fc9753e5a5.1546553515.git.ottosabart@seberm.com>
References: <cover.1546553515.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <cover.1546553515.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch renames offload files. This is necessary for Sphinx.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 .../networking/{checksum-offloads.txt =3D> checksum-offloads.rst}   | 0
 .../{segmentation-offloads.txt =3D> segmentation-offloads.rst}      | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/networking/{checksum-offloads.txt =3D> checksum-offlo=
ads.rst} (100%)
 rename Documentation/networking/{segmentation-offloads.txt =3D> segmentati=
on-offloads.rst} (100%)

diff --git a/Documentation/networking/checksum-offloads.txt b/Documentation=
/networking/checksum-offloads.rst
similarity index 100%
rename from Documentation/networking/checksum-offloads.txt
rename to Documentation/networking/checksum-offloads.rst
diff --git a/Documentation/networking/segmentation-offloads.txt b/Documenta=
tion/networking/segmentation-offloads.rst
similarity index 100%
rename from Documentation/networking/segmentation-offloads.txt
rename to Documentation/networking/segmentation-offloads.rst
--=20
2.17.2


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwvOIkACgkQgjuumfi+
HjwpEw/+LiabKkYimWMaHmtfNoueSUjdszYiYHbCwkBSA78neIRIMNEFsAPMd81p
/WYREDAZTe8d4PTCSY5xXYIuPEBXYpyYNDIs1dcDWUNzAT6IP0aREtsS+rJ/jqR4
vR9oRNUEiJqgMDGpg5SXkvgd2itU/1vBXivMyNtV5/nfiyLRt9Tevk9oyu8U+Twc
N9748PlgONQOlOc7a0dOgjABBXbkmNUlGM91fV9MmxFtEjmTHjJjHQ/jyb3QNtX8
Gp1UCDPHjjGDq80RnT7BK0DsbZOVyjEo6+DzF0QjC9kjlI3Nx+jyJn352CMawU+Z
iI/ZdD6n6Nv5QfnT4/DAZYpxhNxDXhD1Z9tKJusLkF/R7Dlx46JAbbr3/SoaAROE
ht65mqn0ddvWyPiv0MH6uIs2Nmv/VwuFmrb7LG6YZopebkR74pSSbVJex6AOxwmW
/ahaCEnT/s6m7gOnSK6tOxGvn6m4T67IZtZ0PKNhECRF6/7iohCgMhpTG2ak1sMn
+U9/1/IN2DCazbTCl/nOSFprek/iSxQHe0dZQXsVnMdOlvHaQZ6/WPIQHQE0xVJI
xxPURI9urdZ9ISWOwntF/4JBa5kXrgOqaHQG1C1HaF2P/UoQ1e8HteH8BAKX3BKP
BtCXX/tCgnhtNNTr+5oP1zldhptaMjPU0IqUC1Sc/EQV2NHXSaI=
=SaAC
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
