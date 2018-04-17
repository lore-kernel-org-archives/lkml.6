Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2581930-1523994825-2-1900340919084174443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523994824; b=rbVhqkTrts3Jjl0+xMOfnWqvebAcabkOot/B6l9Oy3nBpwQPHG
    TvDhsJHMJv4X+PSWahBSX9zGnwrfDMQLBDJSQDrp4fmAZvMBW0Iv+MaPl43vct57
    O5oQzUQQCSvCui83UoLjd7mAhNHE+Lxz+0MuOqV/MjPjRZ+XMnrRuzjQO5KQxerk
    pNUelgS2bT/q5GMWIa2FVsQa3Jp93pOjOgghlX8UYLr3r33E20Uv71cjr2QwjvGl
    s+Lz+QB2FcbApEamdkGbhmDAjNzzdXeamE5ELGB9XbOrjS2GfP6VENjvikQlp1Nq
    TMQ243HRMD5atqlQNJZl/igyCGMc0e+8mv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523994824; bh=KW3eD
    fjVpkxxGxHeZYwNB5V5aACaZFup/3jXbM1/Ww0=; b=F9LVKxpoNKx427HiyqgSc
    RPSViycFis+g9yqQVgHrE0lvcv0RHGrlKeadNIxx7cxEqnHqmzmcreufJdmnviPB
    WP3WrXaXoRSG8JxASwpCkbr4mzz9kCL0LWPqeKc3PKyBB8pK2TKGQwDWaU18BGk7
    F2V0R8WgSllBidSedzqFNcCIcTPlllHnppPs9ijrperb2zPGsThXIbLfSwrcFDbG
    JEWw2+4QMenjNzmbBfFhOSsB7uSw3gx8XqmngOIAU5/R6i4tmPV9YIQznQ3iQzer
    VYMXJqaNIoL3I6xfTlsHm+/5rtOLthFWBCj07qbf3BCfNKLCi1MHUGbMraEMxfHX
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNuu0QF1uk4GQH+2nm/DoJPo1tU3LXRTRV/V3A/YZBKhnCvRoTpXCwEFkBRnIif8qN87NlX6uEXRJ78w7dhoiU7Ln665xmdFRJv6wQbVUN0c8pUmtpqK
    w030LUljZ+CohE2KSp4smElSmZQZb9MI1eR4ZnTFQ+fFGdYbQwwcI0UJu2BIuqRRw8tWoNg4Cz5ap+RJZhSsNWp+ELKIhEpHhEAMYF6UKJIaMrnqLFNluT6L
    SPeCP9oD2w+wyP8i21ft3w==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=DDOyTI_5AAAA:8 a=d5QUEaZ_3_V5qvzpo28A:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 18/20] spi: Remove depends on HAS_DMA in case of platform
 dependency
Date: Tue, 17 Apr 2018 19:49:18 +0200
Message-Id: <1523987360-18760-19-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 linux-media@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-remoteproc@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
In most cases this other symbol is an architecture or platform specific
symbol, or PCI.

Generic symbols and drivers without platform dependencies keep their
dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
cannot work anyway.

This simplifies the dependencies, and allows to improve compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
v3:
  - Add Acked-by,
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/spi/Kconfig | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2d4146ce2f1be49d..5a8524a3bc13f92d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -71,7 +71,6 @@ config SPI_ARMADA_3700
 
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on HAS_DMA
 	depends on ARCH_AT91 || COMPILE_TEST
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
@@ -233,7 +232,6 @@ config SPI_EFM32
 
 config SPI_EP93XX
 	tristate "Cirrus Logic EP93xx SPI controller"
-	depends on HAS_DMA
 	depends on ARCH_EP93XX || COMPILE_TEST
 	help
 	  This enables using the Cirrus EP93xx SPI controller in master
@@ -355,7 +353,6 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
-	depends on HAS_DMA
 	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || M5441x || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
@@ -431,7 +428,6 @@ config SPI_OMAP_UWIRE
 
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
-	depends on HAS_DMA
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select SG_SPLIT
 	help
@@ -440,7 +436,6 @@ config SPI_OMAP24XX
 
 config SPI_TI_QSPI
 	tristate "DRA7xxx QSPI controller support"
-	depends on HAS_DMA
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  QSPI master controller for DRA7xxx used for flash devices.
@@ -469,7 +464,6 @@ config SPI_PIC32
 config SPI_PIC32_SQI
 	tristate "Microchip PIC32 Quad SPI driver"
 	depends on MACH_PIC32 || COMPILE_TEST
-	depends on HAS_DMA
 	help
 	  SPI driver for PIC32 Quad SPI controller.
 
@@ -572,7 +566,7 @@ config SPI_SC18IS602
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on HAVE_CLK && HAS_DMA
+	depends on HAVE_CLK
 	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
@@ -650,7 +644,7 @@ config SPI_MXS
 config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
-	depends on RESET_CONTROLLER && HAS_DMA
+	depends on RESET_CONTROLLER
 	help
 	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
 	  is different than the older SoCs SPI controller and also register interface
@@ -668,7 +662,7 @@ config SPI_TEGRA20_SFLASH
 config SPI_TEGRA20_SLINK
 	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
-	depends on RESET_CONTROLLER && HAS_DMA
+	depends on RESET_CONTROLLER
 	help
 	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
