Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C2224006
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C2224006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeFVKIY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:08:24 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:48138 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933229AbeFVKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:08:19 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 1m8H1y00A3XaVaC01m8H9V; Fri, 22 Jun 2018 12:08:17 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzJ-0001mQ-6V; Fri, 22 Jun 2018 12:08:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzJ-0007df-5L; Fri, 22 Jun 2018 12:08:17 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] MAINTAINERS: Add file patterns for mediatek device tree bindings
Date:   Fri, 22 Jun 2018 12:08:16 +0200
Message-Id: <20180622100816.29320-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
v3:
  - Update for next-20180622,

v2:
  - Add Reviewed-by.

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/soc/mediatek/":

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:4/4=100%)
+Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-Matthias Brugger <matthias.bgg@gmail.com> (commit_signer:4/4=100%)
-Sean Wang <sean.wang@mediatek.com> (commit_signer:3/4=75%,authored:3/4=75%)
-Ulf Hansson <ulf.hansson@linaro.org> (commit_signer:2/4=50%)
-Chen Zhong <chen.zhong@mediatek.com> (commit_signer:1/4=25%)
-"weiyi.lu@mediatek.com" <weiyi.lu@mediatek.com> (authored:1/4=25%)
+linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
+linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb8ce891719ed21..baa4dc046daf9cdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,6 +1634,7 @@ M:	Matthias Brugger <matthias.bgg@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/soc/mediatek/
 F:	arch/arm/boot/dts/mt6*
 F:	arch/arm/boot/dts/mt7*
 F:	arch/arm/boot/dts/mt8*
-- 
2.17.1

