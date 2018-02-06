Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeBFKhc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:37:32 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35648 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFKhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:37:22 -0500
X-Google-Smtp-Source: AH8x226T82evgSj6M+TfykPowuvfTypLsp372euw/7nj0cFs2Q3XSqLs7VL3FriHO1D0ZbVRijmwzQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH] arm64: Enable SPRD_TIMER
Date: Tue,  6 Feb 2018 18:36:57 +0800
Message-Id: <6fff71482ed7bb63afa46c024638c0a72810ce29.1517913264.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Spreadtrum timer driver for Spreadtrum plaform, which will be used
as tick broadcast device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/Kconfig.platforms |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..3e0bbb0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -224,6 +224,7 @@ config ARCH_TEGRA
 
 config ARCH_SPRD
 	bool "Spreadtrum SoC platform"
+	select SPRD_TIMER
 	help
 	  Support for Spreadtrum ARM based SoCs
 
-- 
1.7.9.5
