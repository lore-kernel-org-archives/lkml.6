Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5809FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDFF20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfA2Qzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:55:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:42819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfA2Qzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:55:53 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrZOj-1hIT3q1zvp-013KQ1; Tue, 29
 Jan 2019 17:55:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: Document the i.MX50 IOMUXC binding
Date:   Tue, 29 Jan 2019 17:55:28 +0100
Message-Id: <20190129165530.7606-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lsf7fDpqK+GPxAmo+y8Vsy9Za2weuS05yggUc3BZKlupdW5wjn6
 CuvG5r+JGclST3BPVmZrqVobB9B9uEgCMmRXKJBDWwcDt3C9VCjtXDMTzlMi+xhg4d6i7Il
 xeDnJVmQ6C1TCnraRXYrTb1M9f7LwQkE8HuHN+0sturjwEngAQxlRDEpl1dCzGuI1zuhjaG
 hRox94X0Uz8entXFhcSqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rf1knTwRFBY=:qoPQ2hJ0EDjo1aW+sOk7+4
 l9QeiUzLAPisqWEa2j851LrtoJKHVl++G2biDjzCxb297bdvMb/CSUyhVdUYb2IZi03eEsdng
 w0vSNERcgzIZsll9eAVCCUIFzexjlti3VOLFROn0yKPHRmlTshE6n4joJIebsfbYHqjoWWQAY
 pFCYRiQ4nAWXV5JB9Wg9ATR8fN/jBWdU9DcS2Z9fepTqSPjvt6eeqvXvjj+5aQFdMo/HuoMIa
 6o+TLWRhO5K/pe/tUOoFAlQD9O76L+S1LXUWHbhHDqccE5OagiK1BvNLsEJ3ScbjdS7CWiL1C
 /XkN+uDnHu3Pm+ZqcpNh6Ag+I2Gi4YDWTTbMdIHmrh71609e2hGPY4w8WzLLPQqbEXPsWNE/l
 BL4LIi5qht9mVEWlpE56uWDPfd+T0vUnGujQPEoU8luTx7dQDrFkE3+h8W19nMASG4hCCXqZ7
 hNqrnisRS+DRZ5oul7OZ5uGU+1bruFj/XnTS0V21S/HON+aKvTerA8P/DoI3oKbkFDOabnPYb
 B3kuWdgFlOrQ1YZCXkyEjsDwHAE+iLCQVDLJXHUrHpUcBFIHwNfuIx9HotCHdsRZACpF50RVw
 MB0m2NGLTy6g2c7/sTRCoDft78qhctdPdcy/Ouhule5RBKiEqSnEkm9NtS1c8qAfQqPc6zLvf
 77klXEGk/CZIpM4XQ7u54829lenq4ccfJsV1DcptWDLzk7r6Lm2bHw/HdAoFVLGGPXBjRlDZX
 woA8PKffp9ph12AQodfU5yhb/NhYLl9z186H3/xuX8qEmQi/b2aK0TMAAuv131JjhgKpA1hb+
 S5jzMFrE2NCLshPyVSPC030EqjhFtklm9XdgYCLzkkIpeC9oRw26Bn9k47RAPRYDH3zHwBEfs
 ECE5SZs64Vr6MmlEn5bvT5TfqsSZnU73ji/aY/JSxgbuFGtiLejWPJxGTqNRYyFqAuaxNPND7
 ulVUfYbxp2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICS from the i.MX50 Reference Manual, the i.MX50 IOMUXC works the
same as the one in i.MX51, so I copied fsl,imx51-pinctrl.txt and changed
the text to imx50.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/pinctrl/fsl,imx50-pinctrl.txt    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx50-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx50-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx50-pinctrl.txt
new file mode 100644
index 000000000000..6da01d619d33
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx50-pinctrl.txt
@@ -0,0 +1,32 @@
+* Freescale IMX50 IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
+and usage.
+
+Required properties:
+- compatible: "fsl,imx50-iomuxc"
+- fsl,pins: two integers array, represents a group of pins mux and config
+  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
+  pin working on a specific function, CONFIG is the pad setting value like
+  pull-up for this pin. Please refer to imx50 datasheet for the valid pad
+  config settings.
+
+CONFIG bits definition:
+PAD_CTL_HVE			(1 << 13)
+PAD_CTL_HYS			(1 << 8)
+PAD_CTL_PKE			(1 << 7)
+PAD_CTL_PUE			(1 << 6)
+PAD_CTL_PUS_100K_DOWN		(0 << 4)
+PAD_CTL_PUS_47K_UP		(1 << 4)
+PAD_CTL_PUS_100K_UP		(2 << 4)
+PAD_CTL_PUS_22K_UP		(3 << 4)
+PAD_CTL_ODE			(1 << 3)
+PAD_CTL_DSE_LOW			(0 << 1)
+PAD_CTL_DSE_MED			(1 << 1)
+PAD_CTL_DSE_HIGH		(2 << 1)
+PAD_CTL_DSE_MAX			(3 << 1)
+PAD_CTL_SRE_FAST		(1 << 0)
+PAD_CTL_SRE_SLOW		(0 << 0)
+
+Refer to imx50-pinfunc.h in device tree source folder for all available
+imx50 PIN_FUNC_ID.
-- 
2.20.1

