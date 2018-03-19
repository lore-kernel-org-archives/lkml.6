Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBRPQX7KQKGQETWXXAQI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521481798; cv=pass;
        d=google.com; s=arc-20160816;
        b=KUgYiE8115G9TxZLdeunVR/tOxyU5KwwnirUN+XNNqRATfogiR1pz5tbjS9XgCbJDJ
         wzPndybd5acuLxwKemA0YAg6m4kY2HD8QmjZ+0fR16C/q8dbH0OVrhre+0l/sIfanyWJ
         ps+L36USaZ78vcvV6NRJwYGZb2o3JMmfVn1h9bkw5L8BEOjv0VUBD6GGev7fNm/qz41d
         FFNAG6r/MH5krvrBx9hn+8ZzhmlCtF14tgkcnjF034OtcVNy3GVNSbYw9ULMftQ6Qu62
         zuyFcJcrrMxdwy8lsCwvIooLmLN79BW5Pa1fEvlErt5c4DgK6TgA5fP/I/GSytlvQ3I4
         EUPw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=9RiCPRnG3lz878Q4RIGTWDoDJ47zKohubxM+586nDwY=;
        b=Ii1RD8xNKMBmHsVFYDVgyABwnwKH14IgmO7s4tYcG1FsrH+N0pvutloUwL8EubXb8L
         1E7YIZP2LjaiwBQdZAr4t3JCnqRtZ441t3R8Xx7uyU2DXg70ECcjGvMaxg0qB2uXnSh9
         rsxJLjyoiLACgBqTpFfdR3PfWcwfsCPQMRZ/Nb89H/proZDjSTLFYwNkugylXf0vRMEy
         0Al6ldD66QWCxTOhP4dUDlI2MUVS9W8yyvye3j2OLgDd7J1Tn8zV7axJMtn+f2WkdXJZ
         967ub0DBliFFEtMmlcI80csEd+M8DDNhukjw5Hasfti2W5ioK0sPcdZ6VGa4eChMVS9A
         t/gQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=nSNAztIJ;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nwpJ3c8m;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbrpqx7kqkgqetwxxaqi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBRPQX7KQKGQETWXXAQI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=nSNAztIJ;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nwpJ3c8m;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbrpqx7kqkgqetwxxaqi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBRPQX7KQKGQETWXXAQI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1521481798; cv=pass;
        d=google.com; s=arc-20160816;
        b=0IHkek1360WqFbNlJ7o+eBEouQgmtsOQs/LNH8OUWsRklr+ycl3HmF8gajsHKogCSL
         Yt3wbHKzfRDhCEN7hleEOAQRUvwj+OMUX6Xent17fnuWfCSPvKv/0gNWpQIYxkaMHm9D
         T4SEiW88nQS3fCsRs7KUZaIghL7CPPmibVwJtErhgouxZH8Pm2SQjb07VV2Oudre/HfP
         BNH5SuqQb+ALUkNBtZhssrr8jujowzDaK/89oXsctbbJjjoUpm1pDqZEQjT/rWGAogBg
         63icfleDMMtWQN0JALboMlShupOc7G2HYM/C4AoUIGEQxRPGMwYPaFacX8GPurHJhfpT
         KU+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9RiCPRnG3lz878Q4RIGTWDoDJ47zKohubxM+586nDwY=;
        b=vw4xgu6ificV+xyusBBPP7n9uVWior07ZcCpWuVhSNKOzIZgkBzltx1a/SIwhQIFLh
         DHNN6t+E8IpAIUt3DfV6OMft6z2Mp2goPk1VqIy8nOMe91XgpPq9UxoClxDweJJqsjGy
         367RCyhus1gSBmqXGxyrYL2qSRDux9SzWTRPQGQqq+nTzbYbOHi8q6idM1zlbV8rrXEm
         0w42+efTIJEXu5u6kpwkr0WOs74gzykQZBjx3A0WMWwb6w2vhSK6tpU7U1G3zVVA34tn
         hJ4A2Sn8+7ZrZEuncEBUhA6Q6X+Z5C+8YVN4LfN5c6dqIN1VddO2FVGet0nKLtHI4B8m
         nn/Q==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G6RW0oB8;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::244 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELvH3RyPRSSvMrPx3ITLLi+K/ZvTIhd+Tghjho4A+f6n1Wp132HZiV+Xc+o1QJYmc08JKhdEQA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521481797; cv=none;
        d=google.com; s=arc-20160816;
        b=raL8L3wBaFLsCsbVRzJF/a8W6KhwByC8eXk0ZgPA4fIztKMhacYZ3ZKHwJZJHhsO1n
         pEcXBxKO7xqGA7dQNunYEZ+2BSA1cb42sjTOMUfEUCg/DDN0a0seSeHjx3XdDnDDB1/S
         q8lBIAnbpPGNtB1Y6ZvbXBARu3PeQsksdV4g+QfKVPHQ3t6pZdHeP888Sg4khu3oy1Df
         y8m/OLy5eo9LqJ0Uz4u1Awf2Q0jb11cgIBP+aQ8QkOcBm5wXTZPkAe2jxtmpy8hFSWD6
         3r0+bQN0HTL9UAGodAFYZfm2a9fveTr0Y0i45Cc/qBlVBc/24JMmuX8ndbwo3Cd+ZKpg
         9OGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=MeWg+X6YcXuUxns/y/hHtKkXYqpQh4GXDqv0jiN/9Q4=;
        b=HohcYtI+YWEXp1QadG5twtyOh1Eqk8rJ4xt7n9pBlrPvVfpa67fJ9Sd0e2JVcYK5Ti
         k72mzEv9ebTY+uSN4EczeZURlN//7hR1iZXFK7RM8KCQMpi+ahbJTBITGxDHk+bHw6AJ
         oo3Nzkt8e2a9687FWwCfeRBsSBuVj7zE/4PFMnphnqSt4Y+X/f/Sh24EHxTvhOueFDpp
         VvVt9xt2TCDCWZeT1IZdZll3XNtElbVqkJPDXvb4RK5ErbUStqsrYqSBFh9iAC8nMA0a
         86xMKnz0+/g9KE3rN2xqcmOTlBfrLYyuXoHwL26Ie4mAZLxuPn4WAUOcxc4fLiSLvsEK
         tFWg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G6RW0oB8;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::244 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Mon, 19 Mar 2018 23:19:08 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
	outreachy-kernel@googlegroups.com,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [Outreachy kernel] [PATCH v2] mtd: Replace printk() with more
 standardize output format
