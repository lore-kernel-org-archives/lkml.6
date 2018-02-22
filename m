Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBPMCXPKAKGQEM5LQ3EA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519305022; cv=pass;
        d=google.com; s=arc-20160816;
        b=vqIzYs4gTKEQhhupDept1od8UeQFLj/ZTN3dz7m7/ZSfpJxi075c8Bptn2GhrY4Onl
         o8cFE7u0Z6SuzyBmgADkUhFpCR6Kqryxx9p5XMWcgczdLlNh2HTz6cOoe/IPJtvmVW8a
         OjhWLQBDTvqnERMR28QQP5rMvuM4OXcVii0wPCgvwYTnqyI2jI29v54Scuz9lHNh7hL2
         l/ci2i5/XkzvoZnAp/tiagzv+P4IpucFa0q2GHLVZs5WIVtqrZ+IeYje0Ql8Hki+WdXJ
         hhOLSJJWKQ/AJGvcYbRycNw+QpchPx4znR6Iy+IhMwNSPwMQY9+wJcIgfxIS61Dhmxg/
         yOWw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:mime-version
         :sender:dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=gHJUPRmAgH0/P/kFUmRkVDCNlfdbpWaTpdYI2se3ybY=;
        b=KPJJC99ka8Zz95EmFHYrDlm21B02zaw8OkOxB+WmDWP6MrD6Quv74mLdlcHrvpUNPf
         BCTPm+9jZcojXlgxBQ27uVvEDz9lx/cqIHvlfGpH5b9IgASdsb8EwaouYLoxwRGI7N/Q
         rE7wCEQMRdFxd07VCpLu6ACoYo8a1KjpZc30mheke0tNZ9B/BvQ2+iCwxetzYLMogvtq
         1aoq65cPuB7shA0ZguKKa5DYKpYWGGvawunUzEaugGxOT9WHPDKxUoNoAzKfPdaH0FTo
         W9cKC8yUxEk/5ac+ReY6z8Knp8QsQyt0cU4GyPIR7d/n2eX03+gIrtBUttVeHoJkXvMs
         gB0Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ZnV1/iO+;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LewgOrG7;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbpmcxpkakgqem5lq3ea@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBPMCXPKAKGQEM5LQ3EA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ZnV1/iO+;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LewgOrG7;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbpmcxpkakgqem5lq3ea@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBPMCXPKAKGQEM5LQ3EA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519305022; cv=pass;
        d=google.com; s=arc-20160816;
        b=SGNbMca9pk97rAusqUYq5bRW7WEoZQqrZ699UYdnual0goAprtpxuKi+0SbXnf30SG
         VZUg2J4M+PqDPqBG3/2vuq7K/beUey2kXJLTjG5S2N/nwU/sDOWsnOp5Nm7dTw8JcEpF
         ORMpJc4p4JyR8PzffDF3rJVNc1RenudXc/Ftwfg/PSpVHgyEia80zvjpT1NudaXm9v1R
         SH2OhYGDW+aUuF4scdFIw5gBMt8ITZhP3mID8CNSZVJRiKivvZj91h4gEKB/qQdfDP5k
         YFMIC0yT2AXz+jsagE9g/6CarEsINN3I8CGI8cL6wKOhgmeHTZs4sgoesVD8sCjY85VC
         wZNg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:mime-version
         :sender:dkim-signature:dkim-signature:arc-authentication-results;
        bh=gHJUPRmAgH0/P/kFUmRkVDCNlfdbpWaTpdYI2se3ybY=;
        b=Tjo85r6jBnOrar/L1Yf3ZOtRQCcONh1XdExSzOFMW/YgwByD3UpzCvJjE8eFkTaAPA
         mep/0qnloV+/h8x/P4c8Nwo3jC6P4UUT7Sz2sEVl40ppbYge2cKRF5MbX2en60diVOLM
         McfXla5rgxeBcHW8dKthnrN7Lvzv0mjoZXNn3IoQJpuqCucZCvDWeW/+aBi3JzmOF2f/
         UYkA2CWHLv7/cL4RkSqT9ySQ3gDuNPM9aM8qKh1PdZA7pKannL7YagmHQw9tsB33cH9e
         1+tFGzH8UVkSd/4haj3P22Jx78NKZEvuWh4Q7QqpPHWptd+vwbGXiNIj29t1KqGpk4+Y
         aGKQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=d1cDpBRO;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c01::243 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x225aEkhthTC6tPTCjb1xPEANa5Bt2Z8lBHoaub7IMq+ddeTQbI/gHqK789I1UG+xayxboNc/fg==
