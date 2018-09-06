Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FDC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2546520844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2546520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeIGCIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:08:37 -0400
Received: from mout.perfora.net ([74.208.4.196]:38279 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeIGCIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:08:37 -0400
Received: from localhost.net ([89.217.215.226]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id 0LqjuG-1fKpU61y6s-00eHjV;
 Thu, 06 Sep 2018 23:30:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-mtd@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 1/2] mtd: rawnand: reorder NAND manufacturer IDs
Date:   Thu,  6 Sep 2018 23:30:19 +0200
Message-Id: <20180906213020.7493-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9P4EU5djtvvIGV7K7jHDFLYKFOuHvaps8Nkh28c/K9w/T0a59aH
 6XHYgnGwXUVUzVTy+SPsSPnW96I+f3htiLANhwt5SsGDWsNzuHX3AzYAQC5Mz9KBiGPWfoq
 jc+fLGDXOexowhWN5LnYy7QmJi2n32BYu3KcQZPVREQyVY6l5iaUm0b0riCqNh3K/BS+Eru
 lE47aZcmlN/4KfDEa5xTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3BRPHLHC+oA=:sRtZyzRIRkcTQqCS/9kwhL
 9EDa0clPOQqlZRxH5Y6eghZ25Imi9scVblSdEtxXrKUqoEob3NhMfepEl83E0TqrYs5e2NuPn
 FdhM2YEXYRe/i/bGK2KVjpZfTrxV2MxI1U+oPFlVd9ZcfdUxxVVtYh+zDW2DEzTcXRr1E/5TI
 4eQTx6EbDUx8JnN6XVzizSgasx2m2yZroOHGKa2z0f7zbFKWTt8B0Oj5NApxyc/UuGgYEe83S
 sNZZ65hYkRTlAge2WPY27TlgzR+Bn+epAcViDOI5e2r4in3KvjxCJUXRYhYgtcuNEvJ+EYkzN
 A4u7RTjEcYTmJOFn1BTsk1h6KjeTjUWQ2jOOQdvhRV6LKz5rYtpp/U1PoW7inm4ljHBoA6Fx+
 JRqCLciG4Aq/wi9Hc78JCz5JMBsSfXafqoL3h8IcTJhON0g1sdEmYdhqXosr95m/EQ1ditcjk
 Ghf8R2En8KsV+xKBErJIuwtl8ajrzfeQ76le+NYSeD1lku6ngN1M1dTIqUQDx78A29fMxTyHW
 QLFiFftARhVULqsQON9eYs+RxL+UWLzaPAXl4KMW6ALksVDu0VlomSC5TCOEIF42bMaWVKIB5
 bCrAaxCfoMpPcyi/uVVOAcW+QEKTWYjZrx6FNaQaPdXS0LH8Ln10RFV+Vo4fAMasE3s8w2vUP
 /beJKfC58RojhA7fTSlr/u3G19ZdNvRhxJYqW7M9f62mYb/Pso5OM7KPGVnJx2GUc64tQjbDC
 tTiSlE2vqQErIl7c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder NAND manufacturer IDs for clarity.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Subject prefix s/nand:/rawnand:/ as well as upper-case: s/nand/NAND/
  and s/id/ID/ in the commit log as suggested by Miquèl.
- Reordering the macro definitions too as suggested by Boris.

 drivers/mtd/nand/raw/nand_ids.c | 20 ++++++++++----------
 include/linux/mtd/rawnand.h     | 28 ++++++++++++++--------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 5423c3bb388e..0851cd86bf19 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -169,21 +169,21 @@ struct nand_flash_dev nand_flash_ids[] = {
 
 /* Manufacturer IDs */
 static const struct nand_manufacturer nand_manufacturers[] = {
-	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
+	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
+	{NAND_MFR_ATO, "ATO"},
+	{NAND_MFR_EON, "Eon"},
 	{NAND_MFR_ESMT, "ESMT"},
-	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
 	{NAND_MFR_FUJITSU, "Fujitsu"},
-	{NAND_MFR_NATIONAL, "National"},
-	{NAND_MFR_RENESAS, "Renesas"},
-	{NAND_MFR_STMICRO, "ST Micro"},
 	{NAND_MFR_HYNIX, "Hynix", &hynix_nand_manuf_ops},
-	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
-	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
+	{NAND_MFR_INTEL, "Intel"},
 	{NAND_MFR_MACRONIX, "Macronix", &macronix_nand_manuf_ops},
-	{NAND_MFR_EON, "Eon"},
+	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
+	{NAND_MFR_NATIONAL, "National"},
+	{NAND_MFR_RENESAS, "Renesas"},
+	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
 	{NAND_MFR_SANDISK, "SanDisk"},
-	{NAND_MFR_INTEL, "Intel"},
-	{NAND_MFR_ATO, "ATO"},
+	{NAND_MFR_STMICRO, "ST Micro"},
+	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
 	{NAND_MFR_WINBOND, "Winbond"},
 };
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index efb2345359bb..20516fc28b74 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1422,21 +1422,21 @@ static inline void *nand_get_manufacturer_data(struct nand_chip *chip)
 /*
  * NAND Flash Manufacturer ID Codes
  */
-#define NAND_MFR_TOSHIBA	0x98
+#define NAND_MFR_AMD		0x01
+#define NAND_MFR_ATO		0x9b
+#define NAND_MFR_EON		0x92
 #define NAND_MFR_ESMT		0xc8
-#define NAND_MFR_SAMSUNG	0xec
 #define NAND_MFR_FUJITSU	0x04
-#define NAND_MFR_NATIONAL	0x8f
-#define NAND_MFR_RENESAS	0x07
-#define NAND_MFR_STMICRO	0x20
 #define NAND_MFR_HYNIX		0xad
-#define NAND_MFR_MICRON		0x2c
-#define NAND_MFR_AMD		0x01
+#define NAND_MFR_INTEL		0x89
 #define NAND_MFR_MACRONIX	0xc2
-#define NAND_MFR_EON		0x92
+#define NAND_MFR_MICRON		0x2c
+#define NAND_MFR_NATIONAL	0x8f
+#define NAND_MFR_RENESAS	0x07
+#define NAND_MFR_SAMSUNG	0xec
 #define NAND_MFR_SANDISK	0x45
-#define NAND_MFR_INTEL		0x89
-#define NAND_MFR_ATO		0x9b
+#define NAND_MFR_STMICRO	0x20
+#define NAND_MFR_TOSHIBA	0x98
 #define NAND_MFR_WINBOND	0xef
 
 
@@ -1541,12 +1541,12 @@ nand_manufacturer_name(const struct nand_manufacturer *manufacturer)
 
 extern struct nand_flash_dev nand_flash_ids[];
 
-extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
-extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
-extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
-extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
 extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
+extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
 extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
+extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
+extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
+extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
 
 int nand_create_bbt(struct nand_chip *chip);
 int nand_markbad_bbt(struct mtd_info *mtd, loff_t offs);
-- 
2.14.4

