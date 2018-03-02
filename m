Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426014AbeCBOi1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:38:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55362 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424605AbeCBOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:38:11 -0500
X-Google-Smtp-Source: AG47ELsA+dWuOFAI5gsU0SC8mWVCpAlMP6SI2f3PGzOLqr8KrPKxDS6De0o0x45imkFKtC336fs/+A==
From: Jan Glauber <jglauber@cavium.com>
To: arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
Date: Fri,  2 Mar 2018 15:37:37 +0100
Message-Id: <20180302143737.10788-2-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302143737.10788-1-jglauber@cavium.com>
References: <20180302143737.10788-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
Therefore raise the default number of CPUs from 64 to 256
by adding an arm64 specific option to override the generic default.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3594aefa496f..970950e8c76b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -630,3 +630,4 @@ CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
 CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_AES_ARM64_BS=m
+CONFIG_NR_CPUS=256
-- 
2.7.4
