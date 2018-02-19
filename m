Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBXGSVPKAKGQEI3QUTMA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519053148; cv=pass;
        d=google.com; s=arc-20160816;
        b=lRHSosW9hoyiS/3tbK+wXnSyETgv6rta+bHZVySaPIWaiI0rMPJTKNfaP++NYcJ0k7
         TY55zJBRorQUQrbquSc/DIRBLiRqSBm75AsSnzW1fySh39C1E8YXmrqOaSwY2Onm8tmd
         9xW6BsDYFxqAKkMgMSR47vBThtB0DH0A5uEjYuBF0xffDumvMcPhgXNfG0CfiGwp65Jt
         EXnRJr3AniKAJw1LM1UA2iQa8KohH0BWV6B+ZgXGVm+WlmLznqmPUELTh3FdBHbYVRUv
         rU/X1qRxU+B6TJPdPdhUTeI8IJCx4GJXryKGtGEu3UOLhDUYGpL0M8WYfgfgLjDSbBKl
         Xyow==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=FM0DFBRNHrtqlsw/ZOdejvN8g72vRUhhmHqO/rdadIU=;
        b=tMzUHlVYB9wyfPHk9p84gKjV3NE+sf83SY40mSnze2zUF0yOGccZO6g2+q2tzZxpCV
         ywXUtVttkhro1KQO16sZJkCa+77Jah+MyifWXUJuk6lNAaAEHLeefKC5Ia59Ag5VzYPv
         zbwNXBwMlVZgU+ouea2S3x5GDs9v3av6Y4NpyF5OCWxb9pTJs13+FJ4eDsdCDuz2oI0c
         CvZNZ9pXQkjMz4reR9xekt7eKjSqdFJEdr4dwwBwgyq8/DVcT0D3uqlonrqFG/VbnQTm
         KPBOe9dAzZnEMugqVTufU4ELstXGZKoYEXhRg6DUpVDDAKn7+H+B7zaignEdy5wPIfQj
         PkOA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=DBLGusae;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbxgsvpkakgqei3qutma@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBXGSVPKAKGQEI3QUTMA@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=DBLGusae;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbxgsvpkakgqei3qutma@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBXGSVPKAKGQEI3QUTMA@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519053148; cv=pass;
        d=google.com; s=arc-20160816;
        b=GSI4kiGMUFczAT7ZgRcrkSk9/7OU7CMbgQtDyrK21i0EjO26kqmbVtR6PdBzq3uSec
         aivIDiQmDZQCioKs0ZKaCJTYIOx2RCaF4JpPSH2IKtiqInbVZOPqAGgOhXKZceFN6drf
         /n8G7hxYLjPsrvsb6QT20DQ3IOBtFBHCxChoHv9PWKg4DgKEBfXzVQgrc7uYuNpd+2x1
         6++7Ab0nnHsKsFJNonx6kqGEmjGShPNmAreyQqO5uN8HTB7AI/KuP3wKNPN9oCB1D2XT
         KdGHxMX28N9lwLR+OL+k5fQmu5ZRGmgCmDaa+59mxsgzunE5I06LFKUi+F81ckrTxyh1
         q0Og==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=FM0DFBRNHrtqlsw/ZOdejvN8g72vRUhhmHqO/rdadIU=;
        b=VgQ0VWEbPpHsjBoae5kX6BJXsjKMk0RXP02DiiR2D6l1yrbehP+b9cn+B+mWuDFItS
         TwlOYVCWqRzNGtYcL/gqvKh6xpMopO6ykqq7ldu8YiROLpFDXEs3sI5vOXm8sm1fqVfk
         GbFNDom6E2akm5YcOppJcZ9ET0yt3oYToTkeQjRItvwiikBx2GVMqS+XxVjFaJERWvKb
         M9oOaiozybBMCUvvYZh1ohCXTd6PPxIhA/J5Vq57VeLTj4VqnPMks8OMFEl9P4+5mFlp
         lPs4T7kQ/qWgwddBV5wqhn7ja5HRCVE2rlKjOGQU3vTAO+AK+DOovnWxUAJdqmbR65ut
         ulBw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x2260yZIQ0s8jiOqKNfP9oRd9RF83Qn2VBU7YOW1NYzVxGUiR2MNwrQqYbMbxzo/9NQssV13Oyw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519053147; cv=none;
        d=google.com; s=arc-20160816;
        b=mEF+8EQz+2BVkz5+tpt5fQyCBaCRrZ8RBp1llgsexVW7oMjqSo4H40VN9mTnvbQnbZ
         39irnBtPs94ot1wOr425LKWU1KQtrRI5Ok8dLTWmtaRp1Z1jyTVMBoWFuRrWJmDy5Tb9
         1kWPQhhzpAJCgHWLSczmNb3xl0BS3dm9MGYJF9Qk4SN38UZ6Yww842kkkvPqZ/Hp6f0o
         XCyUp0icpxWxUe2b3AYlMHvZNjiP5shdlL5M8VnrFylroUu80vGcHi14Rwr6A55SVhTc
         evK+hmodvnXICl1o0SCTV+Q11VDanT8MIXd/jylO+tMc3RnQ0GD+PbrCeSz27Z2NC8Gx
         ZpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=19YqIVYYnBAabU6VbqoTrDsCbIi6r5Sa467R0HyVEoA=;
        b=tq+Yn2SyU7tQCEW0GAOFYKXytEt4UACXiZc3Yk7PRZljTRCJ+VsD8QT2TzMWuwT8G7
         CPcS/ysg0Tf7KdH+0ykq9a6umkc4mFx453Y5nCZzclEQQOZXJvME0LDGlE5FALo04dRy
         LrULskbWfvPXxNrvWsAkpbogSFNfo8NIRxvt+q81hD3oEqT6LRFpHe34pqJxkJuJuqal
         kd7y41gJAWjJGs8MvnTvcVRRGbLi4AbPVvWogmvctHjEYjMfzuonglgcNRRNaJkt9/Uk
         FS4O6ngfPqms0or7VuVLbyiJj8pweSk/13txorGH/ODUKN2R6jr6mfRZWoRVtCDBHbK/
         T4+w==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 19 Feb 2018 16:12:16 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND] mtd: nand: Replace printk() with
 appropriate dev_*macro()
