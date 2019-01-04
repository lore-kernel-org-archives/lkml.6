Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D37C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB2A20874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfADKmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:42:36 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:32793 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfADKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:42:35 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43WLvs4Bnhz3GQ;
        Fri,  4 Jan 2019 11:42:33 +0100 (CET)
Date:   Fri, 4 Jan 2019 11:42:29 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] doc: networking: update references to files describing
 offloads
Message-ID: <cce5f338791563e31c0b4702cedce35d66959fbc.1546553515.git.ottosabart@seberm.com>
References: <cover.1546553515.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <cover.1546553515.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Update reference to checksum-offloads.rst file which was converted into
RST.

Whole kernel code was grepped for references using:
$ grep -r "\(segmentation\|checksum\)-offloads.txt" .

There should be no other references
to {segmentation,checksum}-offloads.txt files.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 93f56fddd92a..4e671b46e767 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4296,7 +4296,7 @@ static inline bool skb_head_is_locked(const struct sk=
_buff *skb)
 /* Local Checksum Offload.
  * Compute outer checksum based on the assumption that the
  * inner checksum will be offloaded later.
- * See Documentation/networking/checksum-offloads.txt for
+ * See Documentation/networking/checksum-offloads.rst for
  * explanation of how this works.
  * Fill in outer checksum adjustment (e.g. with sum of outer
  * pseudo-header) before calling.
--=20
2.17.2


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwvOJUACgkQgjuumfi+
Hjw8uhAApLaGalpsvYj6+NtUuzl+f6f5eStJr1gNWhvgx3rbQOuMrBH9Qt637ySw
et/DS30IfIyTXMq+BF+0az0oaFqaAT/Jr1jLWWYOjxXjlQQVagV5sHgCDUaDIJ8/
1gxVLlFMq5dujielF2cVEby8ZZk0xTKBQyHj55z0cAgIJoNJElPEujWA63PO95Vl
K+OJZg8UQmvVcma+ehtcRwt1Rjumjoj8KRDigk2HIifsND7P7gQdjv+NLrl/nIWS
lspl1zJUnGBB9n1DVEOmBqTCjvM9TVo6q1fPCLb11Err+RpF534MrCmCM88CgpsI
xXOZcumtq0vdCZL6v/fi9eKeSRD9GJYy3TZ5RuLxIAG66vDsc5mwl8rhkw1H4YyJ
TjNz+qKTe4dbx8xzCOObapPBnRjgYB3+oDRX00XwLzh4+Dp75ZFP5RU2aYn8Eczr
hY5HV0NheXgxEjbIBxx2EX9Odl2OQChuDUaLxLhsToqWweW25dG99uUZwn/uxXa0
3ZtrHvfC+qbVxd1XInNbbVfhGE6PkF7WGCAfbMGU7nJaN1pKfDB5+5uXyp2lIE+x
AO+18NOLSQd8vjWa128oNbhPV2VorcdE8AZcIzczOImxft9Jr2Vf1bwKoh96xx0n
f7yoPNP7D24FeG180x+8yDzsCVEWzb2MTIEBHqNH6xT90vi5hoc=
=1MIL
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
