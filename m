Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBZNRXPKAKGQEKYDABVA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519311077; cv=pass;
        d=google.com; s=arc-20160816;
        b=iYXRgkOoKd+1+ORSBeunUoB7rOwstSs/fXlMC3raPdUAUt97sV4uf7ybn9v6C/HYU6
         teh/NKb14PsTnfuflOMjeHJ4doFuy4ZjEPzRFNBLe4eA4y2bFWcIF3v01y3NjfQGPOoH
         WJanU1wR412M620ZsSyXW6yV9pSvoeyRtTSPFpXEPVl5hj0jEXmV1htFGWyfYcox2meJ
         Z2/RqVbkGPxDJFW4eQ2CCuLSwYUAGVDsSXCu1rjLXP5AEfBEdY13lGQtRfwvPrxVBMIa
         72+TzIQ0P7NApQroHabMGjKYPy12z8VvOnbztlp4kxu76JusneECPKAoNQWOj7n5za69
         c/6A==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=tfQNFt9Ed33lCGGj/3EIipqyhjefzuf2QZXaMAcq7WY=;
        b=DDR38fkmraG8RkEt7ENSrJE3S7TyQB0rOH2PW8LoQYQ4S5avuVHow3xkLMGQX/sFxI
         UloOMx0eMhgRy0Gn06t4hYzlpDTj6S7HapZ6K42sEm2eNG7ZbE+A2oiLcOdrKnJA2M04
         BxSZljRl3+v14iRQ+B7IdYCNC4plUJbgE9O77V2YJkKtn73ql0ISo/NESMpHxEqAuccO
         TxBRxbS4LipoconiTse9XYO4FhGZfbVQCcJWmhgjwUdUGJKEZXHQjcUzIAnodXe5ffTS
         ObODRVDT4JQfnkgwXv58UWD4BiyQSykNOwUQuyEBN8dq/ENILmKS83hD41uISBaMgISL
         tSvw==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=OSoROVs+;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbznrxpkakgqekydabva@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBZNRXPKAKGQEKYDABVA@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=OSoROVs+;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbznrxpkakgqekydabva@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBZNRXPKAKGQEKYDABVA@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519311077; cv=pass;
        d=google.com; s=arc-20160816;
        b=fH9Ioye9CMjifcaBZs1S7e5538nVIs/AYoLokj6RZu+JRR1ohMyjzh7ToSb2sZJMUI
         G39f/AUFkvsPCT5KJnMoiwqdtyisTgE4rhjUvS1lT5Fp2oSOskT7bEqxqzqk81+Cfifw
         6i0GRENwliADNKgYPJOxrbGFyqSux99lL7ohxSQkOijBo5P4a96yrm4zLOTsnAKYzkh4
         +V4WJB9fGvTmxLPnSxpixeNgStb8IosU1womRJ0RB5cYz2ShI3JfFDXmLF9r/m57+HqY
         iipto+5m7epwMUk9031oIQd5qzBtv3GJ2QLGGAdXJyF7En7KH2RJa1TlLJZpVmyZ0hS5
         mBBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=tfQNFt9Ed33lCGGj/3EIipqyhjefzuf2QZXaMAcq7WY=;
        b=mBkefDu5D783G7vzx4/NWn+aHK/KFl+3KIYjyjDWwCvuX7H1RIyJoCm3Dubza0Csx+
         3X+67LuBQ72Yh8815JyP5eWkTB7s5kGEgiz7IGcSiLebk6V/V0FdhYyxAQLqwZKaCjmk
         u8B5gVOnWUzE5ObRWAeUNU8yYH0YgpBIyqMdyoxvBNwS9XUGHJ/OxU50a/ObnyhtNvZ4
         mfQ7bfMeH1c0A5CfCmmIeCHcx11jL9lbm3iGPs8COvwVa8cDxcqqgIMYQF0J6Ba4HU50
         AJFzsVp7CTHBGlxqCVdUwI83FLwGK/imdOjM3oQtv6WY7fV0kHXXj1n2Y3NFfOB4pz9K
         MJRw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x226ropotHYdxhTrxDi5dyOXW06F0JCibdhdeMHEtXOVf+8BlJahOu/+SgcBs4qaqppOvLljGuw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519311076; cv=none;
        d=google.com; s=arc-20160816;
        b=0+MG/g4Z8PfXq8hrJc2QVztAgRoFwAQ23MXknQRXCDncdtyO5iQxHjVq0Pb/2JSEHL
         m6AWtYWY6W5P74YeeAlQzSUgpdVRruszFFPV15tSH8cI+LaD/njgO4O+7ZQQKuX6Tl/J
         1KtOSCmg9vPs5YeQWDl8BqdK6ZtiYYgedEXXvcqlzNvGxC1a8CstXd9tApdZ7peibU8n
         HD3rI/OQTkdmFLlYleQWM+LsQwJfjVmBXVCtB43/qaCsOTVQnz+eGndzAJl7VRNyaiMs
         4AmKFLQ1GJOnL7lZIK5OGq8vvAiSEkfGSvqmZaU+ZQQLEz1Q7/gj90KrylplLAqsXvn1
         +dkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=15oV2C64obVqi1Z4fjZiWYSuQV2CeJEQanJgMWyhRbc=;
        b=Ixc3cFbxyK7DDTwik1I8L7R0ebcG+u/14tQFtmCkQ9OL15NhhFsjvHpSOY++nUw4E8
         WhCra1sxhpcd+kN6LtnXorVDS29aWEKcysatAaRop6U/kaSm8Lfh25owOtIfXf2aT337
         2fXYxJrFPHN1l3x4+R+o3NMgY4CzHHUwUBgXwvn2RdSpLoUSYZu13oCtxNszdRlXBjg2
         ZGReyj3/QDNxqHspCuJ09qWXtFduEoFGxF/VI35w4k+hIycyPXhuUnoBKWYalUELEbxK
         wBzowz99mKXpKjn7RuvjIDV0MbNJAkp+IVNhUr1r6d1jJJBU8c8T4kOhnRXgQIulA9+u
         l9JA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Thu, 22 Feb 2018 15:51:05 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, boris.brezillon@free-electrons.com,
 dwmw2@infradead.org, computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v3] mtd: nand: Replace printk()
 with appropriate pr_*() macro
