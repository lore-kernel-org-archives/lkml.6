Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247C1214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfAHXrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:47:03 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:52910 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727829AbfAHXrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:47:02 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43Z8766z9TzSm;
        Wed,  9 Jan 2019 00:46:58 +0100 (CET)
Date:   Wed, 9 Jan 2019 00:46:55 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/1] doc: bindings: fix bad reference to ARM CPU bindings
Message-ID: <08ea3e964c337df6ef532ac4586f488edab80048.1546991072.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The primecell.txt and cpus.txt files were converted into YAML. This
patch updates old references with new ones.

Fixes: d3c207eeb905 ("dt-bindings: arm: Convert primecell binding to json-s=
chema")
Fixes: 672951cbd1b7 ("dt-bindings: arm: Convert cpu binding to json-schema")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt          | 2 +-
 Documentation/devicetree/bindings/arm/idle-states.txt           | 2 +-
 Documentation/devicetree/bindings/arm/sp810.txt                 | 2 +-
 Documentation/devicetree/bindings/arm/topology.txt              | 2 +-
 Documentation/devicetree/bindings/display/arm,pl11x.txt         | 2 +-
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Docum=
entation/devicetree/bindings/arm/cpu-capacity.txt
index 84262cdb8d29..96fa46cb133c 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -235,4 +235,4 @@ cpus {
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 [1] ARM Linux Kernel documentation - CPUs bindings
-    Documentation/devicetree/bindings/arm/cpus.txt
+    Documentation/devicetree/bindings/arm/cpus.yaml
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Docume=
ntation/devicetree/bindings/arm/idle-states.txt
index 8f0937db55c5..45730ba60af5 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -684,7 +684,7 @@ cpus {
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 [1] ARM Linux Kernel documentation - CPUs bindings
-    Documentation/devicetree/bindings/arm/cpus.txt
+    Documentation/devicetree/bindings/arm/cpus.yaml
=20
 [2] ARM Linux Kernel documentation - PSCI bindings
     Documentation/devicetree/bindings/arm/psci.txt
diff --git a/Documentation/devicetree/bindings/arm/sp810.txt b/Documentatio=
n/devicetree/bindings/arm/sp810.txt
index 1b2ab1ff5587..46652bf65147 100644
--- a/Documentation/devicetree/bindings/arm/sp810.txt
+++ b/Documentation/devicetree/bindings/arm/sp810.txt
@@ -4,7 +4,7 @@ SP810 System Controller
 Required properties:
=20
 - compatible:	standard compatible string for a Primecell peripheral,
-		see Documentation/devicetree/bindings/arm/primecell.txt
+		see Documentation/devicetree/bindings/arm/primecell.yaml
 		for more details
 		should be: "arm,sp810", "arm,primecell"
=20
diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documenta=
tion/devicetree/bindings/arm/topology.txt
index de9eb0486630..b0d80c0fb265 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/arm/topology.txt
@@ -472,4 +472,4 @@ cpus {
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 [1] ARM Linux kernel documentation
-    Documentation/devicetree/bindings/arm/cpus.txt
+    Documentation/devicetree/bindings/arm/cpus.yaml
diff --git a/Documentation/devicetree/bindings/display/arm,pl11x.txt b/Docu=
mentation/devicetree/bindings/display/arm,pl11x.txt
index ef89ab46b2c9..572fa2773ec4 100644
--- a/Documentation/devicetree/bindings/display/arm,pl11x.txt
+++ b/Documentation/devicetree/bindings/display/arm,pl11x.txt
@@ -1,6 +1,6 @@
 * ARM PrimeCell Color LCD Controller PL110/PL111
=20
-See also Documentation/devicetree/bindings/arm/primecell.txt
+See also Documentation/devicetree/bindings/arm/primecell.yaml
=20
 Required properties:
=20
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic=
-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3=
=2Etxt
index b83bb8249074..a3be5298a5eb 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -78,7 +78,7 @@ Sub-nodes:
 PPI affinity can be expressed as a single "ppi-partitions" node,
 containing a set of sub-nodes, each with the following property:
 - affinity: Should be a list of phandles to CPU nodes (as described in
-Documentation/devicetree/bindings/arm/cpus.txt).
+  Documentation/devicetree/bindings/arm/cpus.yaml).
=20
 GICv3 has one or more Interrupt Translation Services (ITS) that are
 used to route Message Signalled Interrupts (MSI) to the CPUs.
--=20
2.17.2


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw1NmYACgkQgjuumfi+
HjyhuQ//eY0GPNtt22ho0xSKjbcDSxeiNE3urknnF4Nc0fz1zdKiyfz1fhL2wlof
mh8xdLgesWVB7hzM6yGXXPQ1TjLx3nYwI3RzDVY8i5/9Oi5EXJnWr/U5F2wf+0eB
INiOn3GrO3RoiGk/RAq2yLcUsBSrav7yiFqJu55kzDqix6NzmrK03D3fWK+ex1z4
JtMPOfm3pd9BoEV4p/60sXiaGRoJXYFelpg8eP6Ux//EZYv2dJlqqct3qmJSlzzX
7J1jurKxtWfDn2Aya/MUDIQmEJe9qeOW37iTw9cQXHsICIZ4lKqICpwOivecgqIQ
sDrA+YZX9VKdrdOysb/sdODg/uLvSjkdr1MYDTHa4Rc6M8bjfNjAn0dB6pH7OSlY
Q5xLd/ZS+XyeJPco6fZ/sII87r6FU3Vqauut/TePXlZjJ4A+kGXEyLXaGVkriQbJ
fOxY0xXH1RYHqeCi79uxMJdXJyog/JjeQuBKfgbvfD0bKRzQinGWXqG3zTKgql0k
gh1o2uQWDCPFjXo+kZIUiM0Xh+7CkhErF9Qt4FwcdUvmUl+N+M0FvOobHNTzLU3r
MDykWp5udQuAvSzw4Cuetb048np7D7NbKQrxsLXfZvfd5OUVV65qLMrI3HHkqTBL
+066fzZucw6AslP61uK8hRWbychKQlU9lkpruDfnzZDM7t3d87s=
=5mjT
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