Message-ID: <20180319174908.GA29619@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=G6RW0oB8;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c05::244 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595389298195270964?=
X-GMAIL-MSGID: =?utf-8?q?1595389298195270964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

printk() is the raw way to print output and should be avoided.

For drivers with defined "struct device object", dev_*macro() is
prefer to standardize the output format within the subsystem.

If no "struct device object" is defined prefer pr_*macro() over
printk().

This patch Replace printk having a log level with the appropriate output
format according to the order of preference.

Change string explicitly mentioning function name to "%s...", __func__.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
*Change string explicitly mentioning function name to "%s...", __func__.
*merge quoted string split across lines.
*Cc'ed outreachy mailing list

 drivers/mtd/ftl.c | 108 ++++++++++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 61 deletions(-)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 664d206..a048429 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -177,18 +177,18 @@ static int scan_header(partition_t *part)
     }
 
     if (offset == max_offset) {
-	printk(KERN_NOTICE "ftl_cs: FTL header not found.\n");
+	pr_notice("ftl_cs: FTL header not found.\n");
 	return -ENOENT;
     }
     if (header.BlockSize != 9 ||
 	(header.EraseUnitSize < 10) || (header.EraseUnitSize > 31) ||
 	(header.NumTransferUnits >= le16_to_cpu(header.NumEraseUnits))) {
-	printk(KERN_NOTICE "ftl_cs: FTL header corrupt!\n");
+	pr_notice("ftl_cs: FTL header corrupt!\n");
 	return -1;
     }
     if ((1 << header.EraseUnitSize) != part->mbd.mtd->erasesize) {
-	printk(KERN_NOTICE "ftl: FTL EraseUnitSize %x != MTD erasesize %x\n",
-	       1 << header.EraseUnitSize,part->mbd.mtd->erasesize);
+	pr_notice("ftl: FTL EraseUnitSize %x != MTD erasesize %x\n",
+		  1 << header.EraseUnitSize, part->mbd.mtd->erasesize);
 	return -1;
     }
     part->header = header;
