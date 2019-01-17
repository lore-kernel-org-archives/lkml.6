Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfAQQk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:40:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:57631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbfAQQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:40:26 -0500
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Ma1tv-1gWkYp0Wqt-00LjM3; Thu, 17 Jan 2019 17:40:08 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id 1A3A36E85602; Thu, 17 Jan 2019 08:40:02 -0800 (PST)
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
Subject: [PATCH v2 2/2] dt-bindings: edac: Aspeed AST2500
Date:   Thu, 17 Jan 2019 08:38:17 -0800
Message-Id: <1547743097-5236-3-git-send-email-schaecsn@gmx.net>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
References: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
X-Provags-ID: V03:K1:acREAI7ia05S8qqj43tkSIgjpuCXQAGBmeAKzACUxCAVYTi+eXo
 ntxrFUPgKUBicdHgY4+qrujF7o2Bnytl3PtEL4GIajryYUxWf3z+zFpY6uUAGplStL5aHto
 JgRPzjMipoX8jCq4f6E2GrdkSQ+454TqAOBvYa2/gpgsk6ih/xUo7c8FjNJwTwMug0pMqx6
 24F92KVl+Dhq4yBk3KG3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kSLD9qsKXwE=:9bnK4X4LFcgg+8EfZyr1/S
 H49IljoobZeWJLJ2k7Uz4ccrcN3Uvv9vEI+i3wM6UVRYAw7WDzGLkClB7yG4XzAc+vXE2ivXd
 Azwa9Ol0EFgrj/YVCrM3upLiVT6GeXWm0wMxaa48dZBlVwPbZe/qOBWDd3AMVwhQy0F4/sPd2
 0ADTc9g6/l5+rj4ycCvIDIj+Zlnv6VV33g3rbeOfQ7Y2dNjM5mhsdAsj3XvUsWpFoGtIzPPE3
 G5WYOCDmucd9pq0Ufxxu3v796+ZPqHp7j2q/825E3Jjqjgc6KJd63zb7GnBzX/oiii7N0O5AC
 YUuyNGApd+ciXcu3f9K0HgYC08RbZSckW+xImmrsf/b+F/B3pkO65T81v4pZqbAYjnR1hZbQL
 JV6poeNOhvhlP5TLoST8tqICPSqcwJzKmX1iPNAyCGHoYZS2ZpY2aQEou8YBmWlhgu379XYih
 P5AGDZeKXfuKba8+XBa4X70UxUNSTKt5Dwvkat/0rU6s2vtYBaMR5qKGV+TC6L9+1FprHAqUD
 +CuM1i2xfXvDz+XoAoYpX+janc2ObMRuaOfyTanderCz64srZk7pt1TnjXmSaGsR4CgFlekwp
 zwOwtkB2KDyMOQfotDkPcbHAlXBrtZiCOsazVGe9DPjI2OrRSGhMOai+X3lcSTEFNwwxKfIc7
 3SHC0HY0avxgSr1pMQIDytvWD8fQSyqrwBpapFXay1UES8y/sKrl6HvcEhO/tw9LC3pl/40L3
 QU0Ftq+/KKEu+aPMFxngQ2ug3c99896lGhd9wNusGj0G1xDPShqjIuWxitKKa/gpmCuItuiMa
 iNE2U7GYOEKIND8wq6PFiMAO+SBmhmCAwdwleVnRtlpopQoM+zLFlqPNyG7DLAuH4wZosrBtH
 FFEbIMu0TzkigzPgcFmMXvM3/VudevnBWFnXFCN/YSXMYD5YeQmqHhq0966q8N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan M Schaeckeler <sschaeck@cisco.com>

Add support for EDAC on the Aspeed AST2500 SoC.

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
---
 .../bindings/edac/aspeed-sdram-edac.txt       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
new file mode 100644
index 000000000000..6a0f3d90d682
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
@@ -0,0 +1,25 @@
+Aspeed AST2500 SoC EDAC node
+
+The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
+correction check).
+
+The memory controller supports SECDED (single bit error correction, double bit
+error detection) and single bit error auto scrubbing by reserving 8 bits for
+every 64 bit word (effectively reducing available memory to 8/9).
+
+Note, the bootloader must configure ECC mode in the memory controller.
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
+	};
-- 
2.19.1

