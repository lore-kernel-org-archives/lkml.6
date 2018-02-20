Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBKFLWHKAKGQE7DZ337A@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519146409; cv=pass;
        d=google.com; s=arc-20160816;
        b=NtjfWwTHmlr1wJhJCSkglpzbYdJlvFTh2ALyD4gJ3CcyGYeD9w0B+MONU7bwFHdQqY
         Yc0Dni3U7g7dAsr4w4/a2oMIkO5ki1pqqmqZuN5Hl7QaK3opPMxVgkuLpI1GfRX9xFqw
         sR2JTsDHEwQZHA7uoAaXkeZb6QCuxIhVV3YpBpii5kzqafE7MkrPw8t208Na0O2FEk3U
         mrscdwVGhvPy+8xOYgK+9fhQnNeixfng+prRytFydD4b/Ih0QA9IFYSZwYLHoyt9b9WQ
         YD6XiAUSTUaOCPSxIeFpqFSXvxLzhoQQ/euAb0w5Z0h1EVsDsRNSZ+nSCaZG7jzvPqNy
         t3og==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=XVRxUlz1UHR/HOxeL1SrQYyjYd1gRxj7sz2mKbqGlRw=;
        b=E9nkJjWPLgsecO5dWpGuujXowZAp7NQhy6Mt9gW0MhPhkzlOEZWBpqB7UoK5rRMRBe
         Fd0k/bk88OMw2Dl4nD+AFGuSHaBkh+GDAXSm1aCME1HKPZq6jMq+p/XEo2b8Wzwlsk5I
         DZif2WfESVpeD2TfEMbx1g/0xZHmTEQWWlcnubyISNuAKT37BZajzdyfntQZKGYnyHRj
         RN12anktc2rXbXzJBb1zdp+hb6dFLrs5q33VvmP/d9sp4CYbKOSw64WKjaDi7FsqTiJO
         nEAns2dzeDfdZ6O/Y2vTNl3TFPauA2I5JKQqWlGl6c2DFBCxIraq0N9PfZNri185W3UR
         WQcw==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=g11tkeAa;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vh3UQSxn;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbkflwhkakgqe7dz337a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBKFLWHKAKGQE7DZ337A@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=g11tkeAa;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vh3UQSxn;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbkflwhkakgqe7dz337a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBKFLWHKAKGQE7DZ337A@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519146409; cv=pass;
        d=google.com; s=arc-20160816;
        b=idHCJ8JzxrRlzDef0bzJdnzTIplL46m5eXof/qNh17JNsBW7v8Q1QPcCaUJ6J7zJ6Q
         xyhSuyzlgv+YAqapXA0zJs1KeZq4p9JKfr7u/oOUrUamq9OnReB+u3oVEvew9gysj6+F
         TYGMdlEx7CJpYQbBBbTegBzpOWw5pUKxK01P7StOenW/2Z4Xk/INhHj7kto0IZdEloLK
         3HAtSJx+HWWL82ybk490NU0L5sPajhJYqnApESChnVDUZP7oLRkzbhZZaN4exCpxbUuh
         ZO/z+gKw2981ewHn9Uizje1PyGry7e9iMhLFUlUukPo0y/5zapVbL+4xujBugmikAg/w
         kUIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=XVRxUlz1UHR/HOxeL1SrQYyjYd1gRxj7sz2mKbqGlRw=;
        b=OTL1OL8nOzchtu3AnZHeK9WSwoPYdVe5NvRyo5GAe1DufDZLtHGk9TtU1OTLQMsd+g
         WtswwdUsWtW21SVDdp4CORTFxEPKlxs2gfwy8FB696opqjtNIqD4ZIRlIUmFvenw96mV
         NHRKbAmR3a51BckyVZ6h9DyCQuMFgkTXFFtuX4jMIvzlrcFYzNaJuzfVyzXVc9P19mfM
         pfZe6CVK6TArqnWpw96X6sLokYhLOxMkkcCxfEtKfyVdESAnl7Emfhmjjwfze/3/SIiC
         xmkC39FD0ktSTX26AIRrO5q6xdifGtsN6uC3OS/6kuXVS9h6/iNlrbBjo0jpwzkjJ+c7
         preA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nlyeEs6t;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c01::242 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x224+81+pM0nwG5BDVZ8dfdV+FCEvxBMfEJ21gTfJiQPq1WxbJvc8ci6cOXtI1cxC8AxmveZ70Q==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519146408; cv=none;
        d=google.com; s=arc-20160816;
        b=a16uOJkM7WmJUhf6rU+vm2FCObCCDuRcIFAuorizBPpSNb9VuZnGHHBPn+7s5ejbmb
         6PynPoeiio8poZf0f8fM3rEUEITHu2ASMytLJJkaPmiUpgItw/3D/TSXTK1aVcjAS+Lo
         g53uqxRbqc25AiGIiuMG87ARZnvDBnK/uc37UFXGr8qOzfVnstL0gVaSnwpamcd56MhV
         MgdmEK/4IoGRepMHYWPk5yatUpbnzd5x8qX5BQzpZP8udh+jNgDbFC4295UDiGzR0hpD
         zdichIcabhSpOTnzktra8x1IinbE+1ULrB14hWSfkOrgGPy40Gxf72DaXJYkA8TUB7/L
         NHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=W/bzgEnN3D/AkN8lzxeYXCqhvBS3EmIrzdMG0wnyppQ=;
        b=AP5GZKajI5V8wslb0tEncg3SbY4BQ/ZwCuJKr13Ja+/5ZUGPr1mAuz+TierKl61EY+
         PCXgy1DqWEb3sfzDhpz8RpTVHyWcO5XbmSuALnhCp/sIX3mksim7Ct5FTyhve4EVGFdN
         Am/7e3sj5vJGGInzQkuwCn13kvMWSnJstyne8zNBKjoXaV4EqZcW4eqFCBAZ3NBhpU4N
         Uav2zQGC4H02AYyTdIJgXsVOweUNGs9HxQ8Z1x2UYvUkyGkK+7IcN6gWPN/QTVE4T818
         04fLRGrgKz4Q2XWJKFEgRUeV4TrN/4mv+DaZnO4pGX9nGH6kI78Nrl77hRdgkayvbxbc
         Q2Hg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nlyeEs6t;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c01::242 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Message-ID: <1519146401.12276.4.camel@gmail.com>
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
  computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr,  maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar,  outreachy-kernel@googlegroups.com