@@ -240,8 +240,7 @@ static int build_maps(partition_t *part)
 	    xvalid++;
 	} else {
 	    if (xtrans == part->header.NumTransferUnits) {
-		printk(KERN_NOTICE "ftl_cs: format error: too many "
-		       "transfer units!\n");
+		pr_notice("ftl_cs: format error: too many transfer units!\n");
 		goto out_XferInfo;
 	    }
 	    if (hdr_ok && (le16_to_cpu(header.LogicalEUN) == 0xffff)) {
@@ -261,8 +260,7 @@ static int build_maps(partition_t *part)
     header = part->header;
     if ((xtrans != header.NumTransferUnits) ||
 	(xvalid+xtrans != le16_to_cpu(header.NumEraseUnits))) {
-	printk(KERN_NOTICE "ftl_cs: format error: erase units "
-	       "don't add up!\n");
+	pr_notice("ftl_cs: format error: erase units don't add up!\n");
 	goto out_XferInfo;
     }
 
@@ -384,8 +382,7 @@ static void ftl_erase_callback(struct erase_info *erase)
 	if (part->XferInfo[i].Offset == erase->addr) break;
 
     if (i == part->header.NumTransferUnits) {
-	printk(KERN_NOTICE "ftl_cs: internal error: "
-	       "erase lookup failed!\n");
+	pr_notice("ftl_cs: internal error: erase lookup failed!\n");
 	return;
     }
 
@@ -394,8 +391,7 @@ static void ftl_erase_callback(struct erase_info *erase)
 	xfer->state = XFER_ERASED;
     else {
 	xfer->state = XFER_FAILED;
-	printk(KERN_NOTICE "ftl_cs: erase failed: state = %d\n",
-	       erase->state);
+	pr_notice("ftl_cs: erase failed: state = %d\n", erase->state);
     }
 
     kfree(erase);
@@ -492,7 +488,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
 	part->bam_index = 0xffff;
 
 	if (ret) {
-	    printk( KERN_WARNING "ftl: Failed to read BAM cache in copy_erase_unit()!\n");
+	    pr_warn("ftl: Failed to read BAM cache in %s()!\n", __func__);
 	    return ret;
 	}
     }
@@ -506,7 +502,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
                     (u_char *)&unit);
 
     if (ret) {
-	printk( KERN_WARNING "ftl: Failed to write back to BAM cache in copy_erase_unit()!\n");
+	pr_warn("ftl: Failed to write back to BAM cache in %s()!\n", __func__);
 	return ret;
     }
 
@@ -525,7 +521,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
 	    ret = mtd_read(part->mbd.mtd, src, SECTOR_SIZE, &retlen,
                            (u_char *)buf);
 	    if (ret) {
-		printk(KERN_WARNING "ftl: Error reading old xfer unit in copy_erase_unit\n");
+		pr_warn("ftl: Error reading old xfer unit in %s\n", __func__);
 		return ret;
             }
 