Message-ID: <20180219161216.4f3ec2f3@bbrezillon>
In-Reply-To: <1519046339-9678-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519046339-9678-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: boris.brezillon@bootlin.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as
 permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
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
X-GMAIL-MSGID: =?utf-8?q?1592842674935670159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Feb 2018 18:48:59 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Replace printks having a log level with the appropriate
> dev_*macro.
> Also, use pdev->dev as it is guaranteed in each case to be
> properly initialized when passed into dev_*macro().
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/mtd/nand/ams-delta.c | 6 ++++--
>  drivers/mtd/nand/cafe_nand.c | 5 +++--
>  drivers/mtd/nand/sh_flctl.c  | 2 +-
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
> index dcec9cf..2419ca8 100644
> --- a/drivers/mtd/nand/ams-delta.c
> +++ b/drivers/mtd/nand/ams-delta.c
> @@ -185,7 +185,8 @@ static int ams_delta_init(struct platform_device *pdev)
>  	/* Allocate memory for MTD device structure and private data */
>  	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
>  	if (!this) {
> -		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
> +		dev_warn(&pdev->dev,
> +			 "Unable to allocate E3 NAND MTD device structure.\n");
>  		err = -ENOMEM;
>  		goto out;
>  	}
> @@ -219,7 +220,8 @@ static int ams_delta_init(struct platform_device *pdev)
>  		this->dev_ready = ams_delta_nand_ready;
>  	} else {
>  		this->dev_ready = NULL;
> -		printk(KERN_NOTICE "Couldn't request gpio for Delta NAND ready.\n");
> +		dev_notice(&pdev->dev,
> +			   "Couldn't request gpio for Delta NAND ready.\n");
>  	}
>  	/* 25 us command delay time */
>  	this->chip_delay = 30;
> diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
> index bc558c4..51f58ea 100644
> --- a/drivers/mtd/nand/cafe_nand.c
> +++ b/drivers/mtd/nand/cafe_nand.c
> @@ -773,8 +773,9 @@ static int cafe_nand_probe(struct pci_dev *pdev,
>  		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
>  		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
>  	} else {
> -		printk(KERN_WARNING "Unexpected NAND flash writesize %d. Aborting\n",
> -		       mtd->writesize);
> +		dev_warn(&cafe->pdev->dev,
> +			 "Unexpected NAND flash writesize %d. Aborting\n",
> +			 mtd->writesize);
>  		goto out_free_dma;

I see plenty of printk()s (or pr_xxx()s if this patch is applied after
the printk() -> pr_xxx() replacement) that are not converted to
dev_xxx() in this driver. If we start using dev_xxx() it should be used
consistently.

How about we convert all printk()s to pr_xxx()s first (what you do in
your first patch), including those you convert to dev_xxx() here, and
then we consider patching some of the drivers to use dev_xxx() instead
of pr_xxx().

>  	}
>  	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
> index e7f3c98..c534c49 100644
> --- a/drivers/mtd/nand/sh_flctl.c
> +++ b/drivers/mtd/nand/sh_flctl.c
> @@ -877,7 +877,7 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  			else if (!flctl->seqin_column)
>  				execmd_write_page_sector(mtd);
>  			else
> -				printk(KERN_ERR "Invalid address !?\n");
> +				dev_err(&flctl->pdev->dev, "Invalid address !?\n");
>  			break;
>  		}
>  		set_cmd_regs(mtd, command, (command << 8) | NAND_CMD_SEQIN);



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180219161216.4f3ec2f3%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
