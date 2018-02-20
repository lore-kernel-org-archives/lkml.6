Return-Path: <outreachy-kernel+bncBCK63FO5TUHRB5XJWHKAKGQEPWWUSOY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519154422; cv=pass;
        d=google.com; s=arc-20160816;
        b=AaYd5/FkdYXgNYyGqxG/GERPJfJN/mPcr5hNs1sR3YcDbcx1uV/yvhUuj7sem5D9vG
         ZuKy5tmSxtY/JMXOZ5Omn0b98gx99C0BEFQnGOKPJf0Uw+ohc64mSFWeiKYGnhv5N28P
         f/CoZuVG2cyb+JDqd5sF0oyQuoWHhpCZdeFnqFPHVHKVNWr/6L+a4xdLypALLeHrlETD
         1c0rcy5p2QsEI0/GklkMq8csyEatiE6sWpnHJiz0UlIS/yE8wTJyznRizlB/6GOYWabA
         gnOcgA2xN4dX3J4oSkb7k3kmqOYXiDoQpaVF+XN+gc+IzlIBeh30kGal1jD2lnUn8L0R
         cEpQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=SBemLA5vS7Dr/E+KGpTm9+bNsQA/qrL3J1RUoETgToc=;
        b=jEtUjfaz7g2NbRaX0WV8DU+BjU513P450smD9Bk08YQouhbgHm7tFNOpowo7Zxm8TR
         jOJ3gzE2oZo+xQKoLP1KHEVfQyaAdEIJUh7cCdYCzEEh1Mmgl3w0cwNP6MRRqsQNpPAB
         7vLdPN0+vcm+6H8yieAXu6Lc637Jqb50FcyFF5tbu7dAEAIS3Ws35GSzNPL6Li118hrf
         dOaH/6HMApAklwYcwhNPb8Im8uAxFrFfgA7MS1SMtztHNiZT/kPFoZq3MOoABpSV4rJ2
         hijplCNY5JzRWLGzExdPl0ZLGFFGmSknCrL8LJzQVOK4XTdqBj5JB3G4KrmP/1x/FcFE
         F0pA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Ui5ZKOtV;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrb5xjwhkakgqepwwusoy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRB5XJWHKAKGQEPWWUSOY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Ui5ZKOtV;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrb5xjwhkakgqepwwusoy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRB5XJWHKAKGQEPWWUSOY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519154422; cv=pass;
        d=google.com; s=arc-20160816;
        b=Nu9cUn8R35xIdoHhFBRomlUCPHS/mv6E3Pvc5E5TABDJklc8kwk0d2DgNHSfgok4RZ
         qONqdAi5FwYZQTvaJMqWiRFcDbgFqZzETcEjikhR3805Q/wl6eDEaNdTK33JNCU9dyP5
         v5fadd7lq20ahHdDfV7f4upR8EvmoffJ7fRoqudROXJgrlIX6z+PZfhBawDXAAInp0Fd
         KgJAjeDlBSkFfKuNBd+8r/X6eerPhmG3AbnT6xTQLnqtoLMcpTJtMTqzsbe77/njPsKx
         h+7jY35B7NSaV5m68LLkwC2b3U3Vu39Pq5968wj7SOTVBsugvE2+G8NJc2PQ8MgwZ/SJ
         rnMw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=SBemLA5vS7Dr/E+KGpTm9+bNsQA/qrL3J1RUoETgToc=;
        b=BwsemeFJhkdTwdl60W4TvunmWlhcpTCCahky4fFktF4hyol+gWjdD+7P3TXhgJjnuz
         DqfLnYlMkfakXUswEwdNU8AGQYQSC8dhKSEEKOIB3jD7SDVkL3t1Y+6/+10HkibvUw0J
         6eI8LwZEyKU13O7ejmJYOoEAhuXvpPQwcFmW37z4mBTKspznT45TlUwYgkpzifLUGPHl
         Vd83sKNhvFE5XmU9yZnAowGfE5jucKq+jjZ+mE8XxcHHXOiHaB/u+oEDxAp246CRATjr
         EocXmgEwx9+ULEkzx3V145BsNDHYWJrh+dlBK2rz3LFq0r80qJJQOmkzLjkZR2/4uPLS
         kMpA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x226Spw8XFK7GQSiPmVsH4BB6Vdr41uj8ID5uN1X5zAcIaqqTeWWoUaMKi542z8z299ARrTHxRQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519154421; cv=none;
        d=google.com; s=arc-20160816;
        b=X1o20KUGC/XhaeJTRjdZ2smLtl+4HdUY+phAAl2g8bPLURuWbJ8LRywZn0APzUHxFa
         YWJSoRY4ZSfcUDGk7MHUUSfs5xiYwGqN997EI4E4FI9EqayuYXpFiuuyNwGPyYj6Odjo
         gpuX7Ep6Yq90mhceYfudgUIhO59GLdBjvbdy/7koeV9HjEGjFua005HDEgb6QmuqXbGv
         1XWUMOaZ+NJAM1OSaabiqnu/dLwthvvdXAmS/AsqxCqU2cvBsqvPQNvznAlt4PL1xvpa
         7DcP95wDbdeOZQ80i0G44k7pIYrr0V27kiwXZ9qptwvoAoOTlDIPercVd4ACDhe0f4an
         Qmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=GFfwZSQQAFELIP8h4zi+j425q17Kcn3N2OIV+jiA+38=;
        b=Z+cDecJzqTLaWYXvLFQcq54dsGT2Ae7qRCg1NDnOYGJ03hCGZuEzrZ9HwpHZLXWIiO
         uAQyR6iO8ZLBEUqKntDvALJR8JZTD4TrVQT1WQQrQZ16uxBjZ+uCxFovtln+xUrHTQfV
         ElwEIyowNpZJWrXt+fGEHLMC2n+C5VVFx6QO3Ys7dWuEk46Z6vVg5tcy+V8CaAGRjwj5
         q0wNgfosHLWn5VKM9BAJjDk6j/1GpPQmK04yVHujRSDlHjcbRiM+4Nm/um6+In1hxKXq
         oZ2Y+Gh7iXo899DhA1pUFIB2c8JN5rPburxd3/lAPJsl3VSD1tDvK2qOFZw5mU5R1wle
         MV/A==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Tue, 20 Feb 2018 20:20:08 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