@@ -533,7 +529,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
 	    ret = mtd_write(part->mbd.mtd, dest, SECTOR_SIZE, &retlen,
                             (u_char *)buf);
 	    if (ret)  {
-		printk(KERN_WARNING "ftl: Error writing new xfer unit in copy_erase_unit\n");
+		pr_warn("ftl: Error writing new xfer unit in %s\n", __func__);
 		return ret;
             }
 
@@ -555,7 +551,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
                     &retlen,
                     (u_char *)part->bam_cache);
     if (ret) {
-	printk( KERN_WARNING "ftl: Error writing BAM in copy_erase_unit\n");
+	pr_warn("ftl: Error writing BAM in %s\n", __func__);
 	return ret;
     }
 
@@ -565,7 +561,7 @@ static int copy_erase_unit(partition_t *part, uint16_t srcunit,
                     &retlen, (u_char *)&srcunitswap);
 
     if (ret) {
-	printk(KERN_WARNING "ftl: Error writing new LogicalEUN in copy_erase_unit\n");
+	pr_warn("ftl: Error writing new LogicalEUN in %s\n", __func__);
 	return ret;
     }
 
@@ -643,17 +639,14 @@ static int reclaim_block(partition_t *part)
 	}
 	if (xfer == 0xffff) {
 	    if (queued) {
-		pr_debug("ftl_cs: waiting for transfer "
-		      "unit to be prepared...\n");
+		pr_debug("ftl_cs: waiting for transfer unit to be prepared...\n");
 		mtd_sync(part->mbd.mtd);
 	    } else {
 		static int ne = 0;
 		if (++ne < 5)
-		    printk(KERN_NOTICE "ftl_cs: reclaim failed: no "
-			   "suitable transfer units!\n");
+		    pr_notice("ftl_cs: reclaim failed: no suitable transfer units!\n");
 		else
-		    pr_debug("ftl_cs: reclaim failed: no "
-			  "suitable transfer units!\n");
+		    pr_debug("ftl_cs: reclaim failed: no suitable transfer units!\n");
 
 		return -EIO;
 	    }
@@ -679,11 +672,9 @@ static int reclaim_block(partition_t *part)
 	if (best == 0) {
 	    static int ne = 0;
 	    if (++ne < 5)
-		printk(KERN_NOTICE "ftl_cs: reclaim failed: "
-		       "no free blocks!\n");
+		pr_notice("ftl_cs: reclaim failed: no free blocks!\n");
 	    else
-		pr_debug("ftl_cs: reclaim failed: "
-		       "no free blocks!\n");
+		pr_debug("ftl_cs: reclaim failed: no free blocks!\n");
 
 	    return -EIO;
 	}
@@ -692,7 +683,7 @@ static int reclaim_block(partition_t *part)
     if (!ret)
 	erase_xfer(part, xfer);
     else
-	printk(KERN_NOTICE "ftl_cs: copy_erase_unit failed!\n");
+	pr_notice("ftl_cs: copy_erase_unit failed!\n");
     return ret;
 } /* reclaim_block */
 
@@ -710,10 +701,9 @@ static int reclaim_block(partition_t *part)
 static void dump_lists(partition_t *part)
 {
     int i;
-    printk(KERN_DEBUG "ftl_cs: Free total = %d\n", part->FreeTotal);
+    pr_dbg("ftl_cs: Free total = %d\n", part->FreeTotal);
     for (i = 0; i < part->DataUnits; i++)
-	printk(KERN_DEBUG "ftl_cs:   unit %d: %d phys, %d free, "
-	       "%d deleted\n", i,
+	pr_dbg("ftl_cs: unit %d: %d phys, %d free, %d deleted\n", i,
 	       part->EUNInfo[i].Offset >> part->header.EraseUnitSize,
 	       part->EUNInfo[i].Free, part->EUNInfo[i].Deleted);
 }
@@ -750,7 +740,7 @@ static uint32_t find_free(partition_t *part)
                        (u_char *)(part->bam_cache));
 
 	if (ret) {
-	    printk(KERN_WARNING"ftl: Error reading BAM in find_free\n");
+	    pr_warn("ftl: Error reading BAM in %s\n", __func__);
 	    return 0;
 	}
 	part->bam_index = eun;
