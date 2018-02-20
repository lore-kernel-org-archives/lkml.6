Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBVVZWHKAKGQE5ZT55PA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519148247; cv=pass;
        d=google.com; s=arc-20160816;
        b=mMi1H/ASgwiKpcMCOgdBMw8u6qCvIY+JDjwPafnecDmC+L0LAZp82rKxIv8ls1cEBF
         0WYtANZDAM1pj/Sbs4Vxo7MBsrKkdAhR2yJefsVTAYjE5jceHDFYM8ZoO8+HgsrBhFUt
         vqQQdq5viGM7VMMGyWsYog+IBcWKsaDIkN6LoBRjG9qxxsIUk0ItNzsk9wmZz7U0mDZ+
         wYKiJwNPT7RhF3JnvEOzztmfY0SRQW+kkKu56fLY9DHEfTmZiTuaZPj1UriYZdGzknEv
         LK5FOcGxm1FK31+HWVK7y+JrlLmQAyDtGfCfs8ucstwBplXNJegLkJbFWR4bvyGYNQ8F
         CY4Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=QZqO6aONQ6eFvRmCVaWvC+kK32y7FpoU8OuciLqLyMM=;
        b=kB4hfp59lJXhsnFR8Fu1e2E8YveZoOYsNQNUhEA2H6dbcxymhtddwpqX8fwPLIf0zf
         zMf7dqH/QRLBsgFB9qjgpB7JTjXjFBRsTj3yKTwvKutV4iRPOesbrYX/zl5ZyMKHvdRU
         vi0nhXm5PefRcS2tYtp9t/YDhPZH9/OkCxMxhS/TRQWnRw9Zkh7X9BDyXvBRJ0szmKrq
         3rGlAqdIIm4lmzz09r2QAONI3OY7OF8S5VANMRVXJVuwEq0+F/1NRXYaH8Er6OCq4RMc
         0TZ91FfHOQxppelF1CcU4ye5GILeBRYrC2sJ5f7ZjTJDDZunpHsYLJhoUH3d5Dx/MqqM
         9PEQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=rwGYPLpp;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eIJw2g78;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbvvzwhkakgqe5zt55pa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBVVZWHKAKGQE5ZT55PA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=rwGYPLpp;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eIJw2g78;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbvvzwhkakgqe5zt55pa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBVVZWHKAKGQE5ZT55PA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519148247; cv=pass;
        d=google.com; s=arc-20160816;
        b=QkVp7W1rNJYRRvUO5pLUSaZdTXQqTka7ut91MrRkKydpCw4rkzmNsQf1+zCQFoRhnN
         mGgnE4paq/gqIOPwMoCpTWPlRUJUO+cqnXBcdQtG4W3zIvh4qHBaYKUwxW3QM32tgZ8x
         1wVXxPw4s/BLs2bU5imFiItdPhUIQ5vPIFNI4sa4CpigoQJQL3q4i6SrzgcCcyueKsML
         w+j3JIYL7srfTeRLGk1WOhx1QZIqsXu6PAGURlzS3qXcRuvYy9mWYUfcvI5HKnQy1+6q
         YdvlD319Gohf6PjwA13hkuTL8EJgjwleAihEgN+j0pnsjiXqA8rwNt9cQqKyOOC/Ag4i
         QVDw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=QZqO6aONQ6eFvRmCVaWvC+kK32y7FpoU8OuciLqLyMM=;
        b=Y9q+wXcbi/jehEhMdMSE9fAgg0C2+qEAoTVIdTGR7GSGW08AYZxbbElLQF0y021Ec2
         9tkwD1sFGz/F8cAhAR73WDEd3wiI/Ziml4hgi2lTYoAYfReEJdXHpjtIa2DhYG2ALVum
         ovDaNkJ7ivZOcfHoVnNMhmXafowU0nMNzfv8HB7nQWxPBGklC+jV6wLUsiwFakLXDgLO
         8PBmJZBnbiH9Tbdb6Hj0+jf83y/ftq6su6ekIuIGVSgkyW7kCNr+d833nuIyVjPAuGS7
         2qlzizarGLtdc2LmuqrC8jq84mecEdWmQKSRiVQ8UzWiA0QymMRtXol0K+XLlwqiJeAP
         qLZA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Dp/VB9d8;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c00::22c as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x225vDiQu1yB53OihN/NXWhAfEfrigezY2ZRaJyrp8vXRuA/RaRdo3dnGIGVrysG5I2lLtHZ2ig==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519148246; cv=none;
        d=google.com; s=arc-20160816;
        b=sicjbXLAxPTvu84JYdcBnCkaaP3L1ZRF9ekq+Za/LvWVm0GZcTfqXP/SgLUKu/nIW7
         /FS3S4Vlco5QL6/A6grMmW8kqBbuNrc5I7ktk8QsIc6rhNgK87UDngdh2duI64QtskB/
         aEN0KUb28bLU4cGryMJ5U+dNHAR2GPq0Hj7V1EEDQ1V7Ax7t1R3EP/LP4Rfanmz5tpq5
         P+8W7rUCKza/BAQV6zCF0rutpXCOvNdE0AlLoW4yE6AkZxa+uz62l+Qvsiut4Dq8M0EB
         vGslb/UZBgBjEJ1F+Af+qTJ8Q1VidR9YRy+lxNGRLWCg2hf+RK9Wvp720uiwthCPSP6j
         hIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=FMUWuQD9csgV7Orm8TT9VSY74QSo3DuvYN28HbWPuhw=;
        b=Yz1/L9Zhdp1MvLKCJ9bJe5fORm3792KSoaNVQkg9VjBwjvio0MMoPJbU0sJBLVGsaj
         XX7AoqGqhxgWgukZ8fxhSREBAHZdfIY7OMjUhVN3/0d8M2QyvXvbh5VZMhdWE55//l5E
         JEQ2GDQwPA942nbWhRf6/eoqwpOaNVC5UsA6bbwQvky1OH0zSaYyk7u0Uzl7AohQuiOH
         INwo00tBpO3FyOd43LSPbXhcrtmcF229Q5T4tJareskCyDcPsy9pRSeGNQHmu3yzsKdz
         W9G3dOLx9y5U98zfVYMjaCK5Gs/trPIOI0+LJ59cMhBzSVAJaK1luclmXZJvAh7/bUtJ
         2MDQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Dp/VB9d8;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c00::22c as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Message-ID: <1519148238.14621.3.camel@gmail.com>
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
  computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr,  maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar,  outreachy-kernel@googlegroups.com
