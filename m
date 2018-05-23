Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935033AbeEWUcz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:32:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43228 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935008AbeEWUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:32:47 -0400
X-Google-Smtp-Source: ADUXVKJ4Vk9TotFL9+1VCXch22/Xy3hsByz08+EsaHP1D0tSVgVhTVq8xFc9bJ8FjZlK3pYBXe58AA==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 6/6] arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG
Date: Wed, 23 May 2018 13:32:07 -0700
Message-Id: <1527107527-8093-7-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
References: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SP805 watchdog timer

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..3fe5eb5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -351,6 +351,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
-- 
2.1.4
