Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBC5QWHKAKGQE2IEGLPI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519147019; cv=pass;
        d=google.com; s=arc-20160816;
        b=hQnOZts0r6lVk2XB6YjTuwBI7bKkH+AMGE0mYDV08AtD4Dx29zlv/N7D2NI1VG4ZnC
         jJAgW/ni0tZ4g0yBtQmPqgbEqiIqFf/VHkhEp48FlgPmYc88DJv0rUPRJe87hcm/+7ah
         PkuNIkNwUyUP2BoRT2IEtGt9ufFFuZozJOFCwWitfqxkPO/vHLEpZOVlmQzhZllVjgB/
         0PU4Ov9AKAF9hLVLLwVevQlxBY4RsUYSmjSgDiWQtXPakyvJIv9Avs6ep9WDHLGSeDyM
         ahXrmrjkp1eucBRT9aHyGDc17FK12V63IHiaI+ZpzDZsPtGFZ5abtT4JqfCWu8crWLBS
         KHmw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=dPriJWVnfDr1UXJl26BjTsWbgYjDC3/7Pfd+X+TdJpE=;
        b=QDT8EEQcqkXJ2gslrjFSAJAmHIbAdPuq8LTpsZvr4CWZLlobXAv82JgjQNcJjhOVEa
         o30Y1TmfCfKADSoKD+wUIqSP8zfsgDbpHPSm5IaU2/8wQLkmYQDIB4QCBso3yzRI2z4J
         dUGYlLOqHEjl5futIWR3GMF5T6fyf+vxqSQrG/dtsD635wMtSUGBH5tSZMrfgbGks2l0
         UthJECwAeWYxQt2Z6vxJDGl4OrSmZto9oQEKyd7iAinUEdyq44V/XYq8F+IgMItAxUcy
         CbfbYavZVgOGcsSRF1Cufg56XK91sC/cgtVmProKV192YbydEqwdIsZn2NVnc3TBZL2r
         tVfQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=qml7Y+ZN;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbc5qwhkakgqe2ieglpi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBC5QWHKAKGQE2IEGLPI@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=qml7Y+ZN;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbc5qwhkakgqe2ieglpi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBC5QWHKAKGQE2IEGLPI@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519147019; cv=pass;
        d=google.com; s=arc-20160816;
        b=YM2chvPQaJ9dEjgWoUdJk/EErwNv+VwZVsz8h12iepW0WLLF9FVZKkGnm2WTyLLMYN
         Zfgn9e/MaAxToGaD6im9JBvesolQu7RKIuzbjbge5oHBoFFy9+vwJVz4BBlicc0koZSr
         QGfSisaO52mRGj1qX95VfrKhVugV3kSp+XoLtduXeQUsmssijgGgOLMIBq1uHygpKPpN
         m+MyS+edsgkKRRPOPvgEyFtgSVelgLsA2t9IlAtHzyLs/h+FCSmB6tcvSdQrKoAJzWuf
         4jA8sF2LPgUKPbU9bkLJyyEKuqfohqi94QoQYhGpq9rly85H705StHRvuE7VmklMts9w
         Eb2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=dPriJWVnfDr1UXJl26BjTsWbgYjDC3/7Pfd+X+TdJpE=;
        b=VzWHZbtM10vYcP2+NVUu+MFLnYpq4fbEamnmrRcN8amhs/OLluXLkct3LvsQYWajAO
         oX9k6MANrMjGkH4P0tAqxLXhqSyF4PSy0pSVHg2LB22/Nft1xKIiic/JpNwjYQg6XR5l
         0oALco+syaSiLQoKVYvRKilbnCcvRao+7EaPLhWj7TApp51HXnJr3gCxjREEqJBfawnB
         hgFd/dXRxFM02Xac6mI5R95hrWNQ3Q0G1Cvwxv4yoat0+fD3qP3WnvYfzeyZ6NI8509x
         YonxN0n+FsU6PDxOynWW9HXI/T99rH+3IW8U7X14hUNgBPCqJu7UC6AzpZvK1ib4PsiJ
         PpoQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x227gYmeb9fKPqU6GVQqgTMB0MdCdLwvF3y9DvFr6uWNcGng57EIJZjFKlRc9t2GJJM22YEUHPw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519147018; cv=none;
        d=google.com; s=arc-20160816;
        b=e21P3OmSug8T2T8EwYADJ9ucUxT/9Q0vlUUKBtWYjE7oTmQMP+dXr8TmPFKcvARt5e
         8QuuoHVnWaQpXNi7DaI4HJFKDjN1EhjdQzd9hoEB9xVe10pPk94iCq0k6vt9Bm7kdklZ
         yDIvMf2CwODOI4QROfwChZSgez0Y6wdS4yXnSkVfk5eW8PoKkdh6bOuNKTn4s7CQ8aQZ
         UJfQ1wD6IR+rKc43lQRkmigK2iKzzGVZjPr6O44IxgS1bRfdKWZOJfNQ/hcGv6thrjtA
         8+YDBQRKX6xJaFocxXmzO14IrnZMkmPdlKeclXMfuVE+tstLc4/jgct9pBjEtcAK1bje
         X7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=aKF0RqzWFpLwD7WyBxlxDfbMSYQIvsPl/q+AVs7vwY0=;
        b=QOC9fdFa/rQSGzPwJL0JKVQ3QuZ/MTkWt7XvGn/p922euNDdBpeFwhdGSZQfQHr44v
         /smCvoFoZJNlEz736I7/e1Ur83CiqkGUfNLc8chSuFnKyBgbMDAS5yDV7wtZgAYm4yue
         8o4zeo/ZBk5FjdEoisTCMGqI5m7g5a/dGXeZRIAGgKNJwDnsKYojaIT7+5ttetiwh6KG
         I/KmwfGL4CKWOQ76Gkb9cvaiAGqwHPIVvGBQjxix8Zb0vn/6xhOpUbr7DRqf9Fe/eLRc
         L+5i409wVujLJJXlMt+cf/2O91ZiJoUiuqPuRWpLwHK89Jfbik9fkW79qdGbZ1vKHbud
         YKmg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Tue, 20 Feb 2018 18:16:47 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
