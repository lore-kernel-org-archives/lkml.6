Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E249C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED09D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeLQGED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:04:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:37221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLQGEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:04:02 -0500
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MUHbK-1gyes32odu-00R3oy; Mon, 17 Dec 2018 07:03:34 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id 9C5116E85602; Sun, 16 Dec 2018 22:03:25 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org
Cc:     Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH 2/2] dt-bindings: edac: Aspeed AST2500
Date:   Sun, 16 Dec 2018 22:01:57 -0800
Message-Id: <1545026517-64069-3-git-send-email-schaecsn@gmx.net>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
X-Provags-ID: V03:K1:MyWwx3gGskanIwe0jDsnK8d7E2zY9k8gWtJXmZkccmuO4erj1bH
 ymZXIVv4zZXpdrndTR4X72/n37JJ7qxeGnMdaZG4/fVSami207jaxTziuxlinSR8sDrUcF+
 qKRYixdG0GW3xr/0FGpi6FP2BYOHcxwtaDMW6wQfyTxWkZ+cpE8bNLAufo1ijQLUwRizkoq
 srDURXm9mVvzm8OBLovwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mbv8/CNPiQ4=:2oOK6ayD7ROsSVujygy+HQ
 6F30PoDWGXHg97XU6G0IiIlb11FWywQLBMm6Zf5fCydDRb/bN/7AwxDU5gIeSlvKFQNHp9w5Z
 rmjsksZ4fURMxYA2OsKAKG3vTulI01MUVPYiZIVKxrGKULhAI91F6bOaM9OFIZa9GbFRzvPzB
 rcoFH9fazKYB/AAdy6WRh0umLYti8ruvmq2wrRQ8Rp53Q5MiIcF/e8HxLbme1ftrFaUoge69i
 DM70+TmOG2dkrMlhu1voDtQtkuQ5nRRPJ4M1wJ2JEcavk8R/cervefy/u4arZBKHEyB86dtSb
 JwzUWnBSHqrRPWlK20qKQnZ1FBSIcz67aRXNFOKRPTWeva7M80DhkN1mlHuEuj6RudB922/ez
 IHTu/YEO2psNtLz1NZSWXuHM4TC5KsZnTNqVEUJ/yOnR++JpDMAOmkV8+kO6jklN6nru0dpAB
 xVh9dPPMdn8smoJPobSHGcRtBzlYVN9gAS9KqWUu09L5SMpVnHIJFFD/cEppEADq4xcppQkxu
 Rt7No3xclgzmKjhpDDXOGw9LIr0/QPokHSU92U5EEr+tb6fA5MLuecx7io4NB85NOufJ35mNl
 fGaOVPmpW3ATBeJOSqbiAjQJ9zMik4urt9zMRCPwHept1x4x5QhMaaCpoO1o266CxitV+pBO3
 vzDMBKcL1YIq+l8eu8U+twqpWHa2enXRb/cCwa6DZEhw+PdVMXwVOpEWD98ICeMe3iHCsnzlP
 VlT0Dx7GVeYX08nSQ0A00IuRQF+ifq9UQVPnbgPxqP9Q6pC7XUdu2ULY35vfwacMjEaNgKKGg
 O+GYfD4A1+Lct4AMxdNNr5GjT3PdqO4RwuNmPu0EKv0LBE+ZBDem3R/oN8O3gx7DY1u1mD4Cl
 DbqIhhvoRm5UaoQvilgfVnhjDRxIxNKS4fpDv1ag4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan M Schaeckeler <sschaeck@cisco.com>

Add support for the Aspeed AST2500 SoC EDAC driver.

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
---
 .../bindings/edac/aspeed-sdram-edac.txt       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
new file mode 100644
index 000000000000..57ba852883c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
@@ -0,0 +1,34 @@
+Aspeed AST2500 SoC EDAC device driver
+
+The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
+correction check).
+
+The memory controller supports SECDED (single bit error correction, double bit
+error detection) and single bit error auto scrubbing by reserving 8 bits for
+every 64 bit word (effectively reducing available memory to 8/9).
+
+First, ECC must be configured in u-boot. Then, this driver will expose error
+counters via the edac kernel framework.
+
+A note on memory organization in ECC mode: every 512 bytes are followed by 64
+bytes of ECC codes. The address remapping is done in hardware and is fully
+transparent to firmware and software. Because of this, ECC mode must be
+configured in u-boot as part of the memory initialization as one can not switch
+from one mode to another when executing in memory.
+
+
+
+Required properties:
+- compatible: should be "aspeed,ast2500-sdram-edac"
+- reg:        sdram controller register set should be <0x1e6e0000 0x174>
+- interrupts: should be AVIC interrupt #0
+
+
+Example:
+
+	edac: sdram@1e6e0000 {
+		compatible = "aspeed,ast2500-sdram-edac";
+		reg = <0x1e6e0000 0x174>;
+		interrupts = <0>;
+		status = "okay";
+	};
-- 
2.19.1

