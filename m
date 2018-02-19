Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBSE5VPKAKGQEKOAR6RI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519046345; cv=pass;
        d=google.com; s=arc-20160816;
        b=IPrV3fdDZFflPWtSJpesvKD41Lt29Vf4q/C3or07Y8zZhWkTj0aKiRydW8B3xqvR16
         GD1sp4T4EzEPM3NrPUe4Vjx+cU36c0zfn0tI9HEF0iULs3VIrYogrrRK/6jIb8hVqRNG
         9gIIpjNj+ANQ+5CcuTMTNMZfkbaPdm0FM8Nvrr7hCBn+pYukk1mX/Vu5mOBPiSVWDx3d
         Xhx0LSLXi8X8TVJCXdyGzo9rS45jj/rsNuK6h5Dh2DRouVs0Gy4hWr9sZ0RF3IuQrZpM
         FCBK6znilyKACczJOvFZ1jAG4LXuaGAWG4FITctY+CBHqC0CvupHLP1wC29AOSpYUeed
         hFBg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:mime-version
         :sender:dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=ZzTqqYweGXuQDYNky5J7lPum2AaUp2pF4GZeEfAbTF8=;
        b=FFIhZcmqafrzOxNOlCPzXSKdwONBdWYJfA68Q8JOIxUcWpZV0xI3PJaeFtWJ3ivKdH
         1iSgutSWrNYYD/tBU9EI0qc8q3sKnCGX4rdTj/e89FazbO4hIjHJTSEZze/k/TOiRJzE
         LqJdBQC7XT/+ruwboRy/AwUJqrAsdg45IB6Sca0sysrBM2qu9ST8MgJr0Scbi4a5WGWY
         qUJHTQ00RY17bUSZNs4g1vFs2o0w0OlxjsehspdjeYTcaNPND71UHl0E0l+F63pNZKUK
         dTQtVqpySLz/42LlDe6laXhxe2kZU8Tafky49wHC1TTnp6d7YV70ZnprhYQvCaRTjXJQ
         2Gqg==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=PqoYlsX5;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f/y+2jqr;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbse5vpkakgqekoar6ri@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBSE5VPKAKGQEKOAR6RI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=PqoYlsX5;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f/y+2jqr;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbse5vpkakgqekoar6ri@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBSE5VPKAKGQEKOAR6RI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519046345; cv=pass;
        d=google.com; s=arc-20160816;
        b=LPRAtN9Lli+LT5iieUCv0US5cWBz4Epdaml4cdAotD+kLWTU9pnE1ZWREQ9LxvGUtt
         WvJKarELEDRkkrch3OnTv1HiWprHEFr7rYxvPoPtVT4/kC/uEBwNUkpKEYswOIUUwWpx
         Qe9rqNYKyN5n75lGGaBRpGPrlE9alye6Gpxr2q1d/zkFNOhNQyGSe8R8weBDFzbcU0od
         5AXjp+ThQIYwmMXvso8WQRy1Jn3rPV2jEqXSB1dGpuUHKqom9pUsfJe2HS6seYwWgCYe
         ffjkAao7ONLvHz3rhtPzDuzQvg3mSphGX1+xQzLS/iEjR5HXqjjpbcDrVIf1akjPGqqv
         rHMQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:mime-version
         :sender:dkim-signature:dkim-signature:arc-authentication-results;
        bh=ZzTqqYweGXuQDYNky5J7lPum2AaUp2pF4GZeEfAbTF8=;
        b=Jj2Qf9hOTJogjoYuOn1Wzl98RzU3MvkBTIfoQUSewh18oK4XHOvZFcfoe1PPF+JP40
         70wx/Gdy5AL3j9uUVFj3pXCxne7aoGgGhwcKytQN311z+u7bwDIulRfLCUZD4plbMLCA
         kFw670BrML4kUxTTjK5AdjNqIHDRkSTRB/iWwOjDH6/2WxB8DhJFOIon5JUc5ZZB1ayF
         hz1WvT9iaoH1sl+WGa2ueysYem++dCIA/tS9Gf5OgQos720R6/is4Zba3Bq3tQGQQsuw
         DKiLmkgW+I/ByWaMcGUrdzN9xlAbfiO4yFhuTUtzVFm6sDaKUQ+UROiTZh/X11zDZzJt
         /Fog==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pdaROg9n;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c00::244 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x2261hT1xe9MSMOrq4N0CodcaAP68j++/p9u8LubhZODdDALZYBQ3YQcJWvdhjsyaAhMKONOxXg==
