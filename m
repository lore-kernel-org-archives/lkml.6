Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeDKPRi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:17:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:64021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752852AbeDKPRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:17:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="219594926"
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] ARM: socfpga_defconfig: Remove QSPI Sector 4K size force
To: dinguyen@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <1522093800-7822-1-git-send-email-thor.thayer@linux.intel.com>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <1e858591-aaae-72f0-de0f-40aea11e502a@linux.intel.com>
Date: Wed, 11 Apr 2018 10:20:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522093800-7822-1-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Any comments on this patch?

On 03/26/2018 02:50 PM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Remove QSPI Sector 4K size force which is causing QSPI boot
> problems with the JFFS2 root filesystem.
> 
> Fixes the following error:
>       "Magic bitmask 0x1985 not found at ..."
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>   arch/arm/configs/socfpga_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 2620ce790db0..371fca4e1ab7 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -57,6 +57,7 @@ CONFIG_MTD_M25P80=y
>   CONFIG_MTD_NAND=y
>   CONFIG_MTD_NAND_DENALI_DT=y
>   CONFIG_MTD_SPI_NOR=y
> +# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
>   CONFIG_SPI_CADENCE_QUADSPI=y
>   CONFIG_OF_OVERLAY=y
>   CONFIG_OF_CONFIGFS=y
> 
