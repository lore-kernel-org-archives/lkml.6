Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBDWQVTKAKGQEDK2SWIA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519069199; cv=pass;
        d=google.com; s=arc-20160816;
        b=GifI78cEbEHGezvoUBe8NsyXEUw5poS/hwLU5/v9N50m17IDocgf4y6G9yM1pXh6uL
         /ah0+Ml51M6+5RBnpwg+LZyqd5sEOdLDQxiEIMppF/jNbdsI4JLa3v5vdnXsVnyz79EG
         MOahILSAAP8Sha8qD/E7kZVkXiZFO30jlUK+uFbJBOsrnmIbwiG4fiMOgzvXin4qNxZS
         eQ8AHHXg9WPsq1P7WOhykn2FwQSk4KjV2/aZjpGbtsrHKfc26LrXT+5TDU3gDrjssiaN
         uQVNThkCS8wfv+JSnidpqElaHnvgxRd3B9AaOuLegyTlhTxkbtiANP9jUIEi8mOphVq6
         63ZA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=uTnOnUJmk+B978YficTeN7uFJo68bwGYFHY23KfYph4=;
        b=FhCWZaeJxye1HeBeUk9WKPkwQl1Z0VufUHwM1rp9Rh/qmRfzWaph1WnMVUac+tRV1b
         eIHeDiHdCYdokmbhi7JuSc6igAePKvNrwm8dzU6t4ZwlJBKBAjlPOHT72iw4TD6z0DR6
         9OGPpXwvF3EK9n1jHsLtV++1A6Sz+K8nJZSB6ZEL/w1JSJFiVj1weH441kjUm2q2ixxz
         KmgZpGVgRUwfMe3gsP1zQJdmzXc5pUHqA52sopXEBZFs+MbltF+hizUKxpe+x+iFldZz
         TQJcJ2w3fKkmSI4NfSLC5tPNvvsMqJwcwLE/FAEV5PuPEKcy4C54S/z4FdCZBSn+qBav
         n/tw==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=tdU4X+5S;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=d6oeyVrT;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbdwqvtkakgqedk2swia@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBDWQVTKAKGQEDK2SWIA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=tdU4X+5S;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=d6oeyVrT;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbdwqvtkakgqedk2swia@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBDWQVTKAKGQEDK2SWIA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519069199; cv=pass;
        d=google.com; s=arc-20160816;
        b=zG7v3rrbdl4VDKb1qUwwuIhHk6EsaJaNOKR88HJi7IEr00dEC8MLhx6MVb+0U/lfi1
         c94i+qxwIDfGPol9Xf6qg8LDpjOmegp9FLeO+/2V4miLiEKrxYkPNegCgJfaClnsEPzM
         Z3SoisUJfYriDGLF57N5uVQ4gDti9J0ncFHx1SgUbHPXXotuYQZcFRBWGvXbKqHbhT7I
         vegT5JA3uxkwlScMnUx2GsYfLouJFkac9A9rV8P31wXgubISzUql5e+boKL6ekp2yJ8L
         hurDsGhABTgR2RozAD90qwYDz3mT0OypApC1OKa2fECXImMpPBCBveQxphnnYoEUlTCW
         MDxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=uTnOnUJmk+B978YficTeN7uFJo68bwGYFHY23KfYph4=;
        b=FoV6imIaWnOF65WNi/VCQe7GBNO1hGRUFNsXWyqBnDIfkrCPG5FiF63yPUDx81I5Il
         a70k7uSa9xk6f+2Xumf9WRBsGaHPdpFYn+LVstqeRcLAfcDuo1bOzx1u3x/uPCTQkM6q
         s2JuZtoZq81NU3nbidso5C7mxxRu1Cyn10UG5PoaYtUoiEGgtcshjNXb8Q+9UTNckqx3
         ItQZiQFFToAVZCINe2fiQrnoX8/R9W4JGvN/FyjXVdIkJ5ZrI7R+axi//oYMJPm/bKAi
         6xXCS1z1LmesyHV3pRytFd52jUD38lGUdwxDsWu6ApNYv/iRpGztH2lJxVZXRfqAp4JQ
         RoFA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aVqsc7vp;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c05::22b as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x224gj4cExa/y7osK1WO2ksTmlwrMKJUyQY0WCdFia604ELz+OQzu/Nv1rX6tRFSFiE/+GhS26A==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519069198; cv=none;
        d=google.com; s=arc-20160816;
        b=nXHaF+GkCF8Yy+vCHDjHogwJQGR2bCOd3yDXgvrx9lRm11o4tvoaOnOV4+4l4EiDs9
         PaortYkZBH03wFxHozDDF+5FlY3HlfEqHux0mDfa66XtJHLhKYaPVgDBzdyzEnPrUr8w
         wuGZ/UObEsIMsEDu9+reHoD9SF1hIuG08zzK3K/X9vHBwXcXo7CqwziOB/lybEp2INjN
         V13l40LrxCFPxae/Cf+Lg1sCXWyhBJN7hIwhldZZg7p1vB+BBHjxM19vGVmvP5xr1cFx
         LYC4zGCDdx870UzfyYhKTEM2PQ517ipMWgArj1SobPEQTfIVXuDyNElLWGXHzp+X85UF
         Moug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=pAThaJ4iqdyOgeLmLxpyKMZa3z6IfcG2EDbN0UMyBcA=;
        b=v0/pOA24Ay+56XLbrPG3b/MaaqXwotEy6K1al06WcXe1tmBeoJKVvp44dwXuxADnmE
         NgC08w1M09Sgr8jjysBj5rinkDLPYUQcVMUC/knxTCqWUu7zQv4hVc0CBjoqEsJ/Ixlv
         LsaahEmiLLc90USwJddXL6dtagtOmaGvVNevOxuV6wakCwCun6EQIKrfRV6Cv8dL1vj1
         vbf++6UJnKA0IGglPrACMAk+eCSeDjUT0BIM/htX5jraXeW6RFohRWOxSdp5O3i+58Et
         ENKQXXxdDzB3i/22BP8sLLcfkyTKLEe9lVoFh5gp+bnbVKhlSTM4qf0eBsBFjia1GB74
         /Mig==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aVqsc7vp;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c05::22b as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Message-ID: <1519069191.2102.3.camel@gmail.com>
