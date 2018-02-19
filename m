Return-Path: <outreachy-kernel+bncBCK63FO5TUHRB36IVPKAKGQEOLGLD4A@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519051888; cv=pass;
        d=google.com; s=arc-20160816;
        b=cbsIwanP1jufZ8f+dc7nnCTdeTI4aHCvrv/DWQM5085O0DGPvCaVxfzoz6VKVEKDsb
         bkol/WwkeAyLffDN5VnOCmKBDla9DbnaVg+s1RqePQijtg5zIKHBz7PzLM6SsIjRa9bw
         Fx/CCi6o6JqdDcbMzW7jwuepNKUgQolxyaTliFedxr3t/nzerI0y55qpmnFYjHjd5HIA
         KUaqbmUD4f69iuyVWz+h0cEAiHXxq9R0AyFmFTfWDnhFeJDPMMJ7nE1YegYQStMGgglB
         9NToStbRlXl/apJ5SFaRLAvYE7BD+bzf9lcXe2ny780PkIjEl+5/9zQrVV3B71aXbvY6
         eU2Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=0DXQcSnZ/N8x2aBRVPZabMnSW0fkGqBCXcW63k4B1w8=;
        b=HAx2/ll8ZXYjayU54/Av2BW9u1nfW+STbjKJB6XrVn6+xl0K7vVFnvQZ9wLG6dKV4k
         JoJm2rpBu8RLrVnr+Yx5RphtzTrXLYHK8EAG8uYsUVv451D65Gez2XWbgPtMEtCtccZV
         Oj2MSlbgFWqjg75DlgzDP2mG0VMsocjwn2HJHxVKsFUfUFv32ebmIcgXNs8shjejfayf
         RfjoGcC1Hf4JarHhSDzBHAPVgB9dXpJgIGOWVuUQv6a9qVADvfO1yfLOK2hKzr4VICxo
         5JuCu65PWIOsAuxJNpVv2mlN5+XK3XlrmEAi0120QLzvg3M3TveEYJgErSRsVUGPv6dm
         SB0Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=cs7xArJ3;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrb36ivpkakgqeolgld4a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRB36IVPKAKGQEOLGLD4A@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=cs7xArJ3;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrb36ivpkakgqeolgld4a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRB36IVPKAKGQEOLGLD4A@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519051888; cv=pass;
        d=google.com; s=arc-20160816;
        b=A99GCuvv1WMYRE1nPEPcotghxc0AcPegPliWAbhJlx+ctqdhUC32f4AEF2sTYCId0q
         DtItDm4s/JGGCwG2oQE1GpvJGc5d7I4s5Lg26IoFHYtdcnXTpXsKkmsDW56rBFlqUxjQ
         XZSPQpN/mYuHX83SBI04DSyls7+mCPqBOKypYXOntukxU8zY8EiyhA3cZKcnKPA3bzjm
         RrjawNM7AovA84ZOv1oFURyX/TP3+utqlCv8oz2BTV5UMdlC+ZYSpbh6WdWaL3o/TQxh
         t2uJ7+sjiPby/X9n5Hp6VrpO6z0Nirkwma5MLjVBSB8D5M7qi8GUsTtRAuW129J/h036
         MENw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=0DXQcSnZ/N8x2aBRVPZabMnSW0fkGqBCXcW63k4B1w8=;
        b=kAvNieRFze9v3nf6aXVG4CM0xK1zvUAe/fBBn+rEd/6lDaAhmqMj+tGxbeAdBPB8v+
         333mHb5crGb5JBIRuOMiRIGLWFcRPjTbtzBb2eyRIjI8wJBKW9m4ItY9PnZaBrfoaHzb
         PhpnbI/0Gx0b3ovtv1vgZHZ82CuABVVsuhC2QgQ/HImuMYIHyQzjTfUyMirgMtkqhEv6
         1b1doVFNSAwx111YlVPF7sCBMWVJQZ6PcebgKD4udieUaNVI9T69fZzVfQvMbA2MRxux
         2hOBCM18JlALyNIaIunk1fRgPZeNYyBzNXB8hDy91b5sldhpyvLn+Iz5fiCFkqRtcFzq
         0hZg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x225duu/RSfWExhkmA0wE7oOfkpPVpsBOjKiLsFVu9PqrhCE8OGsyZ/QGH8Gq+7pB501HhpqjyA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519051887; cv=none;
        d=google.com; s=arc-20160816;
        b=kag46nYaTVnSdKBgkQf9ovPVsYP0OIzaz3bnWOZ7XJxPHVCHWnnRVYeLTtwOSe5QcY
         QGzCzAdYor0sJh/wmp0g8QkCu1kAo2dC/hEOjPw6bKh6Xig2V/CRKb0OoawrPJfap6xE
         a7GKGTo7ez1kfrPhyr/kWiEM/IlkYX5LTUNdIAavcZ7fvJrTA7zZS71lLIuLE/PvWgp3
         gpNysJ1Al/V24/R24SheE9MHqTpBw5JTTjgbjC+x0H10nEkS//anGLFAiSAoLvYbu+xG
         LJWcs4HhcQVqRtnExfq4GfqZFEm9+AD9EHROTZ/o2oj+bRZBK05z7+2/vVGrKp/7G7wE
         U2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=dGiK58+okdu+yoVX1u/6eqIVhlVDniVs2FBrZbmp9Ao=;
        b=xwMUrHSEGjQ4sE3ZWwmNlRW2uygH6j1vUoPlOy1MJcVZKIRar9lLVfKm+F+MRNB83G
         Ct26dOL5VkT7QG7stB9shxeyr10d6SechIebQ7FEmH219vSOJXYLu1YftEPxf89+/LHc
         b2yoRGX5BgylBGZOJJNGRlKJt0SJFEXFnuhkbncCPr18mVVBn+ytQwk4+pFRDLgRP59O
         CWDYbJ9KgFKxF9FD5/uPnjKcUIcyrrkRGtRp5dwRoGmTJXKkYMasxZJ58Exi6I2cIsJ0
         /1Xb6+mWwjiJMXjuH9V/LOBNlTRS1jVAB9qC+iZen3cdx3Q7+0WFHMB1IipPSzhCc/gu
         klYw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 19 Feb 2018 15:51:15 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