MIME-Version: 1.0
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519305021; cv=none;
        d=google.com; s=arc-20160816;
        b=wZjRUzQM0mWGbTUo/vodwdGsXmGmOek3TlixERFor1zRluswi17EJEAML3MTyJdYwC
         9guSb9S+9FJ1QJmbbo7YeOEf/WeTxcI6DnbP9mUcxv48AD12p2xbgxf5IgVgY66GwUVz
         Bs9xNvaKg4I1n8Dm4GMisL3BlyXu/whiPIIPmNQtJKr41OyvlIsaTy5RofTCbY489JNU
         z/uBvlh0evVeuFXlkIzmCvQzP2Hnx7820rGvcQIR7Vp0t/CeMoi3mEeNTGvIzWZveAex
         DDXGnNKFEFauRl7kDyyXnC6eRJ+g82rqi0Q2rHYKdpL7Iwd2P55/UIQoWyQex3nBUwSQ
         f/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=H3C5ifP8DoricceeZqDBgIDHlTGevvwFGHm0qpLY9Xk=;
        b=EiXkXckA2p1UvyEKb4t5WEQraCe4ctVfBxsfKNmM9tfVnR9FgxWWje/NK/D1HQG1JI
         ksKRYxe3Ky4qvYGOAgvdOJflrMUJwxCOY5AnPPLPSHa5Ei1zHruR4MjRFJt03HqQxkeS
         LM0OrsRFdk7pv0iHtMWbQV8G4d5ltcW/qlDU8mvCIm6Av/Rtbt3WQIkkN1jzh9jr2zRg
         DB+DVlW+WJF3Vu2I6EG9v4TtQv5ug84UPNlJaHq0vCnoba9TulCtUDpVbzBoDav8jdVU
         NaF2ddULHqxXHhXuNknQfuOwnO2ibihE1NfZ0hmA4xRMvMOmf80xbiisOzpMWJ/zAixp
         9xBQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=d1cDpBRO;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c01::243 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: boris.brezillon@free-electrons.com,
	richard@nod.at,
	dwmw2@infradead.org,
	computersforpeace@gmail.com,
	marek.vasut@gmail.com,
	cyrille.pitchen@wedev4u.fr,
	maximlevitsky@gmail.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	outreachy-kernel@googlegroups.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH NAND v3] mtd: nand: Replace printk() with
 appropriate pr_*() macro
Date: Thu, 22 Feb 2018 18:40:14 +0530
Message-Id: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=d1cDpBRO;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:400e:c01::243 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Content-Type: text/plain; charset="UTF-8"
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593106783204445682?=
X-GMAIL-MSGID: =?utf-8?q?1593106783204445682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The log levels embedded with the name are more concise than
printk.
Replace printks having a log level with the appropriate
pr_*macro.
Define pr_fmt() and remove other additional macros from
some of the replaced printks.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v2
  -Merge previous patches of the patchset regarding replacement
of printk with pr_*macro, into single patch.

Changes in v3
  -Define pr_fmt() and remove other additional macros from