Message-ID: <20180220181647.6f2367b6@bbrezillon>
In-Reply-To: <1519146401.12276.4.camel@gmail.com>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
	<20180219155115.3d9d1bd5@bbrezillon>
	<1519146401.12276.4.camel@gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592941105522894972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 20 Feb 2018 22:36:41 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Mon, 2018-02-19 at 15:51 +0100, Boris Brezillon wrote:
> > Hi Shreeya,
> >=20
> > On Mon, 19 Feb 2018 18:43:45 +0530
> > Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> >  =20
> > >=20
> > > The log levels embedded with the name are more concise than
> > > printk.
> > > Replace printks having a log level with the appropriate
> > > pr_*macro.
> > >=20
> > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > ---
> > >=20
> > > Changes in v2:
> > > =C2=A0 -Merge previous patches of the patchset regarding replacement
> > > of printk with pr_*macro, into single patch.
> > >=20
> > >=20
> > > =C2=A0drivers/mtd/nand/cs553x_nand.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A09 =
++---
> > > =C2=A0drivers/mtd/nand/diskonchip.c=C2=A0=C2=A0=C2=A0=C2=A0| 76 +++++=
++++++++++++++++-------
> > > ------------
> > > =C2=A0drivers/mtd/nand/fsl_elbc_nand.c |=C2=A0=C2=A02 +-
> > > =C2=A0drivers/mtd/nand/fsl_ifc_nand.c=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > > =C2=A0drivers/mtd/nand/mxc_nand.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A02 +-
> > > =C2=A0drivers/mtd/nand/nand_bch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
| 12 +++----
> > > =C2=A0drivers/mtd/nand/nandsim.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0| 10 +++---
> > > =C2=A0drivers/mtd/nand/r852.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > > =C2=A0drivers/mtd/nand/r852.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 ++--
> > > =C2=A0drivers/mtd/nand/sm_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A05 ++-
> > > =C2=A010 files changed, 65 insertions(+), 61 deletions(-)
> > >  =20
> > [...]
> >  =20
> > >=20
> > > =C2=A0
> > > diff --git a/drivers/mtd/nand/diskonchip.c
> > > b/drivers/mtd/nand/diskonchip.c
> > > index c3aa53c..b97d88c 100644
> > > --- a/drivers/mtd/nand/diskonchip.c
> > > +++ b/drivers/mtd/nand/diskonchip.c =20
> > [...]
> >  =20
> > >=20
> > > @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct
> > > mtd_info *mtd)
> > > =C2=A0			break;
> > > =C2=A0	}
> > > =C2=A0	doc->chips_per_floor =3D i;
> > > -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> > > +	pr_info("Detected %d chips per floor.\n", i); =20
> > Should be pr_debug() here.
> >  =20
> > >=20
> > > =C2=A0}
> > > =C2=A0 =20
> > [...]
> >  =20
> > >=20
> > > diff --git a/drivers/mtd/nand/nandsim.c
> > > b/drivers/mtd/nand/nandsim.c
> > > index 246b439..4e5f817 100644
> > > --- a/drivers/mtd/nand/nandsim.c
> > > +++ b/drivers/mtd/nand/nandsim.c
> > > @@ -184,15 +184,15 @@ MODULE_PARM_DESC(bch,		=C2=A0"Enable
> > > BCH ecc and set how many bits should "
> > > =C2=A0
> > > =C2=A0/* Simulator's output macros (logging, debugging, warning, erro=
r)
> > > */
> > > =C2=A0#define NS_LOG(args...) \
> > > -	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX " log: "
> > > args); } while(0)
> > > +	do { if (log) pr_debug(NS_OUTPUT_PREFIX " log: " args); }
> > > while(0) =20
> > You could define pr_fmt() to avoid passing NS_OUTPUT_PREFIX.
> > Something
> > like:
> >=20
> > #define pr_fmt(fmt)	"[nandsim]" fmt
> >=20
> > (remember to put this definition before include directives).
> >=20
> > Then, all you have to do is
> >=20
> > do { if (log) pr_debug(" log: " args); } while(0)
> >  =20
> > >=20
> > > =C2=A0#define NS_DBG(args...) \
> > > -	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX " debug:
> > > " args); } while(0)
> > > +	do { if (dbg) pr_debug(NS_OUTPUT_PREFIX " debug: " args);
> > > } while(0)
> > > =C2=A0#define NS_WARN(args...) \
> > > -	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: "
> > > args); } while(0)
> > > +	do { pr_warn(NS_OUTPUT_PREFIX " warning: " args); }
> > > while(0)
> > > =C2=A0#define NS_ERR(args...) \
> > > -	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: " args); }
> > > while(0)
> > > +	do { pr_err(NS_OUTPUT_PREFIX " error: " args); } while(0)
> > > =C2=A0#define NS_INFO(args...) \
> > > -	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); }
> > > while(0)
> > > +	do { pr_info(NS_OUTPUT_PREFIX " " args); } while(0)
> > > =C2=A0
> > > =C2=A0/* Busy-wait delay macros (microseconds, milliseconds) */
> > > =C2=A0#define NS_UDELAY(us) \
> > > diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> > > index fc9287a..3d54c6a 100644
> > > --- a/drivers/mtd/nand/r852.c
> > > +++ b/drivers/mtd/nand/r852.c
> > > @@ -935,7 +935,7 @@ static int=C2=A0=C2=A0r852_probe(struct pci_dev *=
pci_dev,
> > > const struct pci_device_id *id)
> > > =C2=A0		&dev->card_detect_work, 0);
> > > =C2=A0
> > > =C2=A0
> > > -	printk(KERN_NOTICE DRV_NAME ": driver loaded
> > > successfully\n");
> > > +	pr_notice(DRV_NAME ": driver loaded successfully\n"); =20
> > Same here:
> >=20
> > #define pr_fmt(fmt)	DRV_NAME fmt =20
>=20
> I am facing the following errors here.
>=20
>=20
>=20
> In file included from drivers/mtd/nand/r852.c:22:0:
> drivers/mtd/nand/r852.h:148:0: warning: "pr_fmt" redefined
> =C2=A0#define pr_fmt(fmt)=C2=A0=C2=A0(DRV_NAME fmt)
> =C2=A0^
> In file included from ./include/linux/kernel.h:14:0,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/mtd/nand/r852.c:10:
> ./include/linux/printk.h:287:0: note: this is the location of the
> previous definition
> =C2=A0#define pr_fmt(fmt) fmt

That's because you didn't define pr_fmt() before all the #include
directives in this driver. See the '#indef pr_fmt' statement in printk.h
which is preventing redefinition of this symbol if the file including
printk.h (either directly or indirectly) already defines it.

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
outreachy-kernel/20180220181647.6f2367b6%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
