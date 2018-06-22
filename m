Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC8EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D15523CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D15523CA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeFVGQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:16:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29246 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbeFVGQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:16:51 -0400
X-UUID: 31b78da31ac84ef8a07f6b927e134630-20180622
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chen.zhong@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 677779281; Fri, 22 Jun 2018 14:16:42 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 22 Jun
 2018 14:16:41 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 22 Jun 2018 14:16:40 +0800
From:   Chen Zhong <chen.zhong@mediatek.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen Zhong <chen.zhong@mediatek.com>
Subject: [RESEND PATCH] dt-bindings: input: Add common keyboard document bindings
Date:   Fri, 22 Jun 2018 14:16:38 +0800
Message-ID: <1529648198-14231-1-git-send-email-chen.zhong@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree binding documentation for common
keyboard.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 Documentation/devicetree/bindings/input/keys.txt | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/keys.txt

diff --git a/Documentation/devicetree/bindings/input/keys.txt b/Documentation/devicetree/bindings/input/keys.txt
new file mode 100644
index 0000000..a0ea7eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/keys.txt
@@ -0,0 +1,8 @@
+General Keys Properties:
+
+Optional properties for Keys:
+- power-off-time-sec: Duration in seconds which the key should be kept
+ 	pressed for device to power off automatically. Device with key pressed
+ 	shutdown feature can specify this property.
+- linux,keycodes: Specifies the numeric keycode values to be used for
+	reporting key presses.
\ No newline at end of file
-- 
1.8.1.1.dirty

