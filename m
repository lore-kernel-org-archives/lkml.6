Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA4D208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA4D208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeH0TXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:23:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:43666 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH0TXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:23:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 08:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="258408437"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2018 08:35:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9218D139; Mon, 27 Aug 2018 18:35:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] extcon: cht-wc: Fix definition names according to spec
Date:   Mon, 27 Aug 2018 18:35:54 +0300
Message-Id: <20180827153557.58363-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
References: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no suffix MASK in the spec and other small spelling fixes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index bdb67878179e..71b1126dbb0b 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -32,10 +32,10 @@
 #define CHT_WC_CHGRCTRL0_EMRGCHREN	BIT(1)
 #define CHT_WC_CHGRCTRL0_EXTCHRDIS	BIT(2)
 #define CHT_WC_CHGRCTRL0_SWCONTROL	BIT(3)
-#define CHT_WC_CHGRCTRL0_TTLCK_MASK	BIT(4)
-#define CHT_WC_CHGRCTRL0_CCSM_OFF_MASK	BIT(5)
-#define CHT_WC_CHGRCTRL0_DBPOFF_MASK	BIT(6)
-#define CHT_WC_CHGRCTRL0_WDT_NOKICK	BIT(7)
+#define CHT_WC_CHGRCTRL0_TTLCK		BIT(4)
+#define CHT_WC_CHGRCTRL0_CCSM_OFF	BIT(5)
+#define CHT_WC_CHGRCTRL0_DBPOFF		BIT(6)
+#define CHT_WC_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
 
 #define CHT_WC_CHGRCTRL1		0x5e17
 
@@ -52,7 +52,7 @@
 #define CHT_WC_USBSRC_TYPE_ACA		4
 #define CHT_WC_USBSRC_TYPE_SE1		5
 #define CHT_WC_USBSRC_TYPE_MHL		6
-#define CHT_WC_USBSRC_TYPE_FLOAT_DP_DN	7
+#define CHT_WC_USBSRC_TYPE_FLOATING	7
 #define CHT_WC_USBSRC_TYPE_OTHER	8
 #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
 
@@ -61,7 +61,7 @@
 #define CHT_WC_PWRSRC_STS		0x6e1e
 #define CHT_WC_PWRSRC_VBUS		BIT(0)
 #define CHT_WC_PWRSRC_DC		BIT(1)
-#define CHT_WC_PWRSRC_BAT		BIT(2)
+#define CHT_WC_PWRSRC_BATT		BIT(2)
 #define CHT_WC_PWRSRC_ID_GND		BIT(3)
 #define CHT_WC_PWRSRC_ID_FLOAT		BIT(4)
 
@@ -158,7 +158,7 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
 			 ret);
 		return EXTCON_CHG_USB_SDP;
 	case CHT_WC_USBSRC_TYPE_SDP:
-	case CHT_WC_USBSRC_TYPE_FLOAT_DP_DN:
+	case CHT_WC_USBSRC_TYPE_FLOATING:
 	case CHT_WC_USBSRC_TYPE_OTHER:
 		return EXTCON_CHG_USB_SDP;
 	case CHT_WC_USBSRC_TYPE_CDP:
@@ -279,7 +279,7 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
 {
 	int ret, mask, val;
 
-	mask = CHT_WC_CHGRCTRL0_SWCONTROL | CHT_WC_CHGRCTRL0_CCSM_OFF_MASK;
+	mask = CHT_WC_CHGRCTRL0_SWCONTROL | CHT_WC_CHGRCTRL0_CCSM_OFF;
 	val = enable ? mask : 0;
 	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGRCTRL0, mask, val);
 	if (ret)
-- 
2.18.0

