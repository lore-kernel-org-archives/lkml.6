Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37167C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F3D208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfADLu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:50:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfADLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:50:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so36368017wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 03:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBa4O8HH25rKQTAYFmi4qprAZBsz+M8QP/oL2TqoGis=;
        b=WQa/YaSkb3pGZIspsN8XsZqeewDojLVS2Tqw9IyA8ttfm3W1QK8UHX2m2NdrV5aUIB
         pNn74JExVe2B48JH3FmDDWbYvzoEEgiEFCc8KYITHuui95oDw4Bm//yiLzFKAyqi/brK
         4UhGuqCLe1hhIACeMfta4i5vU1r7uyXj1ry1ruUyktP7jprXhzREUTSUYJwUcnJf/U35
         OjfXQu/1Cx1YICn7C+SEw55yZjXtP0E5xp1ygFhO04iSLE9Us7n9l0WFifCVHO+NXXQ/
         lydr6k5eIdKi0vVCz0Wpb2Oxcq8HHl5O6VD607u2hm3/ouIFQ8tAd6+0oYSnqWb8VAuL
         K8uQ==
X-Gm-Message-State: AJcUukdlBkDAMtxFlCGq3MWHkRCrbqgi5qkfQmNfiqqIQw9zPr8vI/Av
        8tIaw4OozVUaecAdIlxz6mizr6eJpYs=
X-Google-Smtp-Source: ALg8bN5ArPcYkhm7nji+3JbbScXCax1m+gQTRgoVoqEia2vEuRvHym/4Jj5vbpRAo9bkq/EKsWRPog==
X-Received: by 2002:adf:e891:: with SMTP id d17mr47441715wrm.140.1546602625161;
        Fri, 04 Jan 2019 03:50:25 -0800 (PST)
Received: from mcroce-redhat.redhat.com (host177-2-dynamic.16-87-r.retail.telecomitalia.it. [87.16.2.177])
        by smtp.gmail.com with ESMTPSA id j24sm49045909wrd.86.2019.01.04.03.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 03:50:23 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] treewide: fix spelling mistake: "lenght" -> "length"
Date:   Fri,  4 Jan 2019 12:50:22 +0100
Message-Id: <20190104115022.13553-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not a big issue, but can be annoying when searching for the "length"
keyword can't find the right code.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 Documentation/devicetree/bindings/usb/s3c2410-usb.txt       | 2 +-
 arch/powerpc/include/asm/hvsi.h                             | 2 +-
 drivers/clk/samsung/clk.h                                   | 2 +-
 drivers/gpu/drm/amd/include/atombios.h                      | 2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c                    | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h     | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h     | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c      | 2 +-
 drivers/pinctrl/pinctrl-amd.c                               | 2 +-
 drivers/scsi/be2iscsi/be_cmds.c                             | 2 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                            | 4 ++--
 drivers/staging/comedi/drivers/usbduxfast.c                 | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c                    | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c           | 2 +-
 include/net/cfg80211.h                                      | 2 +-
 kernel/sysctl.c                                             | 2 +-
 sound/soc/qcom/qdsp6/q6asm.c                                | 2 +-
 18 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
index e45b38ce2986..26c85afd0b53 100644
--- a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
+++ b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
@@ -4,7 +4,7 @@ OHCI
 
 Required properties:
  - compatible: should be "samsung,s3c2410-ohci" for USB host controller
- - reg: address and lenght of the controller memory mapped region
+ - reg: address and length of the controller memory mapped region
  - interrupts: interrupt number for the USB OHCI controller
  - clocks: Should reference the bus and host clocks
  - clock-names: Should contain two strings