Date: Tue, 20 Feb 2018 22:36:41 +0530
In-Reply-To: <20180219155115.3d9d1bd5@bbrezillon>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
	 <20180219155115.3d9d1bd5@bbrezillon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=nlyeEs6t;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:400e:c01::242 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1592835215641943440?=
X-GMAIL-MSGID: =?utf-8?q?1592940465028048002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-19 at 15:51 +0100, Boris Brezillon wrote:
> Hi Shreeya,
>=20
> On Mon, 19 Feb 2018 18:43:45 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
>=20
> >=20
> > The log levels embedded with the name are more concise than
> > printk.
> > Replace printks having a log level with the appropriate
> > pr_*macro.
> >=20
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >=20
> > Changes in v2:
> > =C2=A0 -Merge previous patches of the patchset regarding replacement
> > of printk with pr_*macro, into single patch.
> >=20
> >=20
> > =C2=A0drivers/mtd/nand/cs553x_nand.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A09 ++=
---
> > =C2=A0drivers/mtd/nand/diskonchip.c=C2=A0=C2=A0=C2=A0=C2=A0| 76 +++++++=
++++++++++++++-------
> > ------------
> > =C2=A0drivers/mtd/nand/fsl_elbc_nand.c |=C2=A0=C2=A02 +-
> > =C2=A0drivers/mtd/nand/fsl_ifc_nand.c=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > =C2=A0drivers/mtd/nand/mxc_nand.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A02 +-
> > =C2=A0drivers/mtd/nand/nand_bch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =
12 +++----
> > =C2=A0drivers/mtd/nand/nandsim.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 10 +++---
> > =C2=A0drivers/mtd/nand/r852.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > =C2=A0drivers/mtd/nand/r852.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 ++--
> > =C2=A0drivers/mtd/nand/sm_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A05 ++-
> > =C2=A010 files changed, 65 insertions(+), 61 deletions(-)
> >=20
> [...]
>=20
> >=20
> > =C2=A0
> > diff --git a/drivers/mtd/nand/diskonchip.c
> > b/drivers/mtd/nand/diskonchip.c
> > index c3aa53c..b97d88c 100644
> > --- a/drivers/mtd/nand/diskonchip.c
> > +++ b/drivers/mtd/nand/diskonchip.c
> [...]
>=20
> >=20
> > @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct
> > mtd_info *mtd)
> > =C2=A0			break;
> > =C2=A0	}
> > =C2=A0	doc->chips_per_floor =3D i;
> > -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> > +	pr_info("Detected %d chips per floor.\n", i);
> Should be pr_debug() here.
>=20
> >=20
> > =C2=A0}
> > =C2=A0
> [...]
>=20
> >=20
> > diff --git a/drivers/mtd/nand/nandsim.c
> > b/drivers/mtd/nand/nandsim.c
> > index 246b439..4e5f817 100644
> > --- a/drivers/mtd/nand/nandsim.c
> > +++ b/drivers/mtd/nand/nandsim.c
> > @@ -184,15 +184,15 @@ MODULE_PARM_DESC(bch,		=C2=A0"Enable
> > BCH ecc and set how many bits should "
> > =C2=A0
> > =C2=A0/* Simulator's output macros (logging, debugging, warning, error)
> > */
> > =C2=A0#define NS_LOG(args...) \
> > -	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX " log: "
> > args); } while(0)
> > +	do { if (log) pr_debug(NS_OUTPUT_PREFIX " log: " args); }
> > while(0)
> You could define pr_fmt() to avoid passing NS_OUTPUT_PREFIX.
> Something
> like:
>=20
> #define pr_fmt(fmt)	"[nandsim]" fmt
>=20
> (remember to put this definition before include directives).
>=20
> Then, all you have to do is
>=20
> do { if (log) pr_debug(" log: " args); } while(0)
>=20
> >=20
> > =C2=A0#define NS_DBG(args...) \
> > -	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX " debug:
> > " args); } while(0)
> > +	do { if (dbg) pr_debug(NS_OUTPUT_PREFIX " debug: " args);
> > } while(0)
> > =C2=A0#define NS_WARN(args...) \
> > -	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: "
> > args); } while(0)
> > +	do { pr_warn(NS_OUTPUT_PREFIX " warning: " args); }
> > while(0)
> > =C2=A0#define NS_ERR(args...) \
> > -	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: " args); }
> > while(0)
> > +	do { pr_err(NS_OUTPUT_PREFIX " error: " args); } while(0)
> > =C2=A0#define NS_INFO(args...) \
> > -	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); }
> > while(0)
> > +	do { pr_info(NS_OUTPUT_PREFIX " " args); } while(0)
> > =C2=A0
> > =C2=A0/* Busy-wait delay macros (microseconds, milliseconds) */
> > =C2=A0#define NS_UDELAY(us) \
> > diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> > index fc9287a..3d54c6a 100644
> > --- a/drivers/mtd/nand/r852.c
> > +++ b/drivers/mtd/nand/r852.c
> > @@ -935,7 +935,7 @@ static int=C2=A0=C2=A0r852_probe(struct pci_dev *pc=
i_dev,
> > const struct pci_device_id *id)
> > =C2=A0		&dev->card_detect_work, 0);
> > =C2=A0
> > =C2=A0
> > -	printk(KERN_NOTICE DRV_NAME ": driver loaded
> > successfully\n");
> > +	pr_notice(DRV_NAME ": driver loaded successfully\n");
> Same here:
>=20
> #define pr_fmt(fmt)	DRV_NAME fmt

I am facing the following errors here.



In file included from drivers/mtd/nand/r852.c:22:0:
drivers/mtd/nand/r852.h:148:0: warning: "pr_fmt" redefined
=C2=A0#define pr_fmt(fmt)=C2=A0=C2=A0(DRV_NAME fmt)
=C2=A0^
In file included from ./include/linux/kernel.h:14:0,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/mtd/nand/r852.c:10:
./include/linux/printk.h:287:0: note: this is the location of the
previous definition
=C2=A0#define pr_fmt(fmt) fmt


I tried doing undef and then define, but it didn't work.

>=20
> >=20
> > =C2=A0	return 0;
> > =C2=A0
> > =C2=A0error10:
> > diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
> > index 8713c57..63de9b6 100644
> > --- a/drivers/mtd/nand/r852.h
> > +++ b/drivers/mtd/nand/r852.h
> > @@ -149,12 +149,12 @@ struct r852_device {
> > =C2=A0
> > =C2=A0#define dbg(format, ...) \
> > =C2=A0	if (debug) \
> > -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ##
> > __VA_ARGS__)
> > +		pr_debug(DRV_NAME ": " format "\n", ##
> > __VA_ARGS__)
> > =C2=A0
> > =C2=A0#define dbg_verbose(format, ...) \
> > =C2=A0	if (debug > 1) \
> > -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ##
> > __VA_ARGS__)
> > +		pr_debug(DRV_NAME ": " format "\n", ##
> > __VA_ARGS__)
> > =C2=A0
> And here as well.
>=20
> Regards,
>=20
> Boris
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/1519146401.12276.4.camel%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
