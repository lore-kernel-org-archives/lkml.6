Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeBWGlu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:41:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32933 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeBWGlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:41:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180223064141epoutp0187f66e29ebcb447520c1639dbad28834~V4Tzu4Qj93189731897epoutp01T
X-AuditID: b6c32a45-403ff70000001023-81-5a8fb7a49d78
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        manabian@gmail.com, dinguyen@kernel.org, will.deacon@arm.com,
        xuwei5@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/6] mmc: dw_mmc: remove the deprecated "num-slots"
Date: Fri, 23 Feb 2018 15:41:34 +0900
Message-id: <20180223064138.18401-2-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.15.1
In-reply-to: <20180223064138.18401-1-jh80.chung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTYRTGe3fndq1mt6n1tqLWxYIsl3c6vZqKlsUqCcvIWqRd9EUtt8nu
        Zk36wyxtTvIDBMU0jT65GKRZrsyKOdPKtLKakIWhiUVEJmpUZtuu/vc7z/s8h3NeDo5JHV4y
        PEtnRAYdk02KFgrvdmwID7rSWqYJruhW0PWOXi+6s69NQA/8LvKi++/XimjHbBmg25y9gL7q
        fCWgC9sdYrrrZjL9ZbxbSI90VmKxi9SNFxuB+l7NB7F6uK5JrG7mikXqwXcPROrSFg6oJ5pX
        J4o1KCoTMenIIEe6NH16li4jmtydlLotVRUWTAVREXQ4KdcxWhRNxickBu3IynbNSMpzmWyT
        S0pkWJbcHBNl0JuMSJ6pZ43R5GGKUiqo4HCFUqlUhIYciVSqXJajKPOKk8jpWXFyaqREmA+c
        flaA45AIhVVF661gIS4lbABOnrkG+GIawNqH1eJ5U80bOa/fAvDnZwfGF78ArPlYJbQCb1xE
        bIKtU10CN/sRh2A91+ExYYQDwP5P7zH3gy+xDQ53j4ndLCTWwdslBcDNEmILLL086dEhsQaW
        txR4mnoTUbD875jQ3QgSNhF8fKdewJvi4cD1KSHPvvBrV8tceCUc5ZoAz+cAfHHBlw9XAnij
        umQuHAJHL1k9jBE+0NIxM7enBFqKpLxFDU9/4DBejoOvB+L5jcsAtPx7AsqBrAEs4MAylMNq
        MxCrzKEULKNlTboMRZpe2ww8FxS43QaqexPsgMABuVhy0HheI/Viclmz1g4gjpF+kliuTCOV
        pDPmPGTQpxpM2Yi1A5XrbyowmX+a3nWPOmMqFRoRHBoWpgwPo13HsFxSlBivkRIZjBEdRygH
        GeZzAtxblg+UfZVnS/Psbx+JCvJLUuxUedTWp4Zb3N72YutQ2x5b4IExk//Nh47e/SoJeaxw
        lW1iaVzDsywz7Hhuax0NaLTEtCWRa6enVbteWnxP1MmSZ76ZzZF/9o0Pbhz6jipnO5tqOv0C
        QODlJT8qhvJOjcXY249YfKyDfVzrcI+za2cKKWQzGSoQM7DMf/JdINNXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t9jQd0l2/ujDL4e5rCYf+Qcq8XR87uZ
        LG78amO1uLxrDpvFkf/9jBa7r59jtFh6/SKTReveI+wWx9eGW7z8eILF4snRKcwO3B5r5q1h
        9Ng56y67x+O5G9k9Nq3qZPO4c20Pm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlLLkuUHBG
        suLbk26WBsbrIl2MHBwSAiYSs64odDFycggJrGOUaNit0cXIBWT/YJQ429rCBJJgE9CR2P7t
        OJgtIhApceD3FCaQImaBI4wSOzdMBUsICzhLPD7xgh3EZhFQldjc3cQIYvMKWEv0Lf4KFpcQ
        kJeYsKWJBcTmFLCRmPDnBQvEZmuJd+d/s0xg5FnAyLCKUTK1oDg3PbfYqMAoL7Vcrzgxt7g0
        L10vOT93EyMw+LYd1urfwfh4SfwhRgEORiUe3oiS3igh1sSy4srcQ4wSHMxKIrwOq/qjhHhT
        EiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTCmNnzbtadzWoDC
        khjjAy8NgvNnh+wp+r/50CVVNdFf787LH/7ft/NZCNu8d1Z/v9/cPOv6JBkHX86Q50wOPOvm
        /T18oGae1vFvnk/8zqvsZ5LX8lzJWMd4uENX8ndA7cZpVpoFu12qE7ueuvx7wT3XdfXdf6lp
        YrpLklXDLqaxfV9q+vPqE3l9JZbijERDLeai4kQA0WJjmjoCAAA=
X-CMS-MailID: 20180223064140epcas2p41a734737c3fe7373329a94f485c21fd4
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p41a734737c3fe7373329a94f485c21fd4
X-RootMTR: 20180223064140epcas2p41a734737c3fe7373329a94f485c21fd4
References: <20180223064138.18401-1-jh80.chung@samsung.com>
        <CGME20180223064140epcas2p41a734737c3fe7373329a94f485c21fd4@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'num-slots' property had already deprecated.
Remove the 'nom-slots' property that is kept to maintain the compatibility.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
 drivers/mmc/host/dw_mmc-pci.c                              | 1 -
 drivers/mmc/host/dw_mmc.c                                  | 4 ----
 drivers/mmc/host/dw_mmc.h                                  | 3 ---
 4 files changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 75c9fdca4aaf..7e5e427a22ce 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -59,11 +59,6 @@ Optional properties:
   is specified and the ciu clock is specified then we'll try to set the ciu
   clock to this at probe time.
 
-* num-slots (DEPRECATED): specifies the number of slots supported by the controller.
-  The number of physical slots actually used could be equal or less than the
-  value specified by num-slots. If this property is not specified, the value
-  of num-slot property is assumed to be 1.
-
 * fifo-depth: The maximum size of the tx/rx fifo's. If this property is not
   specified, the default value of the fifo size is determined from the
   controller registers.
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index ab8713297edb..3ad07d7b2c97 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -29,7 +29,6 @@
 				MMC_CAP_SDIO_IRQ)
 
 static struct dw_mci_board pci_board_data = {
-	.num_slots			= 1,
 	.caps				= DW_MCI_CAPABILITIES,
 	.bus_hz				= 33 * 1000 * 1000,
 	.detect_delay_ms		= 200,
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 38e0e7c4ffd9..a63ca7bc1099 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3124,10 +3124,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	/* find out number of slots supported */
-	if (!device_property_read_u32(dev, "num-slots", &pdata->num_slots))
-		dev_info(dev, "'num-slots' was deprecated.\n");
-
 	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev,
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index e3124f06a47e..80ff9a6c6fdd 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -102,7 +102,6 @@ struct dw_mci_dma_slave {
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
  * @current_speed: Configured rate of the controller.
- * @num_slots: Number of slots available.
  * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
  * @dev: Device associated with the MMC controller.
@@ -253,8 +252,6 @@ struct dma_pdata;
 
 /* Board platform data */
 struct dw_mci_board {
-	u32 num_slots;
-
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-- 
2.15.1
