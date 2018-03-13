Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeCMOL1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:11:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9251 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751720AbeCMOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:11:26 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Yannick FERTRE <yannick.fertre@st.com>,
        Vikas MANOCHA <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe CORNU <philippe.cornu@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Brian Norris" <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] board: Add STM32F769 SoC, discovery board
 support
Thread-Topic: [PATCH v3 10/10] board: Add STM32F769 SoC, discovery board
 support
Thread-Index: AQHTutJSYxZSuDonAkiSJ9h8vNW+zaPOI4iA
Date: Tue, 13 Mar 2018 14:10:00 +0000
Message-ID: <4c8d87d0-9d14-7fd6-1c20-c9075d7b9b4a@st.com>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
 <1520949014-21468-15-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1520949014-21468-15-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E830B79938862F4AB952E2A090714FA3@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DEBdDd010991

Hi Yannick

You have forgotten the commit message

Patrice

On 03/13/2018 02:50 PM, yannick fertre wrote:
> Signed-off-by: yannick fertre <yannick.fertre@st.com>
> ---
>   configs/stm32f769-disco_defconfig | 65 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100644 configs/stm32f769-disco_defconfig
> 
> diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
> new file mode 100644
> index 0000000..01b3b51
> --- /dev/null
> +++ b/configs/stm32f769-disco_defconfig
> @@ -0,0 +1,65 @@
> +CONFIG_ARM=y
> +CONFIG_STM32=y
> +CONFIG_SYS_TEXT_BASE=0x08008000
> +CONFIG_SYS_MALLOC_F_LEN=0xC00
> +CONFIG_STM32F7=y
> +CONFIG_TARGET_STM32F746_DISCO=y
> +CONFIG_DEFAULT_DEVICE_TREE="stm32f769-disco"
> +CONFIG_ENV_VARS_UBOOT_CONFIG=y
> +CONFIG_BOOTDELAY=3
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_PROMPT="U-Boot > "
> +CONFIG_AUTOBOOT_KEYED=y
> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
> +CONFIG_AUTOBOOT_STOP_STR=" "
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPT=y
> +# CONFIG_RANDOM_UUID is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_SF=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_DHCP=y
> +CONFIG_CMD_MII=y
> +CONFIG_CMD_PING=y
> +CONFIG_CMD_SNTP=y
> +CONFIG_CMD_DNS=y
> +CONFIG_CMD_LINK_LOCAL=y
> +CONFIG_CMD_BMP=y
> +CONFIG_CMD_TIMER=y
> +CONFIG_CMD_EXT2=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +# CONFIG_DOS_PARTITION is not set
> +# CONFIG_SPL_EFI_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_NETCONSOLE=y
> +# CONFIG_BLK is not set
> +CONFIG_DM_MMC=y
> +# CONFIG_SPL_DM_MMC is not set
> +CONFIG_ARM_PL180_MMCI=y
> +CONFIG_MTD=y
> +CONFIG_MTD_NOR_FLASH=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_DM_ETH=y
> +CONFIG_ETH_DESIGNWARE=y
> +# CONFIG_PINCTRL_FULL is not set
> +CONFIG_DM_SPI=y
> +CONFIG_STM32_QSPI=y
> +CONFIG_DM_VIDEO=y
> +CONFIG_BACKLIGHT_GPIO=y
> +CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
> +CONFIG_VIDEO_STM32=y
> +CONFIG_VIDEO_STM32_DSI=y
> +CONFIG_VIDEO_STM32_MAX_XRES=480
> +CONFIG_VIDEO_STM32_MAX_YRES=800
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +# CONFIG_EFI_LOADER is not set
> 
