Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBSUAXTKAKGQEUV2TRQQ@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519321163; cv=pass;
        d=google.com; s=arc-20160816;
        b=veiKAs/O07eHZGY2QAwipEKg9GUDy/011Kyy9ENsr+S6A5SUmiw0oP7l68h0NL0mje
         uHr8KINcG3D/y9w6mbTMAT8uQp+F1t0lkQRWTC9/sa05ATI49D0gn9Kmsig3LSFYLMxq
         lZhfTNF7cLULYuCCaMskiaE4kIiJnbdecX3TcnGyWV77ErgT5tV/qRHXgaPWitgDB45e
         bPALdiVwXdqNlnIe653KWvrju9OY0jywE1NvMPtBNIWdiPMyOUYZGGJT3MD3+UVFLKpn
         2PHKejOIAnALbr+r8d5Qxipx2QiLw1kwdV9TmbR7R9DRKkuwtGvO311EirX+3DrGl+q7
         lCow==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=Kxlce9nMWNES990Si7lJKT8ghGcP25n0+9HoQNgfxBk=;
        b=LVRIXYoOMAE0BNYe99sQVzonVGJgaO12+mcESyyiys5RsVWTVu2cV/klJi+h8IZ//h
         TKV81v1GCHvv9/XuAf0jN4yzWbi5/fFptDm6ns7aH52aBEZrxUb39ZNbLRLPXBeWhK9p
         qKeuaYk2klOHdXIhnWm7OV60MrPSIb4fwjOOgvnFA3kLLTZXjmtDvp4mZyYVbXQQ+IUL
         x3jbxG3k7lpQo03MDehJh/J76U1zG1cxXBy88osSo6onPx5ocDCmJavr5yFEzkKRyO0s
         Zq3U3uVwzgta6JQvponS8Cx8wFj8kvzb3qqAUnM8wkc0obc8v/GsE4xW8JeprKPqwjU5
         q4nA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=tmBQRaGl;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbsuaxtkakgqeuv2trqq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBSUAXTKAKGQEUV2TRQQ@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=tmBQRaGl;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbsuaxtkakgqeuv2trqq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBSUAXTKAKGQEUV2TRQQ@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519321163; cv=pass;
        d=google.com; s=arc-20160816;
        b=EDOIS6VhDcshzHdhLhzuZkloUDVIj88SHdPjvr/Sotr2SJBhewcjFw4hfX5vxja3jH
         WzRMZ9jI+DdQn4qwJEp4ZSrpYM0Wi40/thyMaOytMkxdJdxa4Eh2RPm8oHxPQV5KiukT
         vukLhtKEvgKxf9+Ec98T7YIZgi2EVJL9fWWBa7gcv4y2ZTdRWCCHq1Z21IJFzYADgNVK
         nLRhDTe4EeFeSRd+sg4mnkghuodcfJAo/9kewv6M1+M4BIqw6Q0YS5uIDseIbyJtGTg0
         AwtuOvpXKgshd1pxl9vOi9FVVkwgfl3fpGOEhATGrvAfl7Bo/2/eyNwoVJOkqaOAfNgF
         SsfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=Kxlce9nMWNES990Si7lJKT8ghGcP25n0+9HoQNgfxBk=;
        b=00SrjJqSOPbo15Ads1x/ANNA+NwVChzdMOy7/671r8yNyD50BVsi+qonFlz3hAmZGU
         PLriLOazZyg2jw3Q0gW7v9hI10ByRX/qCG6VJ3ByAMdwfQR9DjqRZIwT8OmrKkQE+xjm
         8iqis01dQCVZX32TvJO9cmDGPUCBiEtN7Wh1BP/eqwFtptYKHmHpF9JVSLngdOj827eb
         jdy232d7fpiYwsgqWFQn/4NjMJFNcF/xEnGVKyc0EwVPNVs8i3je3LhkWATKjAJp3wer
         w/gw2kmPxXC2Ml7h7oLiPeivI6YrxMQeIDlDs4Qyq7GpOrEIH2Ly7hJPMDlFezzOAnnD
         OyLg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x225KUxdu3WjmFfiHVzI/44qB9qGQ0nJ4LBc1Xv7Dh3T4Pdqno91n9uoJqCrRymidk1iTMCxdZg==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519321162; cv=none;
        d=google.com; s=arc-20160816;
        b=IVazHKqFDgz3q6HQxAnJMBELb7VtoEcLd4M6CzS8xMmhvMWT97wPv3/2QjiTvg2vcv
         DY8wr63ZJpUmEwcJYQocAo9z8ZA43cEpgVlW8+XlpTTmj0cZOtORNcWbJKKi2P5Ukfh4
         CVVDsCIm++uBeoH5fqrEw7quC8IxfdMGEUGlQgPh/X/jRKlnIdDQfRCEXNOQ4Bpm+8BF
         W7/nuMzKljpK5aFQco4sO8+//AR90Fka1I/NLGQsdU9x6Gd2cKj1QHzdmYWsALD8dq5Y
         rVGb9Q1QZ+YP3YfwBdkSn46OSypoeHafeqIkznhyUWv8bk37OpUyx0RuYl0Tf5+4ud51
         xwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=LUnNU4LclWJ0S3JYAdJejWZimU9gjE2ntVKhbf0Nc+A=;
        b=uQ/nIv1QJXeZHM6I5x+WLLifMOaBZwli9BJpf7cqR9St7U55CpiIxpl4dyNm8EL0gp
         bULYstyWhX5nRAr4JjKjeVDBsrhvRyn5CIJhu4vqrewWo3IEkh2c0eHmA7eblDYzOVZY
         uB2bufr5/seDBYPqPOnRJ695cfiuSRlJ3T0ogVFie7jJ2SpxDV4iaTF+YALC4CgZ3Oxd
         Y46bdHfze2LYUn/f8XAN5aSWK91bbsJjGUVJBWfN5BjvZaQ46wqawh/UpNuL96F1NeIN
         VCC14S8jQRF6XGkzcHGRbmvbpVF8bwXjE9bm8VKUSr7idWoQ4dzRp41Ikwe5Veyk5hbw
         l0nQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Thu, 22 Feb 2018 18:39:11 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>, Boris Brezillon
 <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
 David Woodhouse <dwmw2@infradead.org>, Brian Norris
 <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille
 Pitchen <cyrille.pitchen@wedev4u.fr>, Maxim Levitsky
 <maximlevitsky@gmail.com>, "open list:MEMORY TECHNOLOGY..."
 <linux-mtd@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, ezequiel@vanguardiasur.com.ar,
 outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v5] mtd: nand: Replace printk()
 with appropriate pr_*() macro
