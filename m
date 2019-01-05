Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23688C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED5C222BB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfAEX3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:29:47 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:37959 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726363AbfAEX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:29:46 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43XHtc2C1fzhq;
        Sun,  6 Jan 2019 00:29:44 +0100 (CET)
Date:   Sun, 6 Jan 2019 00:29:41 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] doc: networking: add offload documents into main
 index file
Message-ID: <e1312669d610dc3c9ab5e2a22669fd163aeb308f.1546730285.git.ottosabart@seberm.com>
References: <cover.1546730285.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <cover.1546730285.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch just adds references to offload documents into main table of
contents in network documentation.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/networking/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/=
index.rst
index 6a47629ef8ed..7034214cf87e 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -32,6 +32,8 @@ Contents:
    alias
    bridge
    snmp_counter
+   checksum-offloads
+   segmentation-offloads
=20
 .. only::  subproject
=20
--=20
2.17.2


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwxPeUACgkQgjuumfi+
HjwjBw//QpdWc9i23dhav0ToLRCIVxa4xGNIIYul8NXVcq2qaKlaVdKL7Nk2/SxX
WdRgptgZfemCaP87ndN6IzEkaZU7Tndaz2OvkrN8mv/VKESA4n9QzISlmyyYSEzD
oqDBH0Ch6eLPJlhGedHNgnA5zgKoJ9/wIAq0Q7uoqi7U5AmlMWgtQU87QGkt8D7n
/cufcEXZKMelA1vUnsKV0EOFh2mQl/i6wgJmakVMvYz3d+mZoYqpfsA3BK6mUQIY
oYnWcEUZH2zaYf7vcLe/zG/Yh8jk+dFA+rfb22/tcNUj5dEdXIdfSAMlATJSAxjc
yUu0DLLtAf2dTADOS+O2KVuQDo62fvEa1WuWQKPCT3PWRG0SQgdqToVqwwKL8HRz
+c3VpJAPwYPWhp+wBrToTRcH0dWW98tq7egcqnkRpGOCwfidx4LNAdqwYF+QhiEc
ccqC0Nnn5wSCiuM3upiId//cEM+dLiw1SheeOAZ4TtzVOFNEwwgTeaJ+16syodqO
oeCodWBqqTSpna/nBzMSUtsRm9sd98Q4vDXtZ8jlAvDekO66SktDixi/IQyqrecy
nFPYruRAdq3gP7YQqg6WS3a7I1YIph8tSyr2w6Kt0xlN8iLoAHDhPd27RkWxk9hp
xMJIA2u1pCwWwO5rN//YyA5EDvZcthcwWdpkaRbKnRL9bCa0mc0=
=9JFI
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
