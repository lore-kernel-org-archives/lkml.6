Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBYGKVPKAKGQES26B56Q@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519052129; cv=pass;
        d=google.com; s=arc-20160816;
        b=C2rnVgtPQ27fjojZhnxGV6ok1nEbo8z70AHVkH5AxMDryx8ZoE2kj5MFW+xmk7ZTwt
         lvjFca4oUIRR4/EEuyCMTrScu7oipA5yL4HLhvUxozm/W5+JAaQx8rL9kEMZuWf0pcS9
         hf1kqFu/AQNiKvopP2Y1x4eGvM/TeQqMB/KJSuowwPP279vFBQpFTJ/0vxesH5myK9my
         S0kChfMM8EtdxJ6MiFW4Y0SJGSAsITZud2JazYXW3XHvN3c/tfOQmzHzy5IKe5lvWobU
         T3VjnvUuHtpMuwPqSq406sVOC5x+3ZRCZcD3Gv64z/Mz8mGhztQ3NOP14ar7+uJxj7ij
         6UlA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=0aBnC8tjtfEmRCwVV5THRx9edgT6MTjC7AMvMWg7ykI=;
        b=C2J2VihijMZh97Qa/zcziZVfmb1LexHDdLobdqOF7JBz+/vya31B7iKjlva2NpS+Vf
         HNz7zbpb1axwhK82tZ6L1YILKHX1dViGlXEobTjKtMnde8rCCoz2FEZp1Rt8wACj+r57
         JpUoenEqRE+lcCmsQ+TnfNRLG3yofzB+ATOCKA29w+VkYE/SIXezL9oqDK1CH2BbPZtC
         oL/IUeDY7DrIhnuYEWRPi9e4gdvw2WbRAZm46f4WTgPPDCkRStcPk9cefhwf5YoyjvdF
         W35TB9Z0uWy8DRoxKh2FfJDVB79Tmb9zU90NdHBj0b5SI+hlkMFhzKuddcBSrq5TYF/F
         nOPQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=evOHeoKt;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbygkvpkakgqes26b56q@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBYGKVPKAKGQES26B56Q@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=evOHeoKt;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbygkvpkakgqes26b56q@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBYGKVPKAKGQES26B56Q@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519052128; cv=pass;
        d=google.com; s=arc-20160816;
        b=wIiB18Gh5a7Na8S+zVIEHmTXaaeXOErSfVgTHLk4xodHVrH+Z1RULnhDamyXo9LUeX
         OaGs4dWYV1fn+sChHZJJc8YVKxvVE6q0HMg47LhQgDTokh+DqWGW5h0DfrCMymODcJP7
         Yw8p0JUYtXt70uiyte5SaQoFaZxu6+4axR4/HqVbwmG9pD+ZwzcGdbkZ+nuYTJQgQF8+
         NQOxZEgAK1qzWCU12jN2aoHfTeYv14V4a8c2WCWo+9VV47YNJViGj3f42yLZjA2sh4SF
         0M8iu6MGtBoJFGrIarFTDt++Rg6f3Ed7/ujWilWaGt+Nhsggxzmpv88xizwVSmV9YKo+
         hm+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=0aBnC8tjtfEmRCwVV5THRx9edgT6MTjC7AMvMWg7ykI=;
        b=LxH7F/akJqd2Gzh7p3NT/RHqvGwYjCOv1EhyBffZgjQT1anQPC9EWH+sG+l3dBOMLp
         qIo9diUHPhAsYsP/G0Q6HkLB1XuJ26aMSU/S3qEYUr2oGfCet/6HzikfA3TEXrlpDApJ
         5bx7keSqafmU8IYdWlx7TZSLP9AmXgBNd9lcOhWfMmUgCJqTpu86an96Bt9GghCi0S+C
         2TvFSRrTbusBnxLOlTH6bsE1baqvYKB3z2UxaQVQyDngoaAa6LuuTDtmfwTpAV/wp49Q
         yEQKhSgq9ONyMBVdKjJOz6pgn4QEl/YGqk28Tv0SBupNXGk274R/bCql5jZ+G/O5V3/J
         DTKw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x224z2l+61nhqFcvGZlG9+BfIoAfVHR04gT2wg01WpU6b4Mie86CuhWqOfRW7DH8sVZWz73Av3w==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519052127; cv=none;
        d=google.com; s=arc-20160816;
        b=nD2M5ufNpZCBQnh5EJw5y0Lgz8BGYAYXjsTeGB51aTLJWR3qRq0M38gDTj8uvAIVwh
         qnjYLPo2vlBqhWkLDk8abD2jdyc9Hhk/zV3mv4upf61RPonVJP7ORq8wrExo/kJiyD6X
         pjXWR5nBbzbOyDRrcRScWENh44B8Jsyjh2yzivDac02RqHIVPFo+CsD8NqME9E1+l4qf
         iZeTOwoJBg0/nmMdM8ynXAynXcHbT+wq3prUdFckeJW0nLJ00ZXi6EsrG8vWP3EBI+cX
         dAPDtDj48KnPPDtZS3n1NCRtc2Z24g0rPFRI42f6NYKUR83VsF6PiYDzFqOdAmveP+Ec
         nR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ozdROVQdU8hvPLb7e16/Hl5jtvzMV++I7JVPnwPr2Rc=;
        b=o3wouWLoeRNOAmkPFwnq1ueBuvbJH1Pn6ROUC7P85sGaeAP6hAycjL34QVsb3mdyqT
         7xab2pVheBbnD+hGHmcRLJbrwrS2HIQ6EvhzoIYTyaYRxoIjeCI9TV94iJDsAiJe/3Dj
         50GtZwcqY+si9K8XnsWG1vL378C+11k9hPzjFN5eq/LCmgNPezC1MUnnqmbQwoN/mhZq
         hxFHN+fQZZb96cC/Ah6DnilYWHwwwpm9453A3Ub2EPJpgmhof4NoJrAIgWHUdy3xTIKt
         sJiENoTgl7JNLCnbzzINZ43K0xbhZ2PiQ1Qn2YoQbYmomqgpd03AX0Ni8rflL6xiCKBy
         AUqw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 19 Feb 2018 15:55:16 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