@@ -765,7 +755,7 @@ static uint32_t find_free(partition_t *part)
 	if (++ne == 1)
 	    dump_lists(part);
 #endif
-	printk(KERN_NOTICE "ftl_cs: bad free list!\n");
+	pr_notice("ftl_cs: bad free list!\n");
 	return 0;
     }
     pr_debug("ftl_cs: found free block at %d in %d\n", blk, eun);
@@ -791,14 +781,14 @@ static int ftl_read(partition_t *part, caddr_t buffer,
     pr_debug("ftl_cs: ftl_read(0x%p, 0x%lx, %ld)\n",
 	  part, sector, nblocks);
     if (!(part->state & FTL_FORMATTED)) {
-	printk(KERN_NOTICE "ftl_cs: bad partition\n");
+	pr_notice("ftl_cs: bad partition\n");
 	return -EIO;
     }
     bsize = 1 << part->header.EraseUnitSize;
 
     for (i = 0; i < nblocks; i++) {
 	if (((sector+i) * SECTOR_SIZE) >= le32_to_cpu(part->header.FormattedSize)) {
-	    printk(KERN_NOTICE "ftl_cs: bad read offset\n");
+	    pr_notice("ftl_cs: bad read offset\n");
 	    return -EIO;
 	}
 	log_addr = part->VirtualBlockMap[sector+i];
@@ -811,7 +801,7 @@ static int ftl_read(partition_t *part, caddr_t buffer,
                            (u_char *)buffer);
 
 	    if (ret) {
-		printk(KERN_WARNING "Error reading MTD device in ftl_read()\n");
+		pr_warn("Error reading MTD device in %s()\n", __func__);
 		return ret;
 	    }
 	}
@@ -849,7 +839,7 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
     ret = mtd_read(part->mbd.mtd, offset, sizeof(uint32_t), &retlen,
                    (u_char *)&old_addr);
     if (ret) {
-	printk(KERN_WARNING"ftl: Error reading old_addr in set_bam_entry: %d\n",ret);
+	pr_warn("ftl: Error reading old_addr in %s: %d\n", __func__, ret);
 	return ret;
     }
     old_addr = le32_to_cpu(old_addr);
@@ -859,9 +849,9 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
 	(!BLOCK_DELETED(virt_addr) && (old_addr != 0xfffffffe))) {
 	static int ne = 0;
 	if (++ne < 5) {
-	    printk(KERN_NOTICE "ftl_cs: set_bam_entry() inconsistency!\n");
-	    printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, old = 0x%x"
-		   ", new = 0x%x\n", log_addr, old_addr, virt_addr);
+	    pr_notice("ftl_cs: %s() inconsistency!\n", __func__);
+	    pr_notice("ftl_cs: log_addr = 0x%x, old = 0x%x, new = 0x%x\n",
+		      log_addr, old_addr, virt_addr);
 	}
 	return -EIO;
     }
@@ -872,11 +862,9 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
 	if (le32_to_cpu(part->bam_cache[blk]) != old_addr) {
 	    static int ne = 0;
 	    if (++ne < 5) {
-		printk(KERN_NOTICE "ftl_cs: set_bam_entry() "
-		       "inconsistency!\n");
-		printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, cache"
-		       " = 0x%x\n",
-		       le32_to_cpu(part->bam_cache[blk]), old_addr);
+		pr_notice("ftl_cs: %s() inconsistency!\n", __func__);
+		pr_notice("ftl_cs: log_addr = 0x%x, cache = 0x%x\n",
+			  le32_to_cpu(part->bam_cache[blk]), old_addr);
 	    }
 	    return -EIO;
 	}