some of the replaced printks. Also add some more changed printks
to pr_*() macro into the patch.

 drivers/mtd/nand/ams-delta.c     |  4 +--
 drivers/mtd/nand/cafe_nand.c     |  4 +--
 drivers/mtd/nand/cs553x_nand.c   |  9 ++---
 drivers/mtd/nand/diskonchip.c    | 76 +++++++++++++++++++++-------------------
 drivers/mtd/nand/fsl_elbc_nand.c |  4 +--
 drivers/mtd/nand/fsl_ifc_nand.c  |  2 +-
 drivers/mtd/nand/mxc_nand.c      |  2 +-
 drivers/mtd/nand/nand_bch.c      | 12 +++----
 drivers/mtd/nand/nandsim.c       | 15 ++++----
 drivers/mtd/nand/r852.c          |  5 ++-
 drivers/mtd/nand/r852.h          |  8 ++---
 drivers/mtd/nand/sh_flctl.c      |  2 +-
 drivers/mtd/nand/sm_common.c     |  5 ++-
 13 files changed, 77 insertions(+), 71 deletions(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index dcec9cf..e120ce9 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -185,7 +185,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	/* Allocate memory for MTD device structure and private data */
 	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
 	if (!this) {
-		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
+		pr_warn("Unable to allocate E3 NAND MTD device structure.\n");
 		err = -ENOMEM;
 		goto out;
 	}
@@ -219,7 +219,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		this->dev_ready = ams_delta_nand_ready;
 	} else {
 		this->dev_ready = NULL;
-		printk(KERN_NOTICE "Couldn't request gpio for Delta NAND ready.\n");
+		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
 	}
 	/* 25 us command delay time */
 	this->chip_delay = 30;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index bc558c4..1e84a6e 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -773,8 +773,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
 		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
 	} else {
-		printk(KERN_WARNING "Unexpected NAND flash writesize %d. Aborting\n",
-		       mtd->writesize);
+		pr_warn("Unexpected NAND flash writesize %d. Aborting\n",
+			mtd->writesize);
 		goto out_free_dma;
 	}
 	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index d488775..1fe3c8a 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -189,10 +189,11 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	struct nand_chip *this;
 	struct mtd_info *new_mtd;
 
-	printk(KERN_NOTICE "Probing CS553x NAND controller CS#%d at %sIO 0x%08lx\n", cs, mmio?"MM":"P", adr);
+	pr_notice("Probing CS553x NAND controller CS#%d at %sIO 0x%08lx\n",
+		  cs, mmio?"MM":"P", adr);
 
 	if (!mmio) {
-		printk(KERN_NOTICE "PIO mode not yet implemented for CS553X NAND controller\n");
+		pr_notice("PIO mode not yet implemented for CS553X NAND controller\n");
 		return -ENXIO;
 	}
 
@@ -211,7 +212,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	/* map physical address */
 	this->IO_ADDR_R = this->IO_ADDR_W = ioremap(adr, 4096);
 	if (!this->IO_ADDR_R) {
-		printk(KERN_WARNING "ioremap cs553x NAND @0x%08lx failed\n", adr);
+		pr_warn("ioremap cs553x NAND @0x%08lx failed\n", adr);
 		err = -EIO;
 		goto out_mtd;
 	}
@@ -295,7 +296,7 @@ static int __init cs553x_init(void)
 	/* If it doesn't have the NAND controller enabled, abort */
 	rdmsrl(MSR_DIVIL_BALL_OPTS, val);
 	if (val & PIN_OPT_IDE) {
-		printk(KERN_INFO "CS553x NAND controller: Flash I/O not enabled in MSR_DIVIL_BALL_OPTS.\n");
+		pr_info("CS553x NAND controller: Flash I/O not enabled in MSR_DIVIL_BALL_OPTS.\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index c3aa53c..8643512 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -411,7 +411,7 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 
 		ident.dword = readl(docptr + DoC_2k_CDSN_IO);
 		if (((ident.byte[0] << 8) | ident.byte[1]) == ret) {
-			printk(KERN_INFO "DiskOnChip 2000 responds to DWORD access\n");
+			pr_info("DiskOnChip 2000 responds to DWORD access\n");
 			this->read_buf = &doc2000_readbuf_dword;
 		}
 	}
@@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct mtd_info *mtd)
 			break;
 	}
 	doc->chips_per_floor = i;