Message-ID: <20180222183911.51e00722@bbrezillon>
In-Reply-To: <CAHp75VdHFAtGQ7=tRJz=dZJtsSnK_pKbUV=-8WAGOSKJwOQU2w@mail.gmail.com>
References: <1519317082-4790-1-git-send-email-shreeya.patel23498@gmail.com>
	<CAHp75VdHFAtGQ7=tRJz=dZJtsSnK_pKbUV=-8WAGOSKJwOQU2w@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1593119442965474552?=
X-GMAIL-MSGID: =?utf-8?q?1593123708147898106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 19:08:29 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Feb 22, 2018 at 6:31 PM, Shreeya Patel
> <shreeya.patel23498@gmail.com> wrote:
> > Using pr_<loglevel>() is more concise than
> > printk(KERN_<LOGLEVEL>).
> > Replace printks having a log level with the appropriate
> > pr_*() macros.
> > Define pr_fmt() and remove other additional macros from
> > the replaced printks.  
> 
> It makes sense to fix indentation, like in case similar to ' mm?"":""
> ',

Fix indentation if you change the line, why not...

> and fix the specifiers, when
> void *p is printed as 0x%08x or alike.

But specifier fixes should be done separately, and I'm not sure I
want to receive yet another bunch of cosmestic patches changing that, at
least not now.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180222183911.51e00722%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
