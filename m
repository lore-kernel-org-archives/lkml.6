Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369EDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AA72098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AA72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJEDbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:31:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJEDbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:31:20 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y9bLJaC3APof; Thu,  4 Oct 2018 22:36:22 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44DA31EC032D;
        Thu,  4 Oct 2018 22:36:22 +0200 (CEST)
Date:   Thu, 4 Oct 2018 22:36:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        mchehab@kernel.org, sudeep.holla@arm.com, amit.kucheria@linaro.org,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v8 03/10] edac: synopsys: Modify the comments in the
 driver
Message-ID: <20181004203621.GE5149@zn.tnic>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
 <1538667328-9465-4-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1538667328-9465-4-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:05:21PM +0530, Manish Narani wrote:
> There are some comments which can be updated for better readability of
> the driver. Update abbreviations to capital letters in the comments.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 98 ++++++++++++++++++++++----------------------
>  1 file changed, 48 insertions(+), 50 deletions(-)

From: Manish Narani <manish.narani@xilinx.com>
Date: Thu, 4 Oct 2018 21:05:21 +0530
Subject: [PATCH 2/2] EDAC, synopsys: Correct comments

Spellcheck and improve/correct comments.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Michal Simek <michal.simek@xilinx.com>
CC: amit.kucheria@linaro.org
CC: devicetree@vger.kernel.org
CC: leoyang.li@nxp.com
CC: linux-arm-kernel@lists.infradead.org
CC: linux-edac <linux-edac@vger.kernel.org>
CC: mark.rutland@arm.com
CC: michal.simek@xilinx.com
CC: robh+dt@kernel.org
CC: sudeep.holla@arm.com
Link: http://lkml.kernel.org/r/1538667328-9465-4-git-send-email-manish.narani@xilinx.com
---
 drivers/edac/synopsys_edac.c | 104 +++++++++++++++++------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index fbaf33540ce3..b4666310a5f6 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -96,12 +96,12 @@
 #define SCRUB_MODE_SECDED		0x4
 
 /**
- * struct ecc_error_info - ECC error log information
- * @row:	Row number
- * @col:	Column number
- * @bank:	Bank number
- * @bitpos:	Bit position
- * @data:	Data causing the error
+ * struct ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
  */
 struct ecc_error_info {
 	u32 row;
@@ -112,11 +112,11 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report
- * @ce_cnt:	Correctable error count
- * @ue_cnt:	Uncorrectable error count
- * @ceinfo:	Correctable error log information
- * @ueinfo:	Uncorrectable error log information
+ * struct synps_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
  */
 struct synps_ecc_status {
 	u32 ce_cnt;
@@ -126,12 +126,12 @@ struct synps_ecc_status {
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * struct synps_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ * @ce_cnt:	Correctable Error count.
+ * @ue_cnt:	Uncorrectable Error count.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,13 +142,11 @@ struct synps_edac_priv {
 };
 
 /**
- * get_error_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * get_error_info - Get the current ECC error info.
+ * @base:	Base address of the DDR memory controller.
+ * @p:		Synopsys ECC status structure.
  *
- * Determines there is any ecc error or not
- *
- * Return: one if there is no error otherwise returns zero
+ * Return: one if there is no error otherwise zero.
  */
 static int get_error_info(void __iomem *base, struct synps_ecc_status *p)
 {
@@ -195,11 +193,11 @@ static int get_error_info(void __iomem *base, struct synps_ecc_status *p)
 }
 
 /**
- * handle_error - Handle controller error types CE and UE
- * @mci:	Pointer to the edac memory controller instance
- * @p:		Pointer to the synopsys ecc status structure
+ * handle_error - Handle Correctable and Uncorrectable errors.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Synopsys ECC status structure.
  *
- * Handles the controller ECC correctable and uncorrectable error.
+ * Handles ECC correctable and uncorrectable errors.
  */
 static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 {
@@ -230,10 +228,10 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 }
 
 /**
- * check_errors - Check controller for ECC errors
- * @mci:	Pointer to the edac memory controller instance
+ * check_errors - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
  *
- * Used to check and post ECC errors. Called by the polling thread
+ * Check and post ECC errors. Called by the polling thread.
  */
 static void check_errors(struct mem_ctl_info *mci)
 {
@@ -253,8 +251,8 @@ static void check_errors(struct mem_ctl_info *mci)
 }
 
 /**
- * get_dtype - Return the controller memory width
- * @base:	Pointer to the ddr memory controller base address
+ * get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
@@ -284,12 +282,12 @@ static enum dev_type get_dtype(const void __iomem *base)
 }
 
 /**
- * get_ecc_state - Return the controller ECC enable/disable status
- * @base:	Pointer to the DDR memory controller base address
+ * get_ecc_state - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
  *
- * Get the ECC enable/disable status for the controller.
+ * Get the ECC enable/disable status of the controller.
  *
- * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ * Return: true if enabled, otherwise false.
  */
 static bool get_ecc_state(void __iomem *base)
 {
@@ -309,9 +307,9 @@ static bool get_ecc_state(void __iomem *base)
 }
 
 /**
- * get_memsize - reads the size of the attached memory device
+ * get_memsize - Read the size of the attached memory device.
  *
- * Return: the memory size in bytes
+ * Return: the memory size in bytes.
  */
 static u32 get_memsize(void)
 {
@@ -323,8 +321,8 @@ static u32 get_memsize(void)
 }
 
 /**
- * get_mtype - Returns controller memory type
- * @base:	pointer to the synopsys ecc status structure
+ * get_mtype - Return the controller memory type.
+ * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
@@ -347,11 +345,11 @@ static enum mem_type get_mtype(const void __iomem *base)
 }
 
 /**
- * init_csrows - Initialize the cs row data
- * @mci:	Pointer to the edac memory controller instance
+ * init_csrows - Initialize the csrow data.
+ * @mci:	EDAC memory controller instance.
  *
- * Initializes the chip select rows associated with the EDAC memory
- * controller instance
+ * Initialize the chip select rows associated with the EDAC memory
+ * controller instance.
  *
  * Return: Unconditionally 0.
  */
@@ -381,11 +379,11 @@ static int init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * mc_init - Initialize driver instance
- * @mci:	Pointer to the edac memory controller instance
- * @pdev:	Pointer to the platform_device struct
+ * mc_init - Initialize one driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform device.
  *
- * Performs initialization of the EDAC memory controller instance and
+ * Perform initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
  * instance is bound to.
  *
@@ -421,10 +419,10 @@ static int mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 }
 
 /**
- * mc_probe - Check controller and bind driver
- * @pdev:	Pointer to the platform_device struct
+ * mc_probe - Check controller and bind driver.
+ * @pdev:	platform device.
  *
- * Probes a specific controller instance for binding with the driver.
+ * Probe a specific controller instance for binding with the driver.
  *
  * Return: 0 if the controller instance was successfully bound to the
  * driver; otherwise, < 0 on error.
@@ -493,8 +491,8 @@ static int mc_probe(struct platform_device *pdev)
 }
 
 /**
- * mc_remove - Unbind driver from controller
- * @pdev:	Pointer to the platform_device struct
+ * mc_remove - Unbind driver from controller.
+ * @pdev:	Platform device.
  *
  * Return: Unconditionally 0
  */
-- 
2.19.0.271.gfe8321ec057f

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