Message-ID: <20180219155516.7a67fade@bbrezillon>
In-Reply-To: <20180219155115.3d9d1bd5@bbrezillon>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
	<20180219155115.3d9d1bd5@bbrezillon>
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
X-GMAIL-MSGID: =?utf-8?q?1592841605119404989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Oh, and in the subject 'pr_*macro()' -> 'pr_*() macro'

On Mon, 19 Feb 2018 15:51:15 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Hi Shreeya,
> 
> On Mon, 19 Feb 2018 18:43:45 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > The log levels embedded with the name are more concise than
> > printk.
> > Replace printks having a log level with the appropriate
> > pr_*macro.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> > 
> > Changes in v2:
> >   -Merge previous patches of the patchset regarding replacement
> > of printk with pr_*macro, into single patch.
> > 
> > 
> >  drivers/mtd/nand/cs553x_nand.c   |  9 ++---
> >  drivers/mtd/nand/diskonchip.c    | 76 +++++++++++++++++++++-------------------
> >  drivers/mtd/nand/fsl_elbc_nand.c |  2 +-
> >  drivers/mtd/nand/fsl_ifc_nand.c  |  2 +-
> >  drivers/mtd/nand/mxc_nand.c      |  2 +-
> >  drivers/mtd/nand/nand_bch.c      | 12 +++----
> >  drivers/mtd/nand/nandsim.c       | 10 +++---
> >  drivers/mtd/nand/r852.c          |  2 +-
> >  drivers/mtd/nand/r852.h          |  6 ++--
> >  drivers/mtd/nand/sm_common.c     |  5 ++-
> >  10 files changed, 65 insertions(+), 61 deletions(-)
> >   
> 
> [...]
> 
> >  
> > diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
> > index c3aa53c..b97d88c 100644
> > --- a/drivers/mtd/nand/diskonchip.c
> > +++ b/drivers/mtd/nand/diskonchip.c  
> 
> [...]
> 
> > @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct mtd_info *mtd)
> >  			break;
> >  	}
> >  	doc->chips_per_floor = i;
> > -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> > +	pr_info("Detected %d chips per floor.\n", i);  
> 
> Should be pr_debug() here.
> 
> >  }
> >    
> 
> [...]
> 
> > diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
> > index 246b439..4e5f817 100644
> > --- a/drivers/mtd/nand/nandsim.c
> > +++ b/drivers/mtd/nand/nandsim.c
> > @@ -184,15 +184,15 @@ MODULE_PARM_DESC(bch,		 "Enable BCH ecc and set how many bits should "
> >  
> >  /* Simulator's output macros (logging, debugging, warning, error) */
> >  #define NS_LOG(args...) \
> > -	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX " log: " args); } while(0)
> > +	do { if (log) pr_debug(NS_OUTPUT_PREFIX " log: " args); } while(0)  
> 
> You could define pr_fmt() to avoid passing NS_OUTPUT_PREFIX. Something
> like:
> 
> #define pr_fmt(fmt)	"[nandsim]" fmt
> 
> (remember to put this definition before include directives).
> 
> Then, all you have to do is
> 
> do { if (log) pr_debug(" log: " args); } while(0)
> 
> >  #define NS_DBG(args...) \
> > -	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX " debug: " args); } while(0)
> > +	do { if (dbg) pr_debug(NS_OUTPUT_PREFIX " debug: " args); } while(0)
> >  #define NS_WARN(args...) \
> > -	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: " args); } while(0)
> > +	do { pr_warn(NS_OUTPUT_PREFIX " warning: " args); } while(0)
> >  #define NS_ERR(args...) \
> > -	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: " args); } while(0)
> > +	do { pr_err(NS_OUTPUT_PREFIX " error: " args); } while(0)
> >  #define NS_INFO(args...) \
> > -	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); } while(0)
> > +	do { pr_info(NS_OUTPUT_PREFIX " " args); } while(0)
> >  
> >  /* Busy-wait delay macros (microseconds, milliseconds) */
> >  #define NS_UDELAY(us) \
> > diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> > index fc9287a..3d54c6a 100644
> > --- a/drivers/mtd/nand/r852.c
> > +++ b/drivers/mtd/nand/r852.c
> > @@ -935,7 +935,7 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
> >  		&dev->card_detect_work, 0);
> >  
> >  
> > -	printk(KERN_NOTICE DRV_NAME ": driver loaded successfully\n");
> > +	pr_notice(DRV_NAME ": driver loaded successfully\n");  
> 
> Same here:
> 
> #define pr_fmt(fmt)	DRV_NAME fmt
> 
> >  	return 0;
> >  
> >  error10:
> > diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
> > index 8713c57..63de9b6 100644
> > --- a/drivers/mtd/nand/r852.h
> > +++ b/drivers/mtd/nand/r852.h
> > @@ -149,12 +149,12 @@ struct r852_device {
> >  
> >  #define dbg(format, ...) \
> >  	if (debug) \
> > -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
> > +		pr_debug(DRV_NAME ": " format "\n", ## __VA_ARGS__)
> >  
> >  #define dbg_verbose(format, ...) \
> >  	if (debug > 1) \
> > -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
> > +		pr_debug(DRV_NAME ": " format "\n", ## __VA_ARGS__)
> >    
> 
> And here as well.
> 
> Regards,
> 
> Boris
> 



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180219155516.7a67fade%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
