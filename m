Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A03CECDFBD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D245F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D245F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbeGWK2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:28:08 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:54319 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbeGWK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:28:07 -0400
Received: from cl?rock-chips.com (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 791BFDC0C;
        Mon, 23 Jul 2018 17:27:47 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id C6DE436E;
        Mon, 23 Jul 2018 17:27:41 +0800 (CST)
X-RL-SENDER: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: cl@rock-chips.com
X-UNIQUE-TAG: <69fd23123fa57914f1d7e3af2b3916ed>
X-ATTACHMENT-NUM: 0
X-SENDER: cl@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 7463HZZD18;
        Mon, 23 Jul 2018 17:27:47 +0800 (CST)
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, hjc@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH v2 2/6] dt-bindings: mmc: rockchip-dw-mshc: add description for px30
Date:   Mon, 23 Jul 2018 17:25:20 +0800
Message-Id: <1532337924-4185-3-git-send-email-cl@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Add "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc" for
dwmmc on px30 platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 8ce49b2..6f629b1 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -14,6 +14,7 @@ Required Properties:
 							before RK3288
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
 	- "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
+	- "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip PX30
 	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
 	- "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322x
 	- "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
-- 
1.9.1


