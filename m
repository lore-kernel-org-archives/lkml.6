Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeCMFSz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:18:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14913 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeCMFSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:18:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180313051852epoutp032b8d3d5e44f84aa928bcda30b5e5d214~bYyowNlXC1689116891epoutp03s
X-AuditID: b6c32a48-9adff70000000ff0-e9-5aa75f3b2245
Subject: Re: [PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
To: jinb.park@samsung.com,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <4eb795d0-42ce-a8e1-00c5-b779a5fe282c@samsung.com>
Date: Tue, 13 Mar 2018 14:18:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTTNc6fnmUwZsXihZfJr1jt3i/rIfR
        YtHx+2wWmx5fY7W4vGsOm8XS6xeZLGZMfsnmwO6xZt4aRo/NS+o9+rasYvT4vEnO4/X+Q4wB
        rFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N9AwNzPWMjIz0TIxjrYxMgUoSUjM+nbrI
        XNDAV3Gv4Q9jA+Mi7i5GTg4JAROJST1TmLoYuTiEBHYwSpw79J0VwvnOKHH1w19GmKppu/vZ
        IRIbGCX6Vp+BarnLKDHt0S5mkCphAWeJxZeeg1WJCKxmlDh1vokZxGEWuMQocXzaByaQKjYB
        HYnt344D2RwcvAJ2ErOmWICEWQRUJe70nGMHsUUFwiSOzvwEtppXQFDix+R7LCDlnAJ+Ek0t
        fiBhZgFNiRdfJrFA2OISza03oWx5ic1r3jJDXH2GTeLk1SgI20Xi35/vbBC2sMSr41vYIWxp
        iWerNkJ92c4ocXa2MMjJEgJTGCVWzOhmgkgYSzxb2MUEsYBPouPwX3aQeyQEeCU62oQgSjwk
        7i4/DBV2lFj4ixMSPlOBwbDlAtMERrlZSL6ZheSFWUhemIXkhQWMLKsYxVILinPTU4uNCkz0
        ihNzi0vz0vWS83M3MYIToZbHDsYD53wOMQpwMCrx8Ha0LosSYk0sK67MPcQowcGsJMKr/B8o
        xJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBSTqvJN7QxNLAxMzMyNzMApjaxHnbAlyihATS
        E0tSs1NTC1KLYPqYODilGhjbe2PfxORNKRD7z9LcftZ2Tez9Te+23JFm6em9lBMj+4HD4pvr
        mvuLo6P56qy4G3eych075MTiaapzkSfrOsf31Wc4d4YbcsxVjXv/6uoqBbe1ssU3psccPcgi
        F6yTc2PtnzP75WLeMKo38HOx5Nz/wXby5b4HFvsEb+0WjLvbPlH7jdoxRi4lluKMREMt5qLi
        RAAb3jcImgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV2r+OVRBuvnmFh8mfSO3eL9sh5G
        i0XH77NZbHp8jdXi8q45bBZLr19kspgx+SWbA7vHmnlrGD02L6n36NuyitHj8yY5j9f7DzEG
        sEZx2aSk5mSWpRbp2yVwZXw6dZG5oIGv4l7DH8YGxkXcXYycHBICJhLTdvezdzFycQgJrGOU
        OLGlHcq5zyjRvmgOI0iVsICzxOJLz8ESIgKrGSXurrsClmAWuMIo8exGMUTHdEaJW7s3M4Mk
        2AR0JLZ/O87UxcjBwStgJzFrigVImEVAVeJOzzl2EFtUIEyiZ9NlsDm8AoISPybfYwEp5xTw
        k2hq8QMxmQXUJaZMyYXYJC7R3HqTBcKWl9i85i3zBEaBWUiaZyF0zELSMQtJxwJGllWMkqkF
        xbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIERsO2wVv8OxsdL4g8xCnAwKvHwdrQuixJiTSwr
        rsw9xCjBwawkwqv8HyjEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2ampBahFM
        lomDU6qB0XZnQb04j0m9SYTiCQ3lctvuM+7P7SNYBK7yv/vmucC1+oDsvZ8HKh6ckOyTNd2W
        k37LgOHEVwuRxt+MkULmK8qSdnm1MrB0FfYYmm2TENose2H3oY2CttW80Vc52Dn6fCVtPwQZ
        Ppaf/fOKCc8DkZW32qevSfbp4pX4nXygVc9C8d6mtgdKLMUZiYZazEXFiQAvEO7kfAIAAA==
X-CMS-MailID: 20180313051850epcas2p115f670f01aa22d1456d9b7e1d072e68b
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
X-RootMTR: 20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26
References: <CGME20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
        <20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 01:53 PM, Jinbum Park wrote:
> To enable UBSAN on arm, ARCH_HAS_UBSAN_SANITIZE_ALL is needed to be selected.
> 
> Basic test has passed on Raspberry Pi2, Raspbian jessi lite with
> CONFIG_UBSAN_SANITIZE_ALL, CONFIG_UBSAN_NULL.

This patch had been already sent from Seungwoo.

https://patchwork.kernel.org/patch/9344477/

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Jinbum Park <jinb.park@samsung.com>
> ---
>  arch/arm/Kconfig                  | 1 +
>  arch/arm/boot/compressed/Makefile | 1 +
>  arch/arm/vdso/Makefile            | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1878083..bdd1561 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,6 +7,7 @@ config ARM
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
> +	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..1b374ba 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
>  endif
>  
>  GCOV_PROFILE		:= n
> +UBSAN_SANITIZE		:= n
>  
>  #
>  # Architecture dependencies
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index bb411821..05597f7 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -29,6 +29,7 @@ CFLAGS_vgettimeofday.o = -O2
>  
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
> +UBSAN_SANITIZE := n
>  
>  # Force dependency
>  $(obj)/vdso.o : $(obj)/vdso.so
> 