-	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
+	pr_debug("Detected %d chips per floor.\n", i);
 }
 
 static int doc200x_wait(struct mtd_info *mtd, struct nand_chip *this)
@@ -935,14 +935,15 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
 
 		ret = doc_ecc_decode(rs_decoder, dat, calc_ecc);
 		if (ret > 0)
-			printk(KERN_ERR "doc200x_correct_data corrected %d errors\n", ret);
+			pr_err("doc200x_correct_data corrected %d errors\n",
+			       ret);
 	}
 	if (DoC_is_MillenniumPlus(doc))
 		WriteDOC(DOC_ECC_DIS, docptr, Mplus_ECCConf);
 	else
 		WriteDOC(DOC_ECC_DIS, docptr, ECCConf);
 	if (no_ecc_failures && mtd_is_eccerr(ret)) {
-		printk(KERN_ERR "suppressing ECC failure\n");
+		pr_err("suppressing ECC failure\n");
 		ret = 0;
 	}
 	return ret;
@@ -1015,11 +1016,11 @@ static int __init find_media_headers(struct mtd_info *mtd, u_char *buf, const ch
 		if (retlen != mtd->writesize)
 			continue;
 		if (ret) {
-			printk(KERN_WARNING "ECC error scanning DOC at 0x%x\n", offs);
+			pr_warn("ECC error scanning DOC at 0x%x\n", offs);
 		}
 		if (memcmp(buf, id, 6))
 			continue;
-		printk(KERN_INFO "Found DiskOnChip %s Media Header at 0x%x\n", id, offs);
+		pr_info("Found DiskOnChip %s Media Header at 0x%x\n", id, offs);
 		if (doc->mh0_page == -1) {
 			doc->mh0_page = offs >> this->page_shift;
 			if (!findmirror)
@@ -1030,7 +1031,7 @@ static int __init find_media_headers(struct mtd_info *mtd, u_char *buf, const ch
 		return 2;
 	}
 	if (doc->mh0_page == -1) {
-		printk(KERN_WARNING "DiskOnChip %s Media Header not found.\n", id);
+		pr_warn("DiskOnChip %s Media Header not found.\n", id);
 		return 0;
 	}
 	/* Only one mediaheader was found.  We want buf to contain a
@@ -1039,7 +1040,7 @@ static int __init find_media_headers(struct mtd_info *mtd, u_char *buf, const ch
 	ret = mtd_read(mtd, offs, mtd->writesize, &retlen, buf);
 	if (retlen != mtd->writesize) {
 		/* Insanity.  Give up. */
-		printk(KERN_ERR "Read DiskOnChip Media Header once, but can't reread it???\n");
+		pr_err("Read DiskOnChip Media Header once, but can't reread it???\n");
 		return 0;
 	}
 	return 1;
@@ -1069,11 +1070,11 @@ static inline int __init nftl_partscan(struct mtd_info *mtd, struct mtd_partitio
 	le16_to_cpus(&mh->FirstPhysicalEUN);
 	le32_to_cpus(&mh->FormattedSize);
 
-	printk(KERN_INFO "    DataOrgID        = %s\n"
-			 "    NumEraseUnits    = %d\n"
-			 "    FirstPhysicalEUN = %d\n"
-			 "    FormattedSize    = %d\n"
-			 "    UnitSizeFactor   = %d\n",
+	pr_info("    DataOrgID        = %s\n"
+		"    NumEraseUnits    = %d\n"
+		"    FirstPhysicalEUN = %d\n"
+		"    FormattedSize    = %d\n"
+		"    UnitSizeFactor   = %d\n",
 		mh->DataOrgID, mh->NumEraseUnits,
 		mh->FirstPhysicalEUN, mh->FormattedSize,
 		mh->UnitSizeFactor);
@@ -1093,7 +1094,7 @@ static inline int __init nftl_partscan(struct mtd_info *mtd, struct mtd_partitio
 			maxblocks = min(32768U, (maxblocks << 1) + psize);
 			mh->UnitSizeFactor--;
 		}
-		printk(KERN_WARNING "UnitSizeFactor=0x00 detected.  Correct value is assumed to be 0x%02x.\n", mh->UnitSizeFactor);
+		pr_warn("UnitSizeFactor=0x00 detected.  Correct value is assumed to be 0x%02x.\n", mh->UnitSizeFactor);
 	}
 
 	/* NOTE: The lines below modify internal variables of the NAND and MTD
@@ -1104,13 +1105,13 @@ static inline int __init nftl_partscan(struct mtd_info *mtd, struct mtd_partitio
 	if (mh->UnitSizeFactor != 0xff) {
 		this->bbt_erase_shift += (0xff - mh->UnitSizeFactor);
 		mtd->erasesize <<= (0xff - mh->UnitSizeFactor);
-		printk(KERN_INFO "Setting virtual erase size to %d\n", mtd->erasesize);
+		pr_info("Setting virtual erase size to %d\n", mtd->erasesize);
 		blocks = mtd->size >> this->bbt_erase_shift;
 		maxblocks = min(32768U, mtd->erasesize - psize);
 	}
 
 	if (blocks > maxblocks) {
-		printk(KERN_ERR "UnitSizeFactor of 0x%02x is inconsistent with device size.  Aborting.\n", mh->UnitSizeFactor);
+		pr_err("UnitSizeFactor of 0x%02x is inconsistent with device size.  Aborting.\n", mh->UnitSizeFactor);
 		goto out;
 	}
 
@@ -1181,14 +1182,14 @@ static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
 	le32_to_cpus(&mh->FormatFlags);
 	le32_to_cpus(&mh->PercentUsed);
 
-	printk(KERN_INFO "    bootRecordID          = %s\n"
-			 "    NoOfBootImageBlocks   = %d\n"
-			 "    NoOfBinaryPartitions  = %d\n"
-			 "    NoOfBDTLPartitions    = %d\n"
-			 "    BlockMultiplerBits    = %d\n"
-			 "    FormatFlgs            = %d\n"
-			 "    OsakVersion           = %d.%d.%d.%d\n"
-			 "    PercentUsed           = %d\n",
+	pr_info("    bootRecordID          = %s\n"
+		"    NoOfBootImageBlocks   = %d\n"
+		"    NoOfBinaryPartitions  = %d\n"
+		"    NoOfBDTLPartitions    = %d\n"
+		"    BlockMultiplerBits    = %d\n"
+		"    FormatFlgs            = %d\n"
+		"    OsakVersion           = %d.%d.%d.%d\n"
+		"    PercentUsed           = %d\n",
 		mh->bootRecordID, mh->NoOfBootImageBlocks,
 		mh->NoOfBinaryPartitions,
 		mh->NoOfBDTLPartitions,
@@ -1203,13 +1204,13 @@ static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
 
 	blocks = mtd->size >> vshift;
 	if (blocks > 32768) {
-		printk(KERN_ERR "BlockMultiplierBits=%d is inconsistent with device size.  Aborting.\n", mh->BlockMultiplierBits);
+		pr_err("BlockMultiplierBits=%d is inconsistent with device size.  Aborting.\n", mh->BlockMultiplierBits);
 		goto out;
 	}
 
 	blocks = doc->chips_per_floor << (this->chip_shift - this->phys_erase_shift);
 	if (inftl_bbt_write && (blocks > mtd->erasesize)) {
-		printk(KERN_ERR "Writeable BBTs spanning more than one erase block are not yet supported.  FIX ME!\n");
+		pr_err("Writeable BBTs spanning more than one erase block are not yet supported.  FIX ME!\n");
 		goto out;
 	}
 
@@ -1223,7 +1224,7 @@ static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
 		le32_to_cpus(&ip->spareUnits);
 		le32_to_cpus(&ip->Reserved0);
 
-		printk(KERN_INFO	"    PARTITION[%d] ->\n"
+		pr_info("    PARTITION[%d] ->\n"
 			"        virtualUnits    = %d\n"
 			"        firstUnit       = %d\n"
 			"        lastUnit        = %d\n"
@@ -1309,7 +1310,7 @@ static int __init inftl_scan_bbt(struct mtd_info *mtd)
 	struct mtd_partition parts[5];
 
 	if (this->numchips > doc->chips_per_floor) {
-		printk(KERN_ERR "Multi-floor INFTL devices not yet supported.\n");
+		pr_err("Multi-floor INFTL devices not yet supported.\n");
 		return -EIO;
 	}
 
@@ -1437,7 +1438,8 @@ static int __init doc_probe(unsigned long physadr)
 		return -EBUSY;
 	virtadr = ioremap(physadr, DOC_IOREMAP_LEN);
 	if (!virtadr) {
-		printk(KERN_ERR "Diskonchip ioremap failed: 0x%x bytes at 0x%lx\n", DOC_IOREMAP_LEN, physadr);
+		pr_err("Diskonchip ioremap failed: 0x%x bytes at 0x%lx\n",
+		       DOC_IOREMAP_LEN, physadr);
 		ret = -EIO;
 		goto error_ioremap;
 	}
@@ -1496,7 +1498,7 @@ static int __init doc_probe(unsigned long physadr)
 			reg = DoC_Mplus_Toggle;
 			break;
 		case DOC_ChipID_DocMilPlus32:
-			printk(KERN_ERR "DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
+			pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
 		default:
 			ret = -ENODEV;
 			goto notfound;
@@ -1512,7 +1514,7 @@ static int __init doc_probe(unsigned long physadr)
 	tmpb = ReadDOC_(virtadr, reg) & DOC_TOGGLE_BIT;
 	tmpc = ReadDOC_(virtadr, reg) & DOC_TOGGLE_BIT;
 	if ((tmp == tmpb) || (tmp != tmpc)) {
-		printk(KERN_WARNING "Possible DiskOnChip at 0x%lx failed TOGGLE test, dropping.\n", physadr);
+		pr_warn("Possible DiskOnChip at 0x%lx failed TOGGLE test, dropping.\n", physadr);
 		ret = -ENODEV;
 		goto notfound;
 	}
@@ -1546,12 +1548,13 @@ static int __init doc_probe(unsigned long physadr)
 		}
 		newval = ~newval;
 		if (oldval == newval) {
-			printk(KERN_DEBUG "Found alias of DOC at 0x%lx to 0x%lx\n", doc->physadr, physadr);
+			pr_debug("Found alias of DOC at 0x%lx to 0x%lx\n",
+				 doc->physadr, physadr);
 			goto notfound;
 		}
 	}
 
-	printk(KERN_NOTICE "DiskOnChip found at 0x%lx\n", physadr);
+	pr_notice("DiskOnChip found at 0x%lx\n", physadr);
 
 	len = sizeof(struct nand_chip) + sizeof(struct doc_priv) +
 	      (2 * sizeof(struct nand_bbt_descr));
@@ -1666,12 +1669,13 @@ static int __init init_nanddoc(void)
 	 */
 	rs_decoder = init_rs(10, 0x409, FCR, 1, NROOTS);
 	if (!rs_decoder) {
-		printk(KERN_ERR "DiskOnChip: Could not create a RS decoder\n");
+		pr_err("DiskOnChip: Could not create a RS decoder\n");
 		return -ENOMEM;
 	}
 
 	if (doc_config_location) {
-		printk(KERN_INFO "Using configured DiskOnChip probe address 0x%lx\n", doc_config_location);
+		pr_info("Using configured DiskOnChip probe address 0x%lx\n",
+			doc_config_location);
 		ret = doc_probe(doc_config_location);
 		if (ret < 0)
 			goto outerr;
@@ -1683,7 +1687,7 @@ static int __init init_nanddoc(void)
 	/* No banner message any more. Print a message if no DiskOnChip
 	   found, so the user knows we at least tried. */
 	if (!doclist) {
-		printk(KERN_INFO "No valid DiskOnChip devices found\n");
+		pr_info("No valid DiskOnChip devices found\n");
 		ret = -ENODEV;
 		goto outerr;
 	}
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 17db2f9..396216c2 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -929,8 +929,8 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 	mtd_device_parse_register(mtd, part_probe_types, NULL,
 				  NULL, 0);
 
-	printk(KERN_INFO "eLBC NAND device at 0x%llx, bank %d\n",
-	       (unsigned long long)res.start, priv->bank);
+	pr_info("eLBC NAND device at 0x%llx, bank %d\n",
+		(unsigned long long)res.start, priv->bank);
 	return 0;
 
 err:
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 9e03bac..f88a493 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -805,7 +805,7 @@ static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
 			   msecs_to_jiffies(IFC_TIMEOUT_MSECS));
 
 	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC)
-		printk(KERN_ERR "fsl-ifc: Failed to Initialise SRAM\n");
+		pr_err("fsl-ifc: Failed to Initialise SRAM\n");
 
 	/* Restore CSOR and CSOR_ext */
 	ifc_out32(csor, &ifc_global->csor_cs[cs].csor);
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 53e5e03..e99c272 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -634,7 +634,7 @@ static int mxc_nand_correct_data_v2_v3(struct mtd_info *mtd, u_char *dat,
 	do {
 		err = ecc_stat & ecc_bit_mask;
 		if (err > err_limit) {
-			printk(KERN_WARNING "UnCorrectable RS-ECC Error\n");
+			pr_warn("UnCorrectable RS-ECC Error\n");
 			return -EBADMSG;
 		} else {
 			ret += err;
diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index 505441c..7f11b68 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -95,7 +95,7 @@ int nand_bch_correct_data(struct mtd_info *mtd, unsigned char *buf,
 					errloc[i]);
 		}
 	} else if (count < 0) {
-		printk(KERN_ERR "ecc unrecoverable error\n");
+		pr_err("ecc unrecoverable error\n");
 		count = -EBADMSG;
 	}
 	return count;
@@ -134,7 +134,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 	}
 
 	if (!eccsize || !eccbytes) {
-		printk(KERN_WARNING "ecc parameters not supplied\n");
+		pr_warn("ecc parameters not supplied\n");
 		goto fail;
 	}
 
@@ -151,8 +151,8 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 
 	/* verify that eccbytes has the expected value */
 	if (nbc->bch->ecc_bytes != eccbytes) {
-		printk(KERN_WARNING "invalid eccbytes %u, should be %u\n",
-		       eccbytes, nbc->bch->ecc_bytes);
+		pr_warn("invalid eccbytes %u, should be %u\n",
+			eccbytes, nbc->bch->ecc_bytes);
 		goto fail;
 	}
 
@@ -166,7 +166,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 
 	/* sanity checks */
 	if (8*(eccsize+eccbytes) >= (1 << m)) {
-		printk(KERN_WARNING "eccsize %u is too large\n", eccsize);
+		pr_warn("eccsize %u is too large\n", eccsize);
 		goto fail;
 	}
 
@@ -181,7 +181,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 	nand->ecc.steps = eccsteps;
 	nand->ecc.total = eccsteps * eccbytes;
 	if (mtd_ooblayout_count_eccbytes(mtd) != (eccsteps*eccbytes)) {
-		printk(KERN_WARNING "invalid ecc layout\n");
+		pr_warn("invalid ecc layout\n");
 		goto fail;
 	}
 
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index 246b439..eeb34ef 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -23,6 +23,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA
  */
 
+#define pr_fmt(fmt)  "[nandsim]" fmt
+
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/module.h>
@@ -179,20 +181,17 @@ MODULE_PARM_DESC(bch,		 "Enable BCH ecc and set how many bits should "
 /* The largest possible page size */
 #define NS_LARGEST_PAGE_SIZE	4096
 
-/* The prefix for simulator output */
-#define NS_OUTPUT_PREFIX "[nandsim]"
-
 /* Simulator's output macros (logging, debugging, warning, error) */
 #define NS_LOG(args...) \
-	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX " log: " args); } while(0)
+	do { if (log) pr_debug(" log: " args); } while(0)
 #define NS_DBG(args...) \