Message-ID: <20180219155115.3d9d1bd5@bbrezillon>
In-Reply-To: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1592835215641943440?=
X-GMAIL-MSGID: =?utf-8?q?1592841352829331380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Shreeya,

On Mon, 19 Feb 2018 18:43:45 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> The log levels embedded with the name are more concise than
> printk.
> Replace printks having a log level with the appropriate
> pr_*macro.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
> 
> Changes in v2:
>   -Merge previous patches of the patchset regarding replacement
> of printk with pr_*macro, into single patch.
> 
> 
>  drivers/mtd/nand/cs553x_nand.c   |  9 ++---
>  drivers/mtd/nand/diskonchip.c    | 76 +++++++++++++++++++++-------------------
>  drivers/mtd/nand/fsl_elbc_nand.c |  2 +-
>  drivers/mtd/nand/fsl_ifc_nand.c  |  2 +-
>  drivers/mtd/nand/mxc_nand.c      |  2 +-
>  drivers/mtd/nand/nand_bch.c      | 12 +++----
>  drivers/mtd/nand/nandsim.c       | 10 +++---
>  drivers/mtd/nand/r852.c          |  2 +-
>  drivers/mtd/nand/r852.h          |  6 ++--
>  drivers/mtd/nand/sm_common.c     |  5 ++-
>  10 files changed, 65 insertions(+), 61 deletions(-)
> 

[...]

>  
> diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
> index c3aa53c..b97d88c 100644
> --- a/drivers/mtd/nand/diskonchip.c
> +++ b/drivers/mtd/nand/diskonchip.c

[...]

> @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct mtd_info *mtd)
>  			break;
>  	}
>  	doc->chips_per_floor = i;
> -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> +	pr_info("Detected %d chips per floor.\n", i);

Should be pr_debug() here.

>  }
>  

[...]

> diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
> index 246b439..4e5f817 100644
> --- a/drivers/mtd/nand/nandsim.c
> +++ b/drivers/mtd/nand/nandsim.c
> @@ -184,15 +184,15 @@ MODULE_PARM_DESC(bch,		 "Enable BCH ecc and set how many bits should "
>  
>  /* Simulator's output macros (logging, debugging, warning, error) */
>  #define NS_LOG(args...) \
> -	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX " log: " args); } while(0)
> +	do { if (log) pr_debug(NS_OUTPUT_PREFIX " log: " args); } while(0)

You could define pr_fmt() to avoid passing NS_OUTPUT_PREFIX. Something
like:

#define pr_fmt(fmt)	"[nandsim]" fmt

(remember to put this definition before include directives).

Then, all you have to do is

do { if (log) pr_debug(" log: " args); } while(0)

>  #define NS_DBG(args...) \
> -	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX " debug: " args); } while(0)
> +	do { if (dbg) pr_debug(NS_OUTPUT_PREFIX " debug: " args); } while(0)
>  #define NS_WARN(args...) \
> -	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: " args); } while(0)
> +	do { pr_warn(NS_OUTPUT_PREFIX " warning: " args); } while(0)
>  #define NS_ERR(args...) \
> -	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: " args); } while(0)
> +	do { pr_err(NS_OUTPUT_PREFIX " error: " args); } while(0)
>  #define NS_INFO(args...) \
> -	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); } while(0)
> +	do { pr_info(NS_OUTPUT_PREFIX " " args); } while(0)
>  
>  /* Busy-wait delay macros (microseconds, milliseconds) */
>  #define NS_UDELAY(us) \
> diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> index fc9287a..3d54c6a 100644
> --- a/drivers/mtd/nand/r852.c
> +++ b/drivers/mtd/nand/r852.c
> @@ -935,7 +935,7 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
>  		&dev->card_detect_work, 0);
>  
>  
> -	printk(KERN_NOTICE DRV_NAME ": driver loaded successfully\n");
> +	pr_notice(DRV_NAME ": driver loaded successfully\n");

Same here:

#define pr_fmt(fmt)	DRV_NAME fmt

>  	return 0;
>  
>  error10:
> diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
> index 8713c57..63de9b6 100644
> --- a/drivers/mtd/nand/r852.h
> +++ b/drivers/mtd/nand/r852.h
> @@ -149,12 +149,12 @@ struct r852_device {
>  
>  #define dbg(format, ...) \
>  	if (debug) \
> -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
> +		pr_debug(DRV_NAME ": " format "\n", ## __VA_ARGS__)
>  
>  #define dbg_verbose(format, ...) \
>  	if (debug > 1) \
> -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
> +		pr_debug(DRV_NAME ": " format "\n", ## __VA_ARGS__)
>  

And here as well.

Regards,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180219155115.3d9d1bd5%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
