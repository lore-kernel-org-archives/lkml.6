Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CC304C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEDF208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEDF208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756158AbeFOLps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:45:48 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755647AbeFOLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:45:44 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.43.150]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MZysF-1fnwBq02wx-00Ll22; Fri, 15 Jun 2018 13:45:37 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 1/2] dt-bindings: pfuze100: add pfuze3001 support
Date:   Fri, 15 Jun 2018 13:44:52 +0200
Message-Id: <1529063093-19582-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
References: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:qXTRrpYlcxfHkM0ZYC7OK70IKV/HbJ9OrQLYpRkpCAtJnnVYxdr
 5IH2Kv1H4BgQ1obgE8i6WfvrdunJSSajoBFdz2dNBTwUA68fApsdZ1t6RbdjrCPuko3ANpK
 4vv8eb5MKtFfFYPrg//a5Vd/J9lOjhn2+Cy5OudzHcXjAxM4q4iTOmt8ezUr/oQ+SqOMJzg
 Rm259sIc75e8fTQyYyR9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WL3tj/8zchk=:erMrILb8ZHcSEPLr5tOFC/
 tOuVoO5NQzN6ycLxRU/vP8llZJt8p1waSM3eOTUmRQ7pdpxm76YZUavPoTeQmtfkS9bk/TU0X
 ILoPqcqyzpLS5sIG9TufPYK7a5rxlzNOBU5Q6SPE38TB7Hh6VK0F5f98Q6JFqfoEcvoPm0gKm
 xv50saT6Pf4VF71EN6uciKOL/63I7SxrArzJgVN+fVgart6semHCpL5Hkrh1yyIDwWGejzGia
 HTsrDVkMnhyBZtoNoX7nepH22Si6jPoi8fzmUjlQ0Kj3RbR2EAVrfcThK5ROCCKPKCIMvXfVj
 DdGdME030mUs38U6OY27dpBoXTmPeQXMx7OTxpoKiPBpnIzJwR1sQPl/dQI6ck27Iy3SiJX2E
 GvLgu9c+G5ilAsCSRcqjxFDxOQYntZ/cXws3jxsWzZzBU86yriUXZGj7IkfWGN39qy8KhgmDv
 ISDVyy3tsemd1Eq+16SX3aYMVluqyRtHhIosihSgxxuOF/GKi7MZ38Lc8kZ9eNxcPdBtJFjEL
 W7+QrYfqe0Zp2tWXlL29jElp4ykDXSA69LGwygEHn+jIbB5HCJQKYkzdDxrJw/ea2+vYItk9t
 209jWf4fGWupd4iUP0EF8Gh68BxACEalYsrF2L7mQmqLiXPzGrUhVDAOV27RO5V6EBhrm8O4h
 rvU7V05AwTHpwKaZcr6mDFG/JkRjhe4vpsBCZfdMFcY0ArTvC8HqLQMQ6L4SMF9VpFqY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends binding according to support the pfuze3001 chip.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/regulator/pfuze100.txt     | 77 +++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index f0ada3b..672c939 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -1,7 +1,7 @@
 PFUZE100 family of regulators
 
 Required properties:
-- compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000"
+- compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000", "fsl,pfuze3001"
 - reg: I2C slave address
 
 Required child node:
@@ -16,6 +16,8 @@ Required child node:
   sw1ab,sw2,sw3a,sw3b,swbst,vsnvs,vrefddr,vgen1~vgen6,coin
   --PFUZE3000
   sw1a,sw1b,sw2,sw3,swbst,vsnvs,vrefddr,vldo1,vldo2,vccsd,v33,vldo3,vldo4
+  --PFUZE3001
+  sw1,sw2,sw3,vsnvs,vldo1,vldo2,vccsd,v33,vldo3,vldo4
 
 Each regulator is defined using the standard binding for regulators.
 
@@ -303,3 +305,76 @@ Example 3: PFUZE3000
 			};
 		};
 	};
+
+Example 4: PFUZE 3001
+
+	pfuze3001: pmic@8 {
+		compatible = "fsl,pfuze3001";
+		reg = <0x08>;
+
+		regulators {
+			sw1_reg: sw1 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vldo2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vccsd {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: v33 {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
-- 
2.7.4

