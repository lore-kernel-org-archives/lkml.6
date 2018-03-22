Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeCVLvN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:51:13 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:62318 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751891AbeCVLu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:50:57 -0400
X-IronPort-AV: E=Sophos;i="5.48,344,1517842800";
   d="scan'208";a="274538282"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 8/8] DT: arm: Add the RZN1D-DB Board to Renesas Makefile target
Date: Thu, 22 Mar 2018 11:44:45 +0000
Message-Id: <1521719091-25157-9-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the newly added board to the Renesas built target

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3b4cc1b..0f01ada 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -806,6 +806,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
+	r9a06g032-rzn1d400-db.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rv1108-evb.dtb \
-- 
2.7.4
