Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B546CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A9B2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A9B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJEDao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:30:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58990 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJEDao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:30:44 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XxIO0wab0WWM; Thu,  4 Oct 2018 22:35:46 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C21CF1EC032D;
        Thu,  4 Oct 2018 22:35:45 +0200 (CEST)
Date:   Thu, 4 Oct 2018 22:35:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        mchehab@kernel.org, sudeep.holla@arm.com, amit.kucheria@linaro.org,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v8 02/10] edac: synopsys: Rename the static functions to
 a shorter name
Message-ID: <20181004203540.GD5149@zn.tnic>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
 <1538667328-9465-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1538667328-9465-3-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:05:20PM +0530, Manish Narani wrote:
> Rename the static functions to a shorter name. Since this is Synopsys
> EDAC driver, better to remove unnecessary 'synps_' prefix in function
> names.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 56 ++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)

Ok, let's flip the roles - now you get to review what I've committed:

---
From: Manish Narani <manish.narani@xilinx.com>
Date: Thu, 4 Oct 2018 21:05:20 +0530
Subject: [PATCH 1/2] EDAC, synopsys: Shorten static function names

Shorten static function names, remove the unnecessary 'synps_' prefix in
function names.

 [ bp: Drop the "edac_" prefix too as that prefix is reserved for
   EDAC core functions. ]

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
CC: robh+dt@kernel.org
CC: sudeep.holla@arm.com
Link: http://lkml.kernel.org/r/1538667328-9465-3-git-send-email-manish.narani@xilinx.com
---
 drivers/edac/synopsys_edac.c | 79 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1936c73f1d15..fbaf33540ce3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -142,7 +142,7 @@ struct synps_edac_priv {
 };
 
 /**
- * synps_edac_geterror_info - Get the current ecc error info
+ * get_error_info - Get the current ecc error info
  * @base:	Pointer to the base address of the ddr memory controller
  * @p:		Pointer to the synopsys ecc status structure
  *
@@ -150,8 +150,7 @@ struct synps_edac_priv {
  *
  * Return: one if there is no error otherwise returns zero
  */
-static int synps_edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int get_error_info(void __iomem *base, struct synps_ecc_status *p)
 {
 	u32 regval, clearval = 0;
 
@@ -196,14 +195,13 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
- * synps_edac_handle_error - Handle controller error types CE and UE
+ * handle_error - Handle controller error types CE and UE
  * @mci:	Pointer to the edac memory controller instance
  * @p:		Pointer to the synopsys ecc status structure
  *
- * Handles the controller ECC correctable and un correctable error.
+ * Handles the controller ECC correctable and uncorrectable error.
  */
-static void synps_edac_handle_error(struct mem_ctl_info *mci,
-				    struct synps_ecc_status *p)
+static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	struct ecc_error_info *pinf;
@@ -232,30 +230,30 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_check - Check controller for ECC errors
+ * check_errors - Check controller for ECC errors
  * @mci:	Pointer to the edac memory controller instance
  *
  * Used to check and post ECC errors. Called by the polling thread
  */
-static void synps_edac_check(struct mem_ctl_info *mci)
+static void check_errors(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = get_error_info(priv->baseaddr, &priv->stat);
 	if (status)
 		return;
 
 	priv->ce_cnt += priv->stat.ce_cnt;
 	priv->ue_cnt += priv->stat.ue_cnt;
-	synps_edac_handle_error(mci, &priv->stat);
+	handle_error(mci, &priv->stat);
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
- * synps_edac_get_dtype - Return the controller memory width
+ * get_dtype - Return the controller memory width
  * @base:	Pointer to the ddr memory controller base address
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -263,7 +261,7 @@ static void synps_edac_check(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_edac_get_dtype(const void __iomem *base)
+static enum dev_type get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -286,20 +284,20 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_get_eccstate - Return the controller ecc enable/disable status
- * @base:	Pointer to the ddr memory controller base address
+ * get_ecc_state - Return the controller ECC enable/disable status
+ * @base:	Pointer to the DDR memory controller base address
  *
- * Get the ECC enable/disable status for the controller
+ * Get the ECC enable/disable status for the controller.
  *
- * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_edac_get_eccstate(void __iomem *base)
+static bool get_ecc_state(void __iomem *base)
 {
 	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
-	dt = synps_edac_get_dtype(base);
+	dt = get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -311,11 +309,11 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * synps_edac_get_memsize - reads the size of the attached memory device
+ * get_memsize - reads the size of the attached memory device
  *
  * Return: the memory size in bytes
  */
-static u32 synps_edac_get_memsize(void)
+static u32 get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -325,7 +323,7 @@ static u32 synps_edac_get_memsize(void)
 }
 
 /**
- * synps_edac_get_mtype - Returns controller memory type
+ * get_mtype - Returns controller memory type
  * @base:	pointer to the synopsys ecc status structure
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -333,7 +331,7 @@ static u32 synps_edac_get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_edac_get_mtype(const void __iomem *base)
+static enum mem_type get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -349,7 +347,7 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_init_csrows - Initialize the cs row data
+ * init_csrows - Initialize the cs row data
  * @mci:	Pointer to the edac memory controller instance
  *
  * Initializes the chip select rows associated with the EDAC memory
@@ -357,7 +355,7 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
  *
  * Return: Unconditionally 0.
  */
-static int synps_edac_init_csrows(struct mem_ctl_info *mci)
+static int init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
@@ -367,15 +365,15 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = synps_edac_get_memsize();
+		size = get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= synps_edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= synps_edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -383,7 +381,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * synps_edac_mc_init - Initialize driver instance
+ * mc_init - Initialize driver instance
  * @mci:	Pointer to the edac memory controller instance
  * @pdev:	Pointer to the platform_device struct
  *
@@ -393,8 +391,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
  *
  * Return: Always zero.
  */
-static int synps_edac_mc_init(struct mem_ctl_info *mci,
-				 struct platform_device *pdev)
+static int mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
 	int status;
 	struct synps_edac_priv *priv;
@@ -415,16 +412,16 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	mci->edac_check = check_errors;
 	mci->ctl_page_to_phys = NULL;
 
-	status = synps_edac_init_csrows(mci);
+	status = init_csrows(mci);
 
 	return status;
 }
 
 /**
- * synps_edac_mc_probe - Check controller and bind driver
+ * mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
  *
  * Probes a specific controller instance for binding with the driver.
@@ -432,7 +429,7 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
  * Return: 0 if the controller instance was successfully bound to the
  * driver; otherwise, < 0 on error.
  */
-static int synps_edac_mc_probe(struct platform_device *pdev)
+static int mc_probe(struct platform_device *pdev)
 {
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
@@ -446,7 +443,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	if (!get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,7 +465,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = synps_edac_mc_init(mci, pdev);
+	rc = mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Failed to initialize instance\n");
@@ -496,12 +493,12 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 }
 
 /**
- * synps_edac_mc_remove - Unbind driver from controller
+ * mc_remove - Unbind driver from controller
  * @pdev:	Pointer to the platform_device struct
  *
  * Return: Unconditionally 0
  */
-static int synps_edac_mc_remove(struct platform_device *pdev)
+static int mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
@@ -523,8 +520,8 @@ static struct platform_driver synps_edac_mc_driver = {
 		   .name = "synopsys-edac",
 		   .of_match_table = synps_edac_match,
 		   },
-	.probe = synps_edac_mc_probe,
-	.remove = synps_edac_mc_remove,
+	.probe = mc_probe,
+	.remove = mc_remove,
 };
 
 module_platform_driver(synps_edac_mc_driver);
-- 
2.19.0.271.gfe8321ec057f

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
