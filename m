Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFD320874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfADKnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:43:11 -0500
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:44188 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfADKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:43:11 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43WLwX5Xlsz7Pp;
        Fri,  4 Jan 2019 11:43:08 +0100 (CET)
Date:   Fri, 4 Jan 2019 11:43:05 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] doc: networking: add offload documents into main index
 file
Message-ID: <85c238998fd0804cd5be9746ffe711abc2306b98.1546553515.git.ottosabart@seberm.com>
References: <cover.1546553515.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <cover.1546553515.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
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


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwvOLoACgkQgjuumfi+
HjwnEA/4i+aVvXdDe/JkwsjKlUk6TwBfYWsarpVTb2bYb5IloRsbxx49hrj4C7B+
CEGWO8FbDdwO+4Giehmr859+NPZGCXCe9MrKz+Z7mJEYJQ1ox8A3isV1qynOgSm8
2y0OlFOYoATesKkwKe3iIyIA8d/uuxW1Or8n1+V7oE7hqq3Cn/lIOnsRXx4r2SVT
VDn8dK2NpCGgrN1Jfv37nXMlNMwSQ2rHlPIqx7KsIMFg+F/1CmAw/tcypNS6Xo3T
/55LD4Qh5hI1oWKVDYdLKN6Pov0fRcC+bcetmm+RNjGctx3nN/gQK7WwCe9kjRah
lLj1NAGEVa9D7wUcskfzUk47HhxCzSbwgm9pSi4HOZvvRa6YQG1fBBRLSHfH66eB
D8HQeD/HYyDYDPNT1eBACwcDy55INNBWU4ZOpgfa+Df1mJk1Fv2oAChN9JqG/B+t
WEN1lthitARY+WZjMF8zc29nglJncKd9zRLxNp3Y4QGy3rPgb20oTDaibWuYikZZ
9o0CsF2CjxPg2me2hg5t3YGTKv9CnBPFU0xw4aB42CUGZlizALbVGB3Bafz4DByo
k37Mw7GYf+mtqrAb6mB5QaESyCYoNffwhJpEDWJZO8VPnzGHPUIYqH6qT3iDEhR8
XEty8VNXF4p7dirxeyyq/cafKPYPNbkpQwJ0jjH9SkAaZx+Spg==
=L7TS
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