MIME-Version: 1.0
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519046344; cv=none;
        d=google.com; s=arc-20160816;
        b=Bk90eENqDt1udVmzkyvTb/bLTE5YnsehXa/oI4vxzM63yNbDD5AzAqDq0+ltvaM3A3
         o0Vq17zaBaJS5fV4cfNcMN9Z10GpIc071YWT3GFFf7jCmOiCOS0SM/NesdwUmLBd5zRu
         u+//ednpgxu24Bf1uCvPKN5YFrbeKUL34UEnefLPlZFQ/cD9I/PUk/sulhdlA0UrWvBe
         KG3e+axXU9tSTp8bmF0Pgx4CiXAiTsHfU72YC3Ock8BpZerqrePpLmix2CSMZQpQXf7s
         w2wa7h7a6ju50G94XEKQxrat+36TbhK1M7eKJ2KAnz/6n+SFtafkBQNYSKrPUGxmuOu8
         uBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Q+gHhwLPC77JwOOyhZIll9Mi9ebJzOBjJ2I//E41Re0=;
        b=q/v7li5UXZaNF8g06v8PlaYH9VhNo2CYgthqrEpRQcMivrPbhnhZMbHSGbkgZLlG+T
         P0VaA4vaJn3t5+cI7rFDY4AhsN4ryvOT90VssBIQ6lsZsRrhWYxRBYs4YHLWgXQlNGah
         yU4UEkVy3NBW3SSNn60Ayjei1zx5LIPIowpbVCe+Yuj4WdwmmDH8o/EUhKAalTMRiMLx
         2JQhOofr5WcRAiRFyedEMmeBhYHGw5PB0N3LjteW5bS5t4r1Mb4AJFcH9nCyswXZntqv
         tyTg/uDCMpIinqoER8+Iu6/OKg4HZl26+z1v1PoT777itOQAm4K1zC5HMZY4hPh9XNnV
         TR6w==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pdaROg9n;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c00::244 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
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
Subject: [Outreachy kernel] [PATCH NAND] mtd: nand: Replace printk() with
 appropriate dev_*macro()
Date: Mon, 19 Feb 2018 18:48:59 +0530
Message-Id: <1519046339-9678-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=pdaROg9n;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:400e:c00::244 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1592835541004507758?=
X-GMAIL-MSGID: =?utf-8?q?1592835541004507758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace printks having a log level with the appropriate
dev_*macro.
Also, use pdev->dev as it is guaranteed in each case to be
properly initialized when passed into dev_*macro().

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/mtd/nand/ams-delta.c | 6 ++++--
 drivers/mtd/nand/cafe_nand.c | 5 +++--
 drivers/mtd/nand/sh_flctl.c  | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index dcec9cf..2419ca8 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -185,7 +185,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	/* Allocate memory for MTD device structure and private data */
 	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
 	if (!this) {
-		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
+		dev_warn(&pdev->dev,
+			 "Unable to allocate E3 NAND MTD device structure.\n");
 		err = -ENOMEM;
 		goto out;
 	}
@@ -219,7 +220,8 @@ static int ams_delta_init(struct platform_device *pdev)
 		this->dev_ready = ams_delta_nand_ready;
 	} else {
 		this->dev_ready = NULL;
-		printk(KERN_NOTICE "Couldn't request gpio for Delta NAND ready.\n");
+		dev_notice(&pdev->dev,
+			   "Couldn't request gpio for Delta NAND ready.\n");
 	}
 	/* 25 us command delay time */
 	this->chip_delay = 30;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index bc558c4..51f58ea 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -773,8 +773,9 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
 		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
 	} else {
-		printk(KERN_WARNING "Unexpected NAND flash writesize %d. Aborting\n",
-		       mtd->writesize);
+		dev_warn(&cafe->pdev->dev,
+			 "Unexpected NAND flash writesize %d. Aborting\n",
+			 mtd->writesize);
 		goto out_free_dma;
 	}
 	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index e7f3c98..c534c49 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -877,7 +877,7 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			else if (!flctl->seqin_column)
 				execmd_write_page_sector(mtd);
 			else
-				printk(KERN_ERR "Invalid address !?\n");
+				dev_err(&flctl->pdev->dev, "Invalid address !?\n");
 			break;
 		}
 		set_cmd_regs(mtd, command, (command << 8) | NAND_CMD_SEQIN);
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1519046339-9678-1-git-send-email-shreeya.patel23498%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