Subject: [Outreachy kernel] Re: [PATCH NAND] mtd: nand: Replace printk() with
 appropriate dev_*macro()
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
  computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr,  maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar,  outreachy-kernel@googlegroups.com
Date: Tue, 20 Feb 2018 01:09:51 +0530
In-Reply-To: <20180219161216.4f3ec2f3@bbrezillon>
References: <1519046339-9678-1-git-send-email-shreeya.patel23498@gmail.com>
	 <20180219161216.4f3ec2f3@bbrezillon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=aVqsc7vp;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:400e:c05::22b as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1592835541004507758?=
X-GMAIL-MSGID: =?utf-8?q?1592859504596313577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-19 at 16:12 +0100, Boris Brezillon wrote:
> On Mon, 19 Feb 2018 18:48:59 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
>=20
> >=20
> > Replace printks having a log level with the appropriate
> > dev_*macro.
> > Also, use pdev->dev as it is guaranteed in each case to be
> > properly initialized when passed into dev_*macro().
> >=20
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> > =C2=A0drivers/mtd/nand/ams-delta.c | 6 ++++--
> > =C2=A0drivers/mtd/nand/cafe_nand.c | 5 +++--
> > =C2=A0drivers/mtd/nand/sh_flctl.c=C2=A0=C2=A0| 2 +-
> > =C2=A03 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-
> > delta.c
> > index dcec9cf..2419ca8 100644
> > --- a/drivers/mtd/nand/ams-delta.c
> > +++ b/drivers/mtd/nand/ams-delta.c
> > @@ -185,7 +185,8 @@ static int ams_delta_init(struct
> > platform_device *pdev)
> > =C2=A0	/* Allocate memory for MTD device structure and private
> > data */
> > =C2=A0	this =3D kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
> > =C2=A0	if (!this) {
> > -		printk (KERN_WARNING "Unable to allocate E3 NAND
> > MTD device structure.\n");
> > +		dev_warn(&pdev->dev,
> > +			=C2=A0"Unable to allocate E3 NAND MTD device
> > structure.\n");
> > =C2=A0		err =3D -ENOMEM;
> > =C2=A0		goto out;
> > =C2=A0	}
> > @@ -219,7 +220,8 @@ static int ams_delta_init(struct
> > platform_device *pdev)
> > =C2=A0		this->dev_ready =3D ams_delta_nand_ready;
> > =C2=A0	} else {
> > =C2=A0		this->dev_ready =3D NULL;
> > -		printk(KERN_NOTICE "Couldn't request gpio for
> > Delta NAND ready.\n");
> > +		dev_notice(&pdev->dev,
> > +			=C2=A0=C2=A0=C2=A0"Couldn't request gpio for Delta NAND
> > ready.\n");
> > =C2=A0	}
> > =C2=A0	/* 25 us command delay time */
> > =C2=A0	this->chip_delay =3D 30;
> > diff --git a/drivers/mtd/nand/cafe_nand.c
> > b/drivers/mtd/nand/cafe_nand.c
> > index bc558c4..51f58ea 100644
> > --- a/drivers/mtd/nand/cafe_nand.c
> > +++ b/drivers/mtd/nand/cafe_nand.c
> > @@ -773,8 +773,9 @@ static int cafe_nand_probe(struct pci_dev
> > *pdev,
> > =C2=A0		cafe->nand.bbt_td =3D &cafe_bbt_main_descr_512;
> > =C2=A0		cafe->nand.bbt_md =3D &cafe_bbt_mirror_descr_512;
> > =C2=A0	} else {
> > -		printk(KERN_WARNING "Unexpected NAND flash
> > writesize %d. Aborting\n",
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtd->writesize);
> > +		dev_warn(&cafe->pdev->dev,
> > +			=C2=A0"Unexpected NAND flash writesize %d.
> > Aborting\n",
> > +			=C2=A0mtd->writesize);
> > =C2=A0		goto out_free_dma;
> I see plenty of printk()s (or pr_xxx()s if this patch is applied
> after
> the printk() -> pr_xxx() replacement) that are not converted to
> dev_xxx() in this driver. If we start using dev_xxx() it should be
> used
> consistently.
>=20
> How about we convert all printk()s to pr_xxx()s first (what you do in
> your first patch), including those you convert to dev_xxx() here, and
> then we consider patching some of the drivers to use dev_xxx()
> instead
> of pr_xxx().

Yes, this will be better :)
I'll include these changes in my pr_xxx() patch.
Then we will work for dev_xxx().

Thanks

>=20
> >=20
> > =C2=A0	}
> > =C2=A0	cafe->nand.ecc.mode =3D NAND_ECC_HW_SYNDROME;
> > diff --git a/drivers/mtd/nand/sh_flctl.c
> > b/drivers/mtd/nand/sh_flctl.c
> > index e7f3c98..c534c49 100644
> > --- a/drivers/mtd/nand/sh_flctl.c
> > +++ b/drivers/mtd/nand/sh_flctl.c
> > @@ -877,7 +877,7 @@ static void flctl_cmdfunc(struct mtd_info *mtd,
> > unsigned int command,
> > =C2=A0			else if (!flctl->seqin_column)
> > =C2=A0				execmd_write_page_sector(mtd);
> > =C2=A0			else
> > -				printk(KERN_ERR "Invalid address
> > !?\n");
> > +				dev_err(&flctl->pdev->dev,
> > "Invalid address !?\n");
> > =C2=A0			break;
> > =C2=A0		}
> > =C2=A0		set_cmd_regs(mtd, command, (command << 8) |
> > NAND_CMD_SEQIN);
>=20
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/1519069191.2102.3.camel%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
