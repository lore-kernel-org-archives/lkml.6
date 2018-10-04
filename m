Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A2C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EB620877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EB620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDSdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:33:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40922 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbeJDSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:33:40 -0400
X-UUID: 1285fb8a764c465ca00be7cc07482b33-20181004
X-UUID: 1285fb8a764c465ca00be7cc07482b33-20181004
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2077952065; Thu, 04 Oct 2018 19:40:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 4 Oct 2018 19:40:39 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 4 Oct 2018 19:40:40 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>
Subject: [PATCH] MAINTAINERS: update entry for Mediatek pin controller
Date:   Thu, 4 Oct 2018 19:40:38 +0800
Message-ID: <98b17a3b47f75d4f3f17dae81a087b4163fcd857.1538652946.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3B87B1EA3FE4E25C6DCFAFD127F82959E2BA9073B6E64083C2061BEAFA7941892000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add all source files under drivers/pinctrl/mediatek for the entry and
change the address to a permanent one since I have a personal leave
over the next few months and the address would be suspended for a while.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@kernel.org>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a692e..bc0e03a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11654,15 +11654,12 @@ S:	Maintained
 F:	drivers/pinctrl/intel/
 
 PIN CONTROLLER - MEDIATEK
-M:	Sean Wang <sean.wang@mediatek.com>
+M:	Sean Wang <sean.wang@kernel.org>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
-F:	drivers/pinctrl/mediatek/mtk-eint.*
-F:	drivers/pinctrl/mediatek/pinctrl-mtk-common.*
-F:	drivers/pinctrl/mediatek/pinctrl-mt2701.c
-F:	drivers/pinctrl/mediatek/pinctrl-mt7622.c
+F:	drivers/pinctrl/mediatek/
 
 PIN CONTROLLER - QUALCOMM
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
-- 
2.7.4

