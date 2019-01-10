Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F50C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1E821738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfAJC32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:29:28 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:44461 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbfAJC31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:29:27 -0500
X-ASG-Debug-ID: 1547087361-093b7e40ef08420001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id CZlH7xSdAs82Beof (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 10 Jan 2019 10:29:21 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from openbmc001.localdomain (10.5.21.169) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 10:29:11 +0800
From:   Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@roeck-us.net>
CC:     <openbmc@lists.ozlabs.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <shunyong.yang@hxt-semitech.com>,
        <dongsheng.wang@hxt-semitech.com>,
        Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Subject: [PATCH v3 3/4] ARM: dts: dps650ab: add power supply
Date:   Thu, 10 Jan 2019 10:29:13 +0800
X-ASG-Orig-Subj: [PATCH v3 3/4] ARM: dts: dps650ab: add power supply
Message-ID: <a7b5fa54198e7fd0def33de3e7db36239a2e3da7.1546918172.git.xiaoting.liu@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.169]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1547087361
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9813 1.0000 4.1264
X-Barracuda-Spam-Score: 4.13
X-Barracuda-Spam-Status: No, SCORE=4.13 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65431
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Delta Electronics power supply DPS-650-AB.

Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
---
v3:
  Modify patch subject and commit message.
  Add delta to compatible property.
---
v2:
  No change.
---
 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
index bdfd8c9f3a7c..521afbea2c5b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
@@ -173,6 +173,16 @@
 			};
 		};
 	};
+
+	dps650ab@58 {
+		compatible = "delta,dps650ab";
+		reg = <0x58>;
+	};
+
+	dps650ab@59 {
+		compatible = "delta,dps650ab";
+		reg = <0x59>;
+	};
 };
 
 &i2c9 {
-- 
1.8.3.1

