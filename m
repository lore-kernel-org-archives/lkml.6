Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBLVPXPKAKGQED4QNQZQ@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519310766; cv=pass;
        d=google.com; s=arc-20160816;
        b=mSK1td8mV/cGlKivThU627TOVnhY0hECi1wSmC1XJ5IDRM+Rd0LOwe+DiKQpWgdl3B
         uYI7URW9e0OLBdo6VdJcFcDz+1YnMYBoKhMb3QUvDkmOojbzimEtpyY0Ufpc0VosN7lv
         ZjY5hZV9F/os7EblSDWZWdjBBXlX8YAq9VdZzaw81EOkgNbZB64CWLTINiUioPi6tKU2
         iyR+ZKjh0ZuqeLuLTySZY9i9K/fXC547JYuDNLudrkZJF5MoHbUqOxtGx41IparsAi1w
         Lh/mJAP47/LJPdpfXxX0pxVnQdbCe3Ux2fAh7gphH0uQdoc/LN0C6n6wjyQwv6MqPI4U
         TbQQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=tHnPPxjfSYQ1WHvOTd+oRPICzETb3WJifCBxVzgwtYs=;
        b=th7VHz56EsuZzbpj2Q0IcrEHWGvMIhpaXZ3DmCFdkN+OvFU8bveBoV6cDLpIs1qFNp
         cJE0lWppMvxGj7I+Hbn7FcS48dYfb/HYe96p0b7JnSE6rVC78ackiQOL2QV+7nBcChZy
         Ti/1RxAWQf3cVHl1YQ7wK+7KPoij6ICSAxycHImEa4vcsJHxd5k18KXxzM6oF/G/QEZJ
         clPdZuSMCvunECMGeePJkjZbB6vNEWKH+C5iTozdGkjBZ/Gq4DOiXHT1iOtU1QmOhzKq
         ASUHu9z0VgvRhmpsZp87Q/VurZOwlUynasGhoSsNiuLUi1L2RyLx5I+R21pRJPcDybkG
         ZWyw==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=JAot+aqo;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=F8f/Gz+x;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbblvpxpkakgqed4qnqzq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBLVPXPKAKGQED4QNQZQ@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=JAot+aqo;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=F8f/Gz+x;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbblvpxpkakgqed4qnqzq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBLVPXPKAKGQED4QNQZQ@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519310766; cv=pass;
        d=google.com; s=arc-20160816;
        b=mtkFIsdpgpj/zoiQW8lq/SFmvPoHSCWJmSb+EbuIwT3DCoMcxcwNYpwWY2J3LMSDIF
         ba009EIeSK1LuB+2H5aJqlrtkx8qJArXlcZ7AmDztzyHtwgj3MiKEvVHzZ0u4uN2QnPv
         Eee1eKiiH0MnOhW0s5X9IfsBQEXAVNvCtC9KDEMhUgWSDya1pTGxpnJ1kHOOCs2bsPUV
         UuyfyQtKVSxlSaPE/GwgqJRnSmzgVcz8vMiMqF1crNA4S2uLE1zo1oudPuFnz+RyPaRS
         maolFGf75oWaPIyuDQkfY5jWXSoRdtzg5kAJa9C/RR5Aa38Mim662EGw5MJABxxiUbt6
         QB/g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=tHnPPxjfSYQ1WHvOTd+oRPICzETb3WJifCBxVzgwtYs=;
        b=XaKu0biN/GZ8jsBvjMlaMKxw93oZWaCopdb44QakcJdLHvmSWVlhoQEhghK3sekIju
         NrKT+xQL77qiXh2vgR3d2sZS59+rH55OoNKyEcY1IkCRIDqw74pRBycOFfdUXsyEymsw
         k/OdKXDMJFq//CHgi/dIs6nS5FzOQR3Gzuka0a3fOtpYgIcg/H21W6hGyNj5ElRvwBmh
         TITF0Y1GXo5BmU4wPO4ECy2uS21KUOzlRI8DeFTkipTA0XsVnacq4pr4zA4upvneiFH8
         q9pkvfaS7NjXX2nP7nHQY39mf+St2XWjW0H2lTI/4zV+5x1qMMWxBehJVJMeWEsZhlcD
         z4vg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hRu0AVgt;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c05::22d as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x225MrP9bceKXXUmg0B/GxCIEz8D7TGA1XhOtt3ydkU9T4BH13lasCQGhIJkHgWtmIAJ6yxZtww==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519310765; cv=none;
        d=google.com; s=arc-20160816;
        b=Q1W2S0/zq2vUoTbNpGPOSFk9EF+akbFPjaa/Ow6p00V5NxC0GECohh6NIZd+0OpSr5
         5NA4JNm6Qygt5bvPsf2DJ0j/jRhSyBavFIfA8Yc+NihHdL1UaHAwLHFB19VaHD20cSEk
         snRw+sgU6RI5Vlv9IGIeLuewjQUmsOlc3a0ZEUmnlY2SPxSz6HkeODzTOQSBCpaWu+7H
         ZP++1N0UA5ybjAalQCqZZMXEgwWtMLId9AOp+JOZ3MHzfl/RsET5C51Ytc18/jrxd/O5
         4aiww62lhcry1+VJlIEamu9uROZNyObtMj4FDjgwLRRLL10Yxeqsf6dobz3X1QMTlWW4
         iG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=1glkP170wbFmWUaThfP+JyIssl2xfJx+z7YpVx/f61k=;
        b=mB0zkO4TdSdRwIzhD4GKMmYxE7VcORY1HriLiO2Er6LbyZiPAead6xYVpb8piWAW0k
         K268jssxS92v6XJydyuRcJdCsah7qJDTJY6BlyVXOfVyj2qTbfvstHZYgjk7YgZeWRF/
         +TnwS2eQL0i3ZrPtc8+DV1milGYcdXWR/C6wz9PrO+mJ/v917CmWBWZPJtoYxC23JoHg
         p5IyJbyyWhtoU48F9kZnqnpQAdnxLsv3Dg8tYat3sx9jnXjJG83EQS0VmFcwS4z2eCq2
         aiOvb5B7r3uoEzmzGnCB+TEBN8GJzn6QjpiSTQ0BgBcgu0uOfTsJMc7hZaZ+uoYMTp7w
         kwWg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hRu0AVgt;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c05::22d as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Message-ID: <1519310758.2359.3.camel@gmail.com>
