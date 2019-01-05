Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F47C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41C4222BB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfAEX3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:29:22 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:55596 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfAEX3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:29:21 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43XHt62W0nzhq;
        Sun,  6 Jan 2019 00:29:18 +0100 (CET)
Date:   Sun, 6 Jan 2019 00:29:15 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] doc: networking: convert offload files into RST and
 update references
Message-ID: <96cf13b1cbe5a4abb8aaf590cb9badb1dc010b0a.1546730285.git.ottosabart@seberm.com>
References: <cover.1546730285.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <cover.1546730285.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch renames offload files. This is necessary for Sphinx.

Also update reference to checksum-offloads.rst file.

Whole kernel code was grepped for references using:
$ grep -r "\(segmentation\|checksum\)-offloads.txt" .

There should be no other references
to {segmentation,checksum}-offloads.txt files.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 .../networking/{checksum-offloads.txt =3D> checksum-offloads.rst} | 0
 .../{segmentation-offloads.txt =3D> segmentation-offloads.rst}    | 0
 include/linux/skbuff.h                                          | 2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)
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


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwxPcsACgkQgjuumfi+
Hjx5YQ/7Bc72296WeUnfMkz3AErwGan4/qazvBIhKCDOY2K2QcFKVkoQGEYB/K5S
SjR627M/xkQjDSKvSf9I8U/tUf6QpsaRjPomkef4LcG2wdXZCB93YZgVnHzADOzr
onvnUX5P7y0EsugReUiJK2CxW6huHDE9iKQPJZ8qehcxor9hoSZeEvcU4S/EGbaX
hdnVbkawi3hO9AUTXsU/6zloqmmNL6hXIy+1tZyNVeHKnc5qfpJSMmwodGJP0og4
Zjx3pM9VA4/A7Eofjl/9ihuNdRYX0wv98Z5QfKNQfOnyfnZGUCnMqtuz/nfwpcn/
NbLCJRh0vcD0xxclyj9BcSE4VaDOOin1OwN+jkFSCvq1WbaTEiQaqhztmmbHIJLB
ZNMVaofgGp6CmIAbpntXL0UZKvBa5eRl1IeB4pkExSg1+YhJTXOn87GcxTj97DHm
yBz5raQE+vaS+wtI+eIPO7yHHPmI8kAmFUidykButQb288ljeycgtZv/YTmkMuGm
NQ2Ig8OQGykBuHL3Dr11bzlWFmSx5E3IX0g5rgrgADCrWuBIxQ52kCtk7M1mzx/5
mS9Xn+IRRhsMtBnfRs3lM0YlmWAeQQ59nH4cMMvTh3/cCBRn+Zg4kLcGGd3NuIhr
TkR7gcwNz0Rw7b64BTJy6JI/auxEt6MOrjTi031FC3gCz0t6DI8=
=GR7i
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
