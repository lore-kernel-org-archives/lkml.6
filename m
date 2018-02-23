Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeBWGls (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:41:48 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32923 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeBWGlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:41:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180223064140epoutp0141188c63ac955a2228d566e7502aa309~V4TzhOotJ3123231232epoutp01D
X-AuditID: b6c32a47-19fff7000000100c-8e-5a8fb7a489aa
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        manabian@gmail.com, dinguyen@kernel.org, will.deacon@arm.com,
        xuwei5@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/6] mmc: dw_mmc: remove the deprecated "clock-freq-min-max"
 property
Date: Fri, 23 Feb 2018 15:41:33 +0900
Message-id: <20180223064138.18401-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.15.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7bCmue6S7f1RBpsPKFrMP3KO1eLo+d1M
        Fjd+tbFaXN41h83iyP9+Rovd188xWiy9fpHJonXvEXaL42vDLV5+PMFi8eToFGYHbo8189Yw
        euycdZfd4/Hcjewem1Z1snncubaHzaNvyypGj8+b5ALYo1JtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKkUbGhrpGRqY6xkZGemZGMdaGZkClSSkZky5G1fQK1qx5P10xgbGtYJdjJwcEgImEm2L
        v7F1MXJxCAnsYJTY2fidFcL5zihx5VUfO0zVtR9TmSESGxgljp/+DOX8YJSYdW86C0gVm4CO
        xPZvx5lAbBGBSIn5qw6DFTELHGGUuPzwNpDDwSEsEC6x8GMNSA2LgKrEy81LWEFsXgFriffz
        5kNtk5eYsKWJBaRXQmABm8SbP6vYQHolBFwkNlzggqgRlnh1fAtUvbTEs1UbGSHsdkaJs7OF
        IXqnMEqsmNHNBJEwlni2sAvMZhbgk+g4/JcdYiavREebEESJh8SXtqUsEGFHiTXHwcYLCcRK
        3Puyj3kCo+QCRoZVjGKpBcW56anFRgXGesWJucWleel6yfm5mxjBiUbLfQfjtnM+hxgFOBiV
        eHgjSnqjhFgTy4orcw8xSnAwK4nwOqzqjxLiTUmsrEotyo8vKs1JLT7EaAoMjYnMUqLJ+cAk
        mFcSb2hiaWBiZmZkbmYBjH9x3tYAlyghgfTEktTs1NSC1CKYPiYOTqkGxlJdZsUVEq/W5f2Q
        kc1X01SukBbImRlyYGHkvX9sz3/zsfdsOSE8dVXUrucCUn/8XbYl3btnskKgsfOhofClh0In
        FFSj7DeFCm+wS3l1gVXM0W/Bga8mqwJ/RYnXPDLsPSKyLErZUlvLY/eK0/Frnr/h6dRPlX/K
        pKLb9ldwceaLQ1f9sk1LlViKMxINtZiLihMBaEnf0EoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsVy+t9jQd0l2/ujDD6vYLSYf+Qcq8XR87uZ
        LG78amO1uLxrDpvFkf/9jBa7r59jtFh6/SKTReveI+wWx9eGW7z8eILF4snRKcwO3B5r5q1h
        9Ng56y67x+O5G9k9Nq3qZPO4c20Pm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlTLkbV9Ar
        WrHk/XTGBsa1gl2MnBwSAiYS135MZe5i5OIQEljHKNE76wYLhPODUeJsawsTSBWbgI7E9m/H
        wWwRgUiJA7+nMIEUMQscYZTYuWEqkMPBISwQLrHwYw1IDYuAqsTLzUtYQWxeAWuJ9/Pms0Ns
        k5eYsKWJZQIj1wJGhlWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIHhtO2wVv8OxsdL
        4g8xCnAwKvHwRpT0RgmxJpYVV+YeYpTgYFYS4XVY1R8lxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgdF2xrNIG5ES96o835ovWqcnrGavexNxrXZOuey1
        DTd9bc6v993qtffwRO7zjjvT2jjc5LR99shU7uC80DlxE0/lzdfl/CWz9hivfe9T9//4wv2t
        6wxvTljc9DHi5ueLpRvdZjXo2t2Osiq6XfbNtzMgevnVOtmAxz5aW37rrDI1OOly3P3k80NK
        LMUZiYZazEXFiQBSou8VIwIAAA==
X-CMS-MailID: 20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342
X-RootMTR: 20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clock-freq-min-max' property had already deprecated.
Remove the 'clock-freq-min-max' property that is kept to maintain
the compatibility.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt          |  4 ----
 drivers/mmc/host/dw_mmc.c                                 | 15 ++++-----------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index ef3e5f14067a..75c9fdca4aaf 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -59,10 +59,6 @@ Optional properties:
   is specified and the ciu clock is specified then we'll try to set the ciu
   clock to this at probe time.
 
-* clock-freq-min-max (DEPRECATED): Minimum and Maximum clock frequency for card output
-  clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
-	  (Use the "max-frequency" instead of "clock-freq-min-max".)
-
 * num-slots (DEPRECATED): specifies the number of slots supported by the controller.
   The number of physical slots actually used could be equal or less than the
   value specified by num-slots. If this property is not specified, the value
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0aa39975f33b..38e0e7c4ffd9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2784,7 +2784,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	struct dw_mci_slot *slot;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int ctrl_id, ret;
-	u32 freq[2];
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
 	if (!mmc)
@@ -2798,16 +2797,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	host->slot = slot;
 
 	mmc->ops = &dw_mci_ops;
-	if (device_property_read_u32_array(host->dev, "clock-freq-min-max",
-					   freq, 2)) {
-		mmc->f_min = DW_MCI_FREQ_MIN;
-		mmc->f_max = DW_MCI_FREQ_MAX;
-	} else {
-		dev_info(host->dev,
-			"'clock-freq-min-max' property was deprecated.\n");
-		mmc->f_min = freq[0];
-		mmc->f_max = freq[1];
-	}
 
 	/*if there are external regulators, get them*/
 	ret = mmc_regulator_get_supply(mmc);
@@ -2846,6 +2835,10 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (ret)
 		goto err_host_allocated;
 
+	mmc->f_min = DW_MCI_FREQ_MIN;
+	if (!mmc->f_max)
+		mmc->f_max = DW_MCI_FREQ_MAX;
+
 	/* Process SDIO IRQs through the sdio_irq_work. */
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
-- 
2.15.1
