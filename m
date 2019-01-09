Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE99C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8971821738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfAIT55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:57:57 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:54104 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728395AbfAIT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:57:57 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43Zg0M4kyPzSp;
        Wed,  9 Jan 2019 20:57:55 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:57:50 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/3] doc: networking: add scaling doc into index file
Message-ID: <f34b41f5660f9c1d15ce44011929ea28d7f0cbe9.1547063330.git.ottosabart@seberm.com>
References: <cover.1547063330.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <cover.1547063330.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add reference to scaling document into main table of contents in network
documentation.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/networking/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/=
index.rst
index 6a47629ef8ed..47552ea410fe 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -32,6 +32,7 @@ Contents:
    alias
    bridge
    snmp_counter
+   scaling
=20
 .. only::  subproject
=20
--=20
2.17.2


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2Uj4ACgkQgjuumfi+
Hjx7cw/+LIeBVZstolB+lanf3FEmibkupG8LWFIT18eskF1hSXefOxE51aXl62gL
PGgMtNjCIGe+eZqLRDn9M08rgJSa2X2Qn23XdEW/s3HVUAKkhWCi3RFrPUf9oM4J
cjyhw9sGeewi6qWSTJRC/Rj/Zi4rMJEGI4Ql7VSHLscfsBs/98d5PYTgQkYlCmHI
6PEb9/+tcBFsrqjbQ1QIH1nxctS+4y4xIAQhz3nZEQxpuzaxZ+Eks6RM8unbeldH
YB6/9C6SY2BB9xm42pr4OTN+3p9+AUg35vZXpdDU9xYTxQZDCP0P3yjZlzfpAOHa
Hfre+JPFws5NlFzMDCrfuSLzgGTjuNxreFEl5yoj+5RU3m5rOf1dNTrFesO2iv5k
gl09Zs4PNuhDNPDEhAPwfJZmDba4uBR3NS1wJ7BM8UV0/fIGUtrkgvpYFkA3a21s
OjkSAaZ6RBTU6ytaKaaGv6ISfql5+xxPYVGjKpL9OpPc4nKo/CEwANfHMUs8hK/y
K14beKy01H9oZ4GmMY914dKik5VFQeRGLTyp8cW6Cn42Y4ONCxDsVX16yynUIaRI
hl1ruuprGDuViwQ1K9HGrtXXLD81sUZbDD335yzVtdOfKOHut5VK6ZUI1QNUm1GX
7MIe87fWtg24jViQdMXGty7eilO828Uz/Ad43HBai6LWY869Yyo=
=VsWs
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