Message-ID: <20180222155105.097eb00a@bbrezillon>
In-Reply-To: <1519310758.2359.3.camel@gmail.com>
References: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
	<2093598.TLbMltDcSo@blindfold>
	<1519310758.2359.3.camel@gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1593106783204445682?=
X-GMAIL-MSGID: =?utf-8?q?1593113133259986654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 20:15:58 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Thu, 2018-02-22 at 15:30 +0100, Richard Weinberger wrote:
> > Am Donnerstag, 22. Februar 2018, 14:10:14 CET schrieb Shreeya Patel: =
=20
> > >=20
> > > @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct
> > > mtd_info
> > > *mtd) break;
> > > =C2=A0	}
> > > =C2=A0	doc->chips_per_floor =3D i;
> > > -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> > > +	pr_debug("Detected %d chips per floor.\n", i); =20
> > <bike-shedding>
> >=20
> > You are aware of the fact that printk(KERN_DEBUG and pr_debug() are
> > not=C2=A0
> > equivalent?
> > Not a big deal, just want to make sure that you understand what you
> > are doing.=C2=A0 =20
>=20
> Actually pr_debug() shouldn't be used here.
>=20
> We usually don't prefer pr_debug for drivers, instead we use dev_dbg.
> But as Boris told me that it will be better to first having changed all
> printks to pr_*() macro and then think about dev_*() macros.

pr_xx() vs dev_xx() is yet another story ;-).

--=20
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/20180222155105.097eb00a%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