-	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX " debug: " args); } while(0)
+	do { if (dbg) pr_debug(" debug: " args); } while(0)
 #define NS_WARN(args...) \
-	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: " args); } while(0)
+	do { pr_warn(" warning: " args); } while(0)
 #define NS_ERR(args...) \
-	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: " args); } while(0)
+	do { pr_err(" error: " args); } while(0)
 #define NS_INFO(args...) \
-	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); } while(0)
+	do { pr_info(" " args); } while(0)
 
 /* Busy-wait delay macros (microseconds, milliseconds) */
 #define NS_UDELAY(us) \
diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
index fc9287a..cd3cd1c 100644
--- a/drivers/mtd/nand/r852.c
+++ b/drivers/mtd/nand/r852.c
@@ -7,6 +7,9 @@
  * published by the Free Software Foundation.
  */
 
+#define DRV_NAME "r852"
+#define pr_fmt(fmt)  DRV_NAME fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/jiffies.h>
@@ -935,7 +938,7 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 		&dev->card_detect_work, 0);
 
 
-	printk(KERN_NOTICE DRV_NAME ": driver loaded successfully\n");
+	pr_notice(": driver loaded successfully\n");
 	return 0;
 
 error10:
diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
index 8713c57..709eced 100644
--- a/drivers/mtd/nand/r852.h
+++ b/drivers/mtd/nand/r852.h
@@ -145,16 +145,16 @@ struct r852_device {
 };
 
 #define DRV_NAME "r852"