diff --git a/arch/powerpc/include/asm/hvsi.h b/arch/powerpc/include/asm/hvsi.h
index 3fdc54df63c9..464a7519ed64 100644
--- a/arch/powerpc/include/asm/hvsi.h
+++ b/arch/powerpc/include/asm/hvsi.h
@@ -64,7 +64,7 @@ struct hvsi_priv {
 	unsigned int	inbuf_len;	/* data in input buffer */
 	unsigned char	inbuf[HVSI_INBUF_SIZE];
 	unsigned int	inbuf_cur;	/* Cursor in input buffer */
-	unsigned int	inbuf_pktlen;	/* packet lenght from cursor */
+	unsigned int	inbuf_pktlen;	/* packet length from cursor */
 	atomic_t	seqno;		/* packet sequence number */
 	unsigned int	opened:1;	/* driver opened */
 	unsigned int	established:1;	/* protocol established */
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index c3f309d7100d..9cfaca5fbcdb 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -26,7 +26,7 @@ struct samsung_clk_provider {
 	void __iomem *reg_base;
 	struct device *dev;
 	spinlock_t lock;
-	/* clk_data must be the last entry due to variable lenght 'hws' array */
+	/* clk_data must be the last entry due to variable length 'hws' array */
 	struct clk_hw_onecell_data clk_data;
 };
 
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 7931502fa54f..8ba21747b40a 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4106,7 +4106,7 @@ typedef struct  _ATOM_LCD_MODE_CONTROL_CAP
 typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
 {
   UCHAR ucRecordType;
-  UCHAR ucFakeEDIDLength;       // = 128 means EDID lenght is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
+  UCHAR ucFakeEDIDLength;       // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
   UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
 } ATOM_FAKE_EDID_PATCH_RECORD;
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
index 813ba42f2753..e384b95ad857 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
@@ -708,7 +708,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	else
 		acore.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
 	/*
-	 * The I2S input word length is twice the lenght given in the IEC-60958
+	 * The I2S input word length is twice the length given in the IEC-60958
 	 * status word. If the word size is greater than
 	 * 20 bits, increment by one.
 	 */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index dcf6e27cc16f..d8085ce579f4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -36,7 +36,7 @@
 #define BRCMF_DCMD_MEDLEN	1536
 #define BRCMF_DCMD_MAXLEN	8192
 
-/* IOCTL from host to device are limited in lenght. A device can only handle
+/* IOCTL from host to device are limited in length. A device can only handle
  * ethernet frame size. This limitation is to be applied by protocol layer.
  */
 #define BRCMF_TX_IOCTL_MAX_MSG_SIZE	(ETH_FRAME_LEN+ETH_FCS_LEN)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 14b948917a1a..cf1ddf988476 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -47,7 +47,7 @@ enum nvram_parser_state {
  * @state: current parser state.
  * @data: input buffer being parsed.
  * @nvram: output buffer with parse result.
- * @nvram_len: lenght of parse result.
+ * @nvram_len: length of parse result.
  * @line: current line.
  * @column: current column in line.
  * @pos: byte offset in input buffer.
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
index 816f80ea925b..31f3e8e83a21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
@@ -266,7 +266,7 @@ struct brcmf_event {
  * @status: status information.
  * @reason: reason code.
  * @auth_type: authentication type.
- * @datalen: lenght of event data buffer.
+ * @datalen: length of event data buffer.
  * @addr: ether address.
  * @ifname: interface name.
  * @ifidx: interface index.
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index a4308c6e72d7..0b7d977510c8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -508,7 +508,7 @@ static void brcmf_usb_rx_complete(struct urb *urb)
 	skb = req->skb;
 	req->skb = NULL;
 
-	/* zero lenght packets indicate usb "failure". Do not refill */
+	/* zero length packets indicate usb "failure". Do not refill */
 	if (urb->status != 0 || !urb->actual_length) {
 		brcmu_pkt_buf_free_skb(skb);
 		brcmf_usb_enq(devinfo, &devinfo->rx_freeq, req, NULL);
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 2a7d638978d8..6689995fa3aa 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -489,7 +489,7 @@ static int amd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	/*
 	 * If WAKE_INT_MASTER_REG.MaskStsEn is set, a software write to the
 	 * debounce registers of any GPIO will block wake/interrupt status
-	 * generation for *all* GPIOs for a lenght of time that depends on
+	 * generation for *all* GPIOs for a length of time that depends on
 	 * WAKE_INT_MASTER_REG.MaskStsLength[11:0].  During this period the
 	 * INTERRUPT_ENABLE bit will read as 0.
 	 *
diff --git a/drivers/scsi/be2iscsi/be_cmds.c b/drivers/scsi/be2iscsi/be_cmds.c
index 0a6972ee94d7..ea042c1fc70d 100644
--- a/drivers/scsi/be2iscsi/be_cmds.c
+++ b/drivers/scsi/be2iscsi/be_cmds.c
@@ -963,7 +963,7 @@ int beiscsi_cmd_q_destroy(struct be_ctrl_info *ctrl, struct be_queue_info *q,
  * @ctrl: ptr to ctrl_info
  * @cq: Completion Queue
  * @dq: Default Queue
- * @lenght: ring size
+ * @length: ring size
  * @entry_size: size of each entry in DEFQ
  * @is_header: Header or Data DEFQ
  * @ulp_num: Bind to which ULP
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index a58f0b3f03a9..ab18b83289ff 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -3969,7 +3969,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
  * lpfc_idiag_drbacc_read_reg - idiag debugfs read a doorbell register
  * @phba: The pointer to hba structure.
  * @pbuffer: The pointer to the buffer to copy the data to.
- * @len: The lenght of bytes to copied.
+ * @len: The length of bytes to copied.
  * @drbregid: The id to doorbell registers.
  *
  * Description:
@@ -4179,7 +4179,7 @@ lpfc_idiag_drbacc_write(struct file *file, const char __user *buf,
  * lpfc_idiag_ctlacc_read_reg - idiag debugfs read a control registers
  * @phba: The pointer to hba structure.
  * @pbuffer: The pointer to the buffer to copy the data to.
- * @len: The lenght of bytes to copied.
+ * @len: The length of bytes to copied.
  * @drbregid: The id to doorbell registers.
  *
  * Description:
diff --git a/drivers/staging/comedi/drivers/usbduxfast.c b/drivers/staging/comedi/drivers/usbduxfast.c
index e18c0723b760..0d54f394dbd2 100644
--- a/drivers/staging/comedi/drivers/usbduxfast.c
+++ b/drivers/staging/comedi/drivers/usbduxfast.c
@@ -61,7 +61,7 @@
 #define USBDUXFASTSUB_CPUCS	0xE600
 
 /*
- * max lenghth of the transfer-buffer for software upload
+ * max length of the transfer-buffer for software upload
  */
 #define TB_LEN	0x2000
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 4a28e3fbeb0b..83340f4fdc6e 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -120,7 +120,7 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
 	/* No current DMA ongoing */
 	req->active = false;
 
-	/* Grab lenght out of HW */
+	/* Grab length out of HW */
 	len = VHUB_EP_DMA_TX_SIZE(stat);
 
 	/* If not using DMA, copy data out if needed */
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
index fa72e735dad2..d146793dd044 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
@@ -712,7 +712,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	else
 		acore.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
 	/*
-	 * The I2S input word length is twice the lenght given in the IEC-60958
+	 * The I2S input word length is twice the length given in the IEC-60958
 	 * status word. If the word size is greater than
 	 * 20 bits, increment by one.
 	 */
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e0c41eb1c860..237839210a36 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5568,7 +5568,7 @@ void cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
  * @dev: network device
  * @macaddr: the MAC address of the new candidate
  * @ie: information elements advertised by the peer candidate
- * @ie_len: lenght of the information elements buffer
+ * @ie_len: length of the information elements buffer
  * @gfp: allocation flags
  *
  * This function notifies cfg80211 that the mesh peer candidate has been
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1825f712e73b..6b2691f5d4c9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -191,7 +191,7 @@ extern int no_unaligned_warning;
  * 	file position 0 and the value must be fully contained in the buffer
  * 	sent to the write syscall. If dealing with strings respect the file
  * 	position, but restrict this to the max length of the buffer, anything
- * 	passed the max lenght will be ignored. Multiple writes will append
+ * 	passed the max length will be ignored. Multiple writes will append
  * 	to the buffer.
  *
  * These write modes control how current file position affects the behavior of
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 4f85cb19a309..e8141a33a55e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1194,7 +1194,7 @@ EXPORT_SYMBOL_GPL(q6asm_open_read);
  * q6asm_write_async() - non blocking write
  *
  * @ac: audio client pointer
- * @len: lenght in bytes
+ * @len: length in bytes
  * @msw_ts: timestamp msw
  * @lsw_ts: timestamp lsw
  * @wflags: flags associated with write
-- 
2.20.1