Subject: [Outreachy kernel] Re: [PATCH NAND v3] mtd: nand: Replace printk()
 with appropriate pr_*() macro
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: boris.brezillon@free-electrons.com, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr,  maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar,  outreachy-kernel@googlegroups.com
Date: Thu, 22 Feb 2018 20:15:58 +0530
In-Reply-To: <2093598.TLbMltDcSo@blindfold>
References: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
	 <2093598.TLbMltDcSo@blindfold>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=hRu0AVgt;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:400e:c05::22d as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1593106783204445682?=
X-GMAIL-MSGID: =?utf-8?q?1593112806250791022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-22 at 15:30 +0100, Richard Weinberger wrote:
> Am Donnerstag, 22. Februar 2018, 14:10:14 CET schrieb Shreeya Patel:
> >=20
> > @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct
> > mtd_info
> > *mtd) break;
> > =C2=A0	}
> > =C2=A0	doc->chips_per_floor =3D i;
> > -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> > +	pr_debug("Detected %d chips per floor.\n", i);
> <bike-shedding>
>=20
> You are aware of the fact that printk(KERN_DEBUG and pr_debug() are
> not=C2=A0
> equivalent?
> Not a big deal, just want to make sure that you understand what you
> are doing.=C2=A0

Actually pr_debug() shouldn't be used here.

We usually don't prefer pr_debug for drivers, instead we use dev_dbg.
But as Boris told me that it will be better to first having changed all
printks to pr_*() macro and then think about dev_*() macros.

> :-)
>=20
> </bike-shedding>
>=20
> Thanks,
> //richard

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/1519310758.2359.3.camel%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