-
+#define pr_fmt(fmt)  DRV_NAME fmt
 
 #define dbg(format, ...) \
 	if (debug) \
-		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
+		pr_debug(": " format "\n", ## __VA_ARGS__)
 
 #define dbg_verbose(format, ...) \
 	if (debug > 1) \
-		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
+		pr_debug(": " format "\n", ## __VA_ARGS__)
 
 
 #define message(format, ...) \
-	printk(KERN_INFO DRV_NAME ": " format "\n", ## __VA_ARGS__)
+	pr_info(": " format "\n", ## __VA_ARGS__)
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index e7f3c98..493f6b2 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -877,7 +877,7 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			else if (!flctl->seqin_column)
 				execmd_write_page_sector(mtd);
 			else
-				printk(KERN_ERR "Invalid address !?\n");
+				pr_err("Invalid address !?\n");
 			break;
 		}
 		set_cmd_regs(mtd, command, (command << 8) | NAND_CMD_SEQIN);
diff --git a/drivers/mtd/nand/sm_common.c b/drivers/mtd/nand/sm_common.c
index c378705..7f5044a 100644
--- a/drivers/mtd/nand/sm_common.c
+++ b/drivers/mtd/nand/sm_common.c
@@ -119,9 +119,8 @@ static int sm_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 	ret = mtd_write_oob(mtd, ofs, &ops);
 	if (ret < 0 || ops.oobretlen != SM_OOB_SIZE) {
-		printk(KERN_NOTICE
-			"sm_common: can't mark sector at %i as bad\n",
-								(int)ofs);
+		pr_notice("sm_common: can't mark sector at %i as bad\n",
+			  (int)ofs);
 		return -EIO;
 	}
 
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1519305014-2547-1-git-send-email-shreeya.patel23498%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
