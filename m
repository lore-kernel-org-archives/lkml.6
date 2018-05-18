Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeERQzB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:55:01 -0400
Received: from vern.gendns.com ([206.190.152.46]:56866 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeERQu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:50:29 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 14/27] ARM: davinci_all_defconfig: remove CONFIG_DAVINCI_RESET_CLOCKS
Date: Fri, 18 May 2018 11:48:16 -0500
Message-Id: <20180518164829.27052-15-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518164829.27052-1-david@lechnology.com>
References: <20180518164829.27052-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes CONFIG_DAVINCI_RESET_CLOCKS. The option has been removed from
the kernel.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v11 changes:
- none

v10 changes:
- none

v9 changes:
- none

v8 changes:
- none

v7 changes:
- none

v6 changes:
- none


 arch/arm/configs/davinci_all_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 21b2d7791df4..f83ea4131df2 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -31,7 +31,6 @@ CONFIG_MACH_MITYOMAPL138=y
 CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
-CONFIG_DAVINCI_RESET_CLOCKS=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_CMA=y
-- 
2.17.0
