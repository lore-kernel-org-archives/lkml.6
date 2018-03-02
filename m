Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424108AbeCBPo6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:44:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47559 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031959AbeCBPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:52 -0500
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <u-boot@lists.denx.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/10] board: Add STM32F769 SoC, discovery board support
Date: Fri, 2 Mar 2018 16:44:11 +0100
Message-ID: <1520005451-23217-11-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 configs/stm32f769-disco_defconfig | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 configs/stm32f769-disco_defconfig

diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
new file mode 100644
index 0000000..ac34076
--- /dev/null
+++ b/configs/stm32f769-disco_defconfig
@@ -0,0 +1,63 @@
+CONFIG_ARM=y
+CONFIG_STM32=y
+CONFIG_SYS_MALLOC_F_LEN=0xC00
+CONFIG_STM32F7=y
+CONFIG_TARGET_STM32F746_DISCO=y
+CONFIG_DEFAULT_DEVICE_TREE="stm32f769-disco"
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot > "
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
+CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_CMD_BOOTZ=y
+# CONFIG_CMD_FPGA is not set
+CONFIG_CMD_GPT=y
+# CONFIG_RANDOM_UUID is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_LINK_LOCAL=y
+CONFIG_CMD_BMP=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+# CONFIG_DOS_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_NETCONSOLE=y
+# CONFIG_BLK is not set
+CONFIG_DM_MMC=y
+# CONFIG_SPL_DM_MMC is not set
+CONFIG_ARM_PL180_MMCI=y
+CONFIG_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+# CONFIG_PINCTRL_FULL is not set
+CONFIG_DM_SPI=y
+CONFIG_STM32_QSPI=y
+CONFIG_DM_VIDEO=y
+CONFIG_BACKLIGHT_GPIO=y
+CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
+CONFIG_VIDEO_STM32=y
+CONFIG_VIDEO_STM32_DSI=y
+CONFIG_VIDEO_STM32_MAX_XRES=480
+CONFIG_VIDEO_STM32_MAX_YRES=800
+CONFIG_OF_LIBFDT_OVERLAY=y
+# CONFIG_EFI_LOADER is not set
-- 
1.9.1
