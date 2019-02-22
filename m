Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4E020665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfBVRD2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:03:28 -0500
Received: from mail.hanoverdisplays.com ([81.145.148.229]:38443 "EHLO
        mail.hanoverdisplays.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfBVRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:03:28 -0500
Received: from builder.hanover.local (192.168.0.21) by
 mail.hanoverdisplays.com (192.168.0.30) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Fri, 22 Feb 2019 17:03:25 +0000
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     <aisheng.dong@nxp.com>
CC:     <festevam@gmail.com>, <shawnguo@kernel.org>, <stefan@agner.ch>,
        <kernel@pengutronix.de>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cquast@hanoverdisplays.com>
Subject: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Date:   Fri, 22 Feb 2019 17:00:38 +0000
Message-ID: <20190222170038.9669-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [192.168.0.21]
X-GFI-SMTP-Submission: 1
X-GFI-SMTP-HelloDomain: builder.hanover.local
X-GFI-SMTP-RemoteIP: 192.168.0.21
X-GFIME-MASPAM: SPAM
Disclaimer: hanoverdisplays.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from
the documentation.

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
index 6666277c3acb..8ac1d0851a0f 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
@@ -48,9 +48,9 @@ PAD_CTL_HYS                     (1 << 3)
 PAD_CTL_SRE_SLOW                (1 << 2)
 PAD_CTL_SRE_FAST                (0 << 2)
 PAD_CTL_DSE_X1                  (0 << 0)
-PAD_CTL_DSE_X2                  (1 << 0)
-PAD_CTL_DSE_X3                  (2 << 0)
-PAD_CTL_DSE_X4                  (3 << 0)
+PAD_CTL_DSE_X4                  (1 << 0)
+PAD_CTL_DSE_X2                  (2 << 0)
+PAD_CTL_DSE_X6                  (3 << 0)
 
 Examples:
 While iomuxc-lpsr is intended to be used by dedicated peripherals to take
-- 
2.20.1




 
Please consider the environment before printing this email
 

 
 
 
The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
If you received this in error, please contact the sender or postmaster (postmaster@hanoverdisplays.com) and delete the material from any computer.
Although we routinely screen for viruses, addressees should check this e-mail and any attachment for viruses. We make no warranty as to absence of viruses in this e-mail or any attachments.
Our Company's email policy is to permit incidental personal use. If this email is of a personal nature, it must not be relied upon as expressing the views or opinions of the company.