Date: Tue, 20 Feb 2018 23:07:18 +0530
In-Reply-To: <20180220181647.6f2367b6@bbrezillon>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
	 <20180219155115.3d9d1bd5@bbrezillon> <1519146401.12276.4.camel@gmail.com>
	 <20180220181647.6f2367b6@bbrezillon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=Dp/VB9d8;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:400e:c00::22c as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
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
X-GMAIL-MSGID: =?utf-8?q?1592942392805621627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-20 at 18:16 +0100, Boris Brezillon wrote:
> On Tue, 20 Feb 2018 22:36:41 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
>=20
> >=20
> > On Mon, 2018-02-19 at 15:51 +0100, Boris Brezillon wrote:
> > >=20
> > > Hi Shreeya,
> > >=20
> > > On Mon, 19 Feb 2018 18:43:45 +0530
> > > Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> > > =C2=A0=C2=A0
> > > >=20
> > > >=20
> > > > The log levels embedded with the name are more concise than
> > > > printk.
> > > > Replace printks having a log level with the appropriate
> > > > pr_*macro.
> > > >=20
> > > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > > ---
> > > >=20
> > > > Changes in v2:
> > > > =C2=A0 -Merge previous patches of the patchset regarding replacemen=
t
> > > > of printk with pr_*macro, into single patch.
> > > >=20
> > > >=20
> > > > =C2=A0drivers/mtd/nand/cs553x_nand.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
9 ++---
> > > > =C2=A0drivers/mtd/nand/diskonchip.c=C2=A0=C2=A0=C2=A0=C2=A0| 76 +++=
++++++++++++++++++---
> > > > ----
> > > > ------------
> > > > =C2=A0drivers/mtd/nand/fsl_elbc_nand.c |=C2=A0=C2=A02 +-
> > > > =C2=A0drivers/mtd/nand/fsl_ifc_nand.c=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > > > =C2=A0drivers/mtd/nand/mxc_nand.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A02 +-
> > > > =C2=A0drivers/mtd/nand/nand_bch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 12 +++----
> > > > =C2=A0drivers/mtd/nand/nandsim.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 10 +++---
> > > > =C2=A0drivers/mtd/nand/r852.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > > > =C2=A0drivers/mtd/nand/r852.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 ++--
> > > > =C2=A0drivers/mtd/nand/sm_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A05 ++-
> > > > =C2=A010 files changed, 65 insertions(+), 61 deletions(-)
> > > > =C2=A0=C2=A0
> > > [...]
> > > =C2=A0=C2=A0
> > > >=20
> > > >=20
> > > > =C2=A0
> > > > diff --git a/drivers/mtd/nand/diskonchip.c
> > > > b/drivers/mtd/nand/diskonchip.c
> > > > index c3aa53c..b97d88c 100644
> > > > --- a/drivers/mtd/nand/diskonchip.c
> > > > +++ b/drivers/mtd/nand/diskonchip.c=C2=A0=C2=A0
> > > [...]
> > > =C2=A0=C2=A0
> > > >=20
> > > >=20
> > > > @@ -438,7 +438,7 @@ static void __init
> > > > doc2000_count_chips(struct
> > > > mtd_info *mtd)
> > > > =C2=A0			break;
> > > > =C2=A0	}
> > > > =C2=A0	doc->chips_per_floor =3D i;
> > > > -	printk(KERN_DEBUG "Detected %d chips per floor.\n",
> > > > i);
> > > > +	pr_info("Detected %d chips per floor.\n", i);=C2=A0=C2=A0
> > > Should be pr_debug() here.
> > > =C2=A0=C2=A0
> > > >=20
> > > >=20
> > > > =C2=A0}
> > > > =C2=A0=C2=A0=C2=A0
> > > [...]
> > > =C2=A0=C2=A0
> > > >=20
> > > >=20
> > > > diff --git a/drivers/mtd/nand/nandsim.c
> > > > b/drivers/mtd/nand/nandsim.c
> > > > index 246b439..4e5f817 100644
> > > > --- a/drivers/mtd/nand/nandsim.c
> > > > +++ b/drivers/mtd/nand/nandsim.c
> > > > @@ -184,15 +184,15 @@ MODULE_PARM_DESC(bch,		=C2=A0"En
> > > > able
> > > > BCH ecc and set how many bits should "
> > > > =C2=A0
> > > > =C2=A0/* Simulator's output macros (logging, debugging, warning,
> > > > error)
> > > > */
> > > > =C2=A0#define NS_LOG(args...) \
> > > > -	do { if (log) printk(KERN_DEBUG NS_OUTPUT_PREFIX "
> > > > log: "
> > > > args); } while(0)
> > > > +	do { if (log) pr_debug(NS_OUTPUT_PREFIX " log: "
> > > > args); }
> > > > while(0)=C2=A0=C2=A0
> > > You could define pr_fmt() to avoid passing NS_OUTPUT_PREFIX.
> > > Something
> > > like:
> > >=20
> > > #define pr_fmt(fmt)	"[nandsim]" fmt
> > >=20
> > > (remember to put this definition before include directives).
> > >=20
> > > Then, all you have to do is
> > >=20
> > > do { if (log) pr_debug(" log: " args); } while(0)
> > > =C2=A0=C2=A0
> > > >=20
> > > >=20
> > > > =C2=A0#define NS_DBG(args...) \
> > > > -	do { if (dbg) printk(KERN_DEBUG NS_OUTPUT_PREFIX "
> > > > debug:
> > > > " args); } while(0)
> > > > +	do { if (dbg) pr_debug(NS_OUTPUT_PREFIX " debug: "
> > > > args);
> > > > } while(0)
> > > > =C2=A0#define NS_WARN(args...) \
> > > > -	do { printk(KERN_WARNING NS_OUTPUT_PREFIX " warning: "
> > > > args); } while(0)
> > > > +	do { pr_warn(NS_OUTPUT_PREFIX " warning: " args); }
> > > > while(0)
> > > > =C2=A0#define NS_ERR(args...) \
> > > > -	do { printk(KERN_ERR NS_OUTPUT_PREFIX " error: "
> > > > args); }
> > > > while(0)
> > > > +	do { pr_err(NS_OUTPUT_PREFIX " error: " args); }
> > > > while(0)
> > > > =C2=A0#define NS_INFO(args...) \
> > > > -	do { printk(KERN_INFO NS_OUTPUT_PREFIX " " args); }
> > > > while(0)
> > > > +	do { pr_info(NS_OUTPUT_PREFIX " " args); } while(0)
> > > > =C2=A0
> > > > =C2=A0/* Busy-wait delay macros (microseconds, milliseconds) */
> > > > =C2=A0#define NS_UDELAY(us) \
> > > > diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> > > > index fc9287a..3d54c6a 100644
> > > > --- a/drivers/mtd/nand/r852.c
> > > > +++ b/drivers/mtd/nand/r852.c
> > > > @@ -935,7 +935,7 @@ static int=C2=A0=C2=A0r852_probe(struct pci_dev
> > > > *pci_dev,
> > > > const struct pci_device_id *id)
> > > > =C2=A0		&dev->card_detect_work, 0);
> > > > =C2=A0
> > > > =C2=A0
> > > > -	printk(KERN_NOTICE DRV_NAME ": driver loaded
> > > > successfully\n");
> > > > +	pr_notice(DRV_NAME ": driver loaded
> > > > successfully\n");=C2=A0=C2=A0
> > > Same here:
> > >=20
> > > #define pr_fmt(fmt)	DRV_NAME fmt=C2=A0=C2=A0
> > I am facing the following errors here.
> >=20
> >=20
> >=20
> > In file included from drivers/mtd/nand/r852.c:22:0:
> > drivers/mtd/nand/r852.h:148:0: warning: "pr_fmt" redefined
> > =C2=A0#define pr_fmt(fmt)=C2=A0=C2=A0(DRV_NAME fmt)
> > =C2=A0^
> > In file included from ./include/linux/kernel.h:14:0,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/mtd/nand/r852.c:10:
> > ./include/linux/printk.h:287:0: note: this is the location of the
> > previous definition
> > =C2=A0#define pr_fmt(fmt) fmt
> That's because you didn't define pr_fmt() before all the #include
> directives in this driver. See the '#indef pr_fmt' statement in
> printk.h
> which is preventing redefinition of this symbol if the file including
> printk.h (either directly or indirectly) already defines it.

Yes, and that is why I did undef before defining it again in the r852.c
file.
Shouldn't it work in this manner?

>=20

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/1519148238.14621.3.camel%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
