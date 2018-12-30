Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED442084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeL3TCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:02:01 -0500
Received: from wes1-so2.wedos.net ([46.28.106.16]:43216 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeL3TCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:02:00 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43SVDQ4kSSztq;
        Sun, 30 Dec 2018 20:01:58 +0100 (CET)
Date:   Sun, 30 Dec 2018 20:01:55 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: cgroup: add missing literal block
Message-ID: <20181230190155.GA15155@personal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes multiple build warnings:
"WARNING: Block quote ends without a blank line; unexpected unindent."

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 7bf3f129c68b..2687a454effc 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1505,12 +1505,13 @@ The limits are only applied at the peer level in th=
e hierarchy.  This means that
 in the diagram below, only groups A, B, and C will influence each other, a=
nd
 groups D and F will influence each other.  Group G will influence nobody.
=20
-			[root]
-		/	   |		\
-		A	   B		C
-	       /  \        |
-	      D    F	   G
+::
=20
+           [root]
+       /     |     \
+      A      B      C
+     /  \    |
+    D    F   G
=20
 So the ideal way to configure this is to set io.latency in groups A, B, an=
d C.
 Generally you do not want to set a value lower than the latency your device
--=20
2.17.2

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwpFiIACgkQgjuumfi+
HjyF3w/+LsrAXcH79ZEiJRVNiAhln6IjB6Sc7lJ49zEh3rb+0gXoBXiUb1rIaDOt
CcAGhyoDXyBruKrW3xQLaxDECqfxBRB3rtvsfMBF16SNOJzDDU+1jYrCpmRg7F5g
vcmNGjQb7znDM3UQvVX81MSZjGoi0bYMYiLJgJ66YbgbvDTRo8/cpDfSDhD62cVE
TH6rCYxYExXI0BfE41jL5ndLHvm1kPi70W2UzsgscWgup94rji5vIcd7K2CMPCop
dMdppidFa4VfSty18DcIqr+oN014owBgzUfYDaDawii4POQocyWFU/Zw81DT0T2K
p9if0srzxIV7ATwQbODvESbVuyGkPjyXHhf/Yni3AXB+Q5528QPtbxscInl063r3
jYqOAUYhv2VJwlGYRhDxiOBOok0pzT2VKXNli/mGSu6afDoaX1DhPpHSvTO4IJ1D
NZIrK+i5uOLwZiUQSvfQ35q9tKbFzn7WPAdY1xp+8MBpaPW96ZAzv5xwx3zCDAeA
dFIQMBQUU000cIFsJcF/GsD685uCA5oSzX6kxyBpTIDpXKTTesx5XvZhxoFzi/E1
onoQpYuU/a2ner5V5xUrCJzj7MrGbYnYotFAM1RNwCHPLrKcq2R6evWg/oIJDRan
yuE5LCVQbb/eaP8XcIbzEUH5iC7g+XJZUaqvCUHCd9YAwa0QIEM=
=Ggwi
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