Message-ID: <20180220202008.4a67d0e9@bbrezillon>
In-Reply-To: <1519148238.14621.3.camel@gmail.com>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
	<20180219155115.3d9d1bd5@bbrezillon>
	<1519146401.12276.4.camel@gmail.com>
	<20180220181647.6f2367b6@bbrezillon>
	<1519148238.14621.3.camel@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-GMAIL-MSGID: =?utf-8?q?1592948868286161115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 20 Feb 2018 23:07:18 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Tue, 2018-02-20 at 18:16 +0100, Boris Brezillon wrote:
> > On Tue, 20 Feb 2018 22:36:41 +0530
> > Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> >  =20
> > >=20
> > > On Mon, 2018-02-19 at 15:51 +0100, Boris Brezillon wrote: =20
> > > >=20
> > > > Hi Shreeya,
> > > >=20
> > > > On Mon, 19 Feb 2018 18:43:45 +0530
> > > > Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> > > > =C2=A0=C2=A0 =20
> > > > >=20
> > > > >=20
> > > > > The log levels embedded with the name are more concise than
> > > > > printk.
> > > > > Replace printks having a log level with the appropriate
> > > > > pr_*macro.
> > > > >=20
> > > > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > > > ---
> > > > >=20
> > > > > Changes in v2:
> > > > > =C2=A0 -Merge previous patches of the patchset regarding replacem=
ent
> > > > > of printk with pr_*macro, into single patch.
> > > > >=20
> > > > >=20
> > > > > =C2=A0drivers/mtd/nand/cs553x_nand.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A09 ++---
> > > > > =C2=A0drivers/mtd/nand/diskonchip.c=C2=A0=C2=A0=C2=A0=C2=A0| 76 +=
++++++++++++++++++++---
> > > > > ----
> > > > > ------------
> > > > > =C2=A0drivers/mtd/nand/fsl_elbc_nand.c |=C2=A0=C2=A02 +-
> > > > > =C2=A0drivers/mtd/nand/fsl_ifc_nand.c=C2=A0=C2=A0|=C2=A0=C2=A02 +=
-
> > > > > =C2=A0drivers/mtd/nand/mxc_nand.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A02 +-
> > > > > =C2=A0drivers/mtd/nand/nand_bch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0| 12 +++----
> > > > > =C2=A0drivers/mtd/nand/nandsim.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 10 +++---
> > > > > =C2=A0drivers/mtd/nand/r852.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > > > > =C2=A0drivers/mtd/nand/r852.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 ++--
> > > > > =C2=A0drivers/mtd/nand/sm_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A05 ++-
> > > > > =C2=A010 files changed, 65 insertions(+), 61 deletions(-)
> > > > > =C2=A0=C2=A0 =20
> > > > [...]
> > > > =C2=A0=C2=A0 =20
> > > > >=20
> > > > >=20
> > > > > =C2=A0
> > > > > diff --git a/drivers/mtd/nand/diskonchip.c
> > > > > b/drivers/mtd/nand/diskonchip.c
> > > > > index c3aa53c..b97d88c 100644
> > > > > --- a/drivers/mtd/nand/diskonchip.c
> > > > > +++ b/drivers/mtd/nand/diskonchip.c=C2=A0=C2=A0 =20
> > > > [...]
> > > > =C2=A0=C2=A0 =20
> > > > >=20
> > > > >=20
> > > > > @@ -438,7 +438,7 @@ static void __init
> > > > > doc2000_count_chips(struct
> > > > > mtd_info *mtd)
> > > > > =C2=A0			break;
> > > > > =C2=A0	}
> > > > > =C2=A0	doc->chips_per_floor =3D i;
> > > > > -	printk(KERN_DEBUG "Detected %d chips per floor.\n",
> > > > > i);
> > > > > +	pr_info("Detected %d chips per floor.\n", i);=C2=A0=C2=A0 =20
> > > > Should be pr_debug() here.
> > > > =C2=A0=C2=A0 =20
> > > > >=20
> > > > >=20
> > > > > =C2=A0}
> > > > > =C2=A0=C2=A0=C2=A0 =20
> > > > [...]
> > > > =C2=A0=C2=A0 =20
> > > > >=20
> > > > >=20
> > > > > diff --git a/drivers/mtd/nand/nandsim.c
> > > > > b/drivers/mtd/nand/nandsim.c
> > > > > index 246b439..4e5f817 100644
> > > > > --- a/drivers/mtd/nand/nandsim.c
> > > > > +++ b/drivers/mtd/nand/nandsim.c
> > > > > @@ -184,15 +184,15 @@ MODULE_PARM_DESC(bch,		=C2=A0"En
> > > > > able
> > > > > BCH ecc and set how many bits should "
> > > > > =C2=A0
> > > > > =C2=A0/* Simulator's output macros (logging, debugging, warning,
> > > > > error)
> > > > > */
> > > > > =C2=A0#define NS_LOG(args...) \
> > > > > -	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX "
> > > > > log: "
> > > > > args); } while(0)
> > > > > +	do { if (log) pr_debug(NS_OUTPUT_PREFIX " log: "
> > > > > args); }
> > > > > while(0)=C2=A0=C2=A0 =20
> > > > You could define pr_fmt() to avoid passing NS_OUTPUT_PREFIX.
> > > > Something
> > > > like:
> > > >=20
> > > > #define pr_fmt(fmt)	"[nandsim]" fmt
> > > >=20
> > > > (remember to put this definition before include directives).
> > > >=20
> > > > Then, all you have to do is
> > > >=20
> > > > do { if (log) pr_debug(" log: " args); } while(0)
> > > > =C2=A0=C2=A0 =20
> > > > >=20
> > > > >=20
> > > > > =C2=A0#define NS_DBG(args...) \
> > > > > -	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX "
> > > > > debug:
> > > > > " args); } while(0)
> > > > > +	do { if (dbg) pr_debug(NS_OUTPUT_PREFIX " debug: "
> > > > > args);
> > > > > } while(0)
> > > > > =C2=A0#define NS_WARN(args...) \
> > > > > -	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: "
> > > > > args); } while(0)
> > > > > +	do { pr_warn(NS_OUTPUT_PREFIX " warning: " args); }
> > > > > while(0)
> > > > > =C2=A0#define NS_ERR(args...) \
> > > > > -	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: "
> > > > > args); }
> > > > > while(0)
> > > > > +	do { pr_err(NS_OUTPUT_PREFIX " error: " args); }
> > > > > while(0)
> > > > > =C2=A0#define NS_INFO(args...) \
> > > > > -	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); }
> > > > > while(0)
> > > > > +	do { pr_info(NS_OUTPUT_PREFIX " " args); } while(0)
> > > > > =C2=A0
> > > > > =C2=A0/* Busy-wait delay macros (microseconds, milliseconds) */
> > > > > =C2=A0#define NS_UDELAY(us) \
> > > > > diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> > > > > index fc9287a..3d54c6a 100644
> > > > > --- a/drivers/mtd/nand/r852.c
> > > > > +++ b/drivers/mtd/nand/r852.c
> > > > > @@ -935,7 +935,7 @@ static int=C2=A0=C2=A0r852_probe(struct pci_d=
ev
> > > > > *pci_dev,
> > > > > const struct pci_device_id *id)
> > > > > =C2=A0		&dev->card_detect_work, 0);
> > > > > =C2=A0
> > > > > =C2=A0
> > > > > -	printk(KERN_NOTICE DRV_NAME ": driver loaded
> > > > > successfully\n");
> > > > > +	pr_notice(DRV_NAME ": driver loaded
> > > > > successfully\n");=C2=A0=C2=A0 =20
> > > > Same here:
> > > >=20
> > > > #define pr_fmt(fmt)	DRV_NAME fmt=C2=A0=C2=A0 =20
> > > I am facing the following errors here.
> > >=20
> > >=20
> > >=20
> > > In file included from drivers/mtd/nand/r852.c:22:0:
> > > drivers/mtd/nand/r852.h:148:0: warning: "pr_fmt" redefined
> > > =C2=A0#define pr_fmt(fmt)=C2=A0=C2=A0(DRV_NAME fmt)
> > > =C2=A0^
> > > In file included from ./include/linux/kernel.h:14:0,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/mtd/nand/r852.c:10:
> > > ./include/linux/printk.h:287:0: note: this is the location of the
> > > previous definition
> > > =C2=A0#define pr_fmt(fmt) fmt =20
> > That's because you didn't define pr_fmt() before all the #include
> > directives in this driver. See the '#indef pr_fmt' statement in
> > printk.h
> > which is preventing redefinition of this symbol if the file including
> > printk.h (either directly or indirectly) already defines it. =20
>=20
> Yes, and that is why I did undef before defining it again in the r852.c
> file.
> Shouldn't it work in this manner?

It should compile (I'd need to see the diff to figure out why it fails
to compile in your case), but not necessarily do what you want.
When you use #undef/#define to redefine a macro the new definition
applies to everything that uses it in the code *after* the
point it's been redefined. One problem I can think of (but there
probably are others) is when some intermediate header files use
pr_xxx() inside macros/inline functions. In this case, you probably
want the prefix to be applied and that can only be done if you've
defined your own pr_fmt() before including printk.h.

Another reason to define pr_fmt() before including printk.h is that it
requires one line instead of 2 if you go for the #undef/#define
solution.

--=20
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/20180220202008.4a67d0e9%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