@@ -887,9 +875,9 @@ static int set_bam_entry(partition_t *part, uint32_t log_addr,
                     (u_char *)&le_virt_addr);
 
     if (ret) {
-	printk(KERN_NOTICE "ftl_cs: set_bam_entry() failed!\n");
-	printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, new = 0x%x\n",
-	       log_addr, virt_addr);
+	pr_notice("ftl_cs: %s() failed!\n", __func__);
+	pr_notice("ftl_cs: log_addr = 0x%x, new = 0x%x\n",
+		  log_addr, virt_addr);
     }
     return ret;
 } /* set_bam_entry */
@@ -905,7 +893,7 @@ static int ftl_write(partition_t *part, caddr_t buffer,
     pr_debug("ftl_cs: ftl_write(0x%p, %ld, %ld)\n",
 	  part, sector, nblocks);
     if (!(part->state & FTL_FORMATTED)) {
-	printk(KERN_NOTICE "ftl_cs: bad partition\n");
+	pr_notice("ftl_cs: bad partition\n");
 	return -EIO;
     }
     /* See if we need to reclaim space, before we start */
@@ -920,7 +908,7 @@ static int ftl_write(partition_t *part, caddr_t buffer,
     virt_addr = sector * SECTOR_SIZE | BLOCK_DATA;
     for (i = 0; i < nblocks; i++) {
 	if (virt_addr >= le32_to_cpu(part->header.FormattedSize)) {
-	    printk(KERN_NOTICE "ftl_cs: bad write offset\n");
+	    pr_notice("ftl_cs: bad write offset\n");
 	    return -EIO;
 	}
 
@@ -929,8 +917,7 @@ static int ftl_write(partition_t *part, caddr_t buffer,
 	if (blk == 0) {
 	    static int ne = 0;
 	    if (++ne < 5)
-		printk(KERN_NOTICE "ftl_cs: internal error: "
-		       "no free blocks!\n");
+		pr_notice("ftl_cs: internal error: no free blocks!\n");
 	    return -ENOSPC;
 	}
 
@@ -946,10 +933,9 @@ static int ftl_write(partition_t *part, caddr_t buffer,
 	ret = mtd_write(part->mbd.mtd, offset, SECTOR_SIZE, &retlen, buffer);
 
 	if (ret) {
-	    printk(KERN_NOTICE "ftl_cs: block write failed!\n");
-	    printk(KERN_NOTICE "ftl_cs:   log_addr = 0x%x, virt_addr"
-		   " = 0x%x, Offset = 0x%zx\n", log_addr, virt_addr,
-		   offset);
+	    pr_notice("ftl_cs: block write failed!\n");
+	    pr_notice("ftl_cs: log_addr = 0x%x, virt_addr = 0x%x,"
+		      " Offset = 0x%zx\n", log_addr, virt_addr, offset);
 	    return -EIO;
 	}
 
@@ -1045,8 +1031,8 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	partition = kzalloc(sizeof(partition_t), GFP_KERNEL);
 
 	if (!partition) {
-		printk(KERN_WARNING "No memory to scan for FTL on %s\n",
-		       mtd->name);
+		dev_warn(&mtd->dev, "No memory to scan for FTL on %s\n",
+			 mtd->name);
 		return;
 	}
 
@@ -1057,8 +1043,8 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 
 		partition->state = FTL_FORMATTED;
 #ifdef PCMCIA_DEBUG
-		printk(KERN_INFO "ftl_cs: opening %d KiB FTL partition\n",
-		       le32_to_cpu(partition->header.FormattedSize) >> 10);
+		dev_info(&mtd->dev, "ftl_cs: opening %d KiB FTL partition\n",
+			 le32_to_cpu(partition->header.FormattedSize) >> 10);
 #endif
 		partition->mbd.size = le32_to_cpu(partition->header.FormattedSize) >> 9;
 
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180319174908.GA29619%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
