Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7159AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF2320834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF2320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLAMVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:21:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38340 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLAMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:21:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so6900428wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 17:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sk6aZa7aRjvDXgtbV2Iw/anxaNrA4wZaRydRqnBHiPA=;
        b=tE2HlJtSq5RHpQJpLoFrITMnkuy5KdmI0VApSzk5jfbIBjI0KBaYUPCA5i+E4TGtxT
         sYqC4/UKuMUFv5Ycrw2AwTakbCu4q8LXNFX3HFsXOJb6Az29F856x8n9vG6OnSUExUrP
         CzsCcrRZI2VtNKZPSL+gPOoh7ORMHuuAFx3UHeioC449VuE1YYuDKexhOoD7JWMgBMQa
         Wqb++8faP1noQjv6IjcEllmIqEYnCXqARd0IE9G50660ZksJORECVLgFpI6mEdQJvEIP
         LgW0eEPOk4CzRgk/rOGKtFnhus76lzWrqfzW7erHBRAATRGi2VikEkCKp7MrtLjAmYfE
         Dluw==
X-Gm-Message-State: AA+aEWYS4n8FXhDQsxD2keeotRGTDQWhHI0RhiXIpTj2HKqhNffLdh2O
        k12vK2+taaxL0PatLIn3s+E0FfNoxcQ=
X-Google-Smtp-Source: AFSGD/WlAkD/1NbkLqjKVGOaR45v0q+6tSpM+V2luMiuKCTdptcbSOm6p8jIFxFaUvYxnQ11yfZspA==
X-Received: by 2002:adf:82a8:: with SMTP id 37mr6343267wrc.252.1543626638141;
        Fri, 30 Nov 2018 17:10:38 -0800 (PST)
Received: from raver.teknoraver.net (net-93-66-170-114.cust.vodafonedsl.it. [93.66.170.114])
        by smtp.gmail.com with ESMTPSA id l13sm1622047wmb.27.2018.11.30.17.10.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 17:10:37 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] treewide: fix spelling mistake: "lenght" -> "length"
Date:   Sat,  1 Dec 2018 02:10:36 +0100
Message-Id: <20181201011036.28991-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Really not a big issue, but can be irritating when searching for the
"length" word can't find the code you're looking for.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 Documentation/devicetree/bindings/usb/s3c2410-usb.txt       | 2 +-
 arch/powerpc/include/asm/hvsi.h                             | 2 +-
 block/blk-core.c                                            | 2 +-
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
 tools/perf/util/hist.c                                      | 2 +-
 20 files changed, 21 insertions(+), 21 deletions(-)

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
diff --git a/block/blk-core.c b/block/blk-core.c
index deb56932f8c4..17ec34eb389a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -653,7 +653,7 @@ void blk_queue_bypass_start(struct request_queue *q)
 
 	/*
 	 * Queues start drained.  Skip actual draining till init is
-	 * complete.  This avoids lenghty delays during queue init which
+	 * complete.  This avoids lengthy delays during queue init which
 	 * can happen many times during boot.
 	 */
 	if (blk_queue_init_done(q)) {
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
index 9095b830ae4d..aff88ec9c1d7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -46,7 +46,7 @@ enum nvram_parser_state {
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
index 67718b0f978d..d58d4f88d041 100644
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
index 34d311a7dbef..eb61b000b826 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -3967,7 +3967,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
  * lpfc_idiag_drbacc_read_reg - idiag debugfs read a doorbell register
  * @phba: The pointer to hba structure.
  * @pbuffer: The pointer to the buffer to copy the data to.
- * @len: The lenght of bytes to copied.
+ * @len: The length of bytes to copied.
  * @drbregid: The id to doorbell registers.
  *
  * Description:
@@ -4177,7 +4177,7 @@ lpfc_idiag_drbacc_write(struct file *file, const char __user *buf,
  * lpfc_idiag_ctlacc_read_reg - idiag debugfs read a control registers
  * @phba: The pointer to hba structure.
  * @pbuffer: The pointer to the buffer to copy the data to.
- * @len: The lenght of bytes to copied.
+ * @len: The length of bytes to copied.
  * @drbregid: The id to doorbell registers.
  *
  * Description:
diff --git a/drivers/staging/comedi/drivers/usbduxfast.c b/drivers/staging/comedi/drivers/usbduxfast.c
index e18c0723b760..b91fe9fe1bdb 100644
--- a/drivers/staging/comedi/drivers/usbduxfast.c
+++ b/drivers/staging/comedi/drivers/usbduxfast.c
@@ -61,7 +61,7 @@
 #define USBDUXFASTSUB_CPUCS	0xE600
 
 /*
- * max lenghth of the transfer-buffer for software upload
+ * max lengthh of the transfer-buffer for software upload
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
index 1fa41b7a1be3..00dfc1db0cde 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5320,7 +5320,7 @@ void cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
  * @dev: network device
  * @macaddr: the MAC address of the new candidate
  * @ie: information elements advertised by the peer candidate
- * @ie_len: lenght of the information elements buffer
+ * @ie_len: length of the information elements buffer
  * @gfp: allocation flags
  *
  * This function notifies cfg80211 that the mesh peer candidate has been
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e4e454..8106bae68388 100644
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
index e1cfa846a1dc..33cf0f1a9946 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1189,7 +1189,7 @@ EXPORT_SYMBOL_GPL(q6asm_open_read);
  * q6asm_write_async() - non blocking write
  *
  * @ac: audio client pointer
- * @len: lenght in bytes
+ * @len: length in bytes
  * @msw_ts: timestamp msw
  * @lsw_ts: timestamp lsw
  * @wflags: flags associated with write
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 828cb9794c76..8aad8330e392 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1160,7 +1160,7 @@ void hist_entry__delete(struct hist_entry *he)
 
 /*
  * If this is not the last column, then we need to pad it according to the
- * pre-calculated max lenght for this column, otherwise don't bother adding
+ * pre-calculated max length for this column, otherwise don't bother adding
  * spaces because that would break viewing this with, for instance, 'less',
  * that would show tons of trailing spaces when a long C++ demangled method
  * names is sampled.
-- 
2.19.1

