Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeCVRit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:38:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38452 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCVRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:38:47 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable ChromeOS EC drivers for supported Chromebooks.
Date: Thu, 22 Mar 2018 18:38:40 +0100
Message-Id: <20180322173840.26062-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable following drivers for merged devices:
- ChromeOS EC RTC driver.
- ChromeOS EC userspace interface.
- ChromeOS EC light and proximity sensors.
- ChromeOS EC Barometer Sensor driver.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d65d53b1ff77..3c2188f8c1fb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -341,6 +341,7 @@ CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_MFD_CROS_EC_SPI=y
+CONFIG_MFD_CROS_EC_CHARDEV=m
 CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
@@ -492,6 +493,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_RTC_DRV_CROS_EC=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=m
 CONFIG_K3_DMA=y
@@ -546,6 +548,10 @@ CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_ROCKCHIP_SARADC=m
+CONFIG_IIO_CROS_EC_SENSORS_CORE=m
+CONFIG_IIO_CROS_EC_SENSORS=m
+CONFIG_IIO_CROS_EC_LIGHT_PROX=m
+CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
-- 
2.16.2
