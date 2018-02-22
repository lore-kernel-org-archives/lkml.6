Return-Path: <outreachy-kernel+bncBCT4VV5O2QKBBD7SXPKAKGQEVCGF3FI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519319311; cv=pass;
        d=google.com; s=arc-20160816;
        b=bERlKbLirTVRl1ISpFKnBq1E/mfgIu9JRrL26LNUoaqdViQJV5CbDgdd9DZ4kV63Vc
         Yx3OBewNciDKd1oc1fNCKZcmgeBNk7d7GqMyL05blDIwl/+K0IChZdBX7AFNTl17g81b
         stKhqkDA8F5u0clDEm+2BmtIykUIdMztEzXAL82yFw7ZkL5xfUdo81CdCT72lvXKbAT8
         Kz3yzfo3LT1d+/mDu5/BcuHQhycApNkg9WlDG+o+Jsv7E2Fk1n3gUi5TTNVz2QGoR/zT
         VXRiTrboRr3aPbLt98g42U2ffnQv1p/WiZT3YRZUluRnI3UOSWV8ugNKMx5x4CYKinPq
         MAzQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=7eednpgiKwjT+iqCAVEC2bvbLcwMj/m8kPSsorysYkE=;
        b=uWQTsBhyBJhy7ldXfYq8CPu++OYFdZralUAYf8JBWUWXPujO+dtkxg8CPq4AJdkF5I
         3ng9IQjCg0zdtmJPrgXBGNnhslRuEebVbEgEBIGch8JbOJIy+yyNXRkQMfyqUQAdqbdy
         01i93BsFrnxLH4h3QB/PkiGdQjgoNPx4Ac61TdStByi1V/swNCg7a9xglQEx7L4umZro
         dSz4WTgtfqhKzw42waP5o/agL4dtoLoalwpP/BBhgREVpXFKBD5QL/H+yHJ33T4ut2bM
         OFBvuBeejgnGcvuXGgxwx4DoSPiUdIcOc8dmUQ9HgO1ppBfxoSK8tPD9KgvU7UyuhKjK
         E7jQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=oNHaJLkN;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Rrh9CjyZ;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbct4vv5o2qkbbd7sxpkakgqevcgf3fi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCT4VV5O2QKBBD7SXPKAKGQEVCGF3FI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=oNHaJLkN;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Rrh9CjyZ;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbct4vv5o2qkbbd7sxpkakgqevcgf3fi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCT4VV5O2QKBBD7SXPKAKGQEVCGF3FI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519319311; cv=pass;
        d=google.com; s=arc-20160816;
        b=a7cQ06Pyzo9haLZaZliF4Wd9mB/OZI9unUPPuCLopLdHrXhS09HHgCkjftojDlVqMN
         oMMouHnb9hyzyHTPL2eeLpGudyAKqa3XLk7gsiqF9hA+m7Fk8jxrhGgyhUs74EL+dAuF
         1PkB5p6RViswFv06SpwJMMk0vgD6ObpLLvroxMvBKJjylREl/V1A/cokskqWpUHiFyk1
         DTc7uc68J28DXOJoFDE2wl6Is6dFPXnOsDJ7yeM9pFZQI9uvzGzLjiFx+GItXuEZk5ri
         G7lVI3f4thb0f/qyxsGCuhtzgh8zTYBCBABj1QZvdyAyIzwi3HxdA5SswHYNLgtoxo4Q
         nzmA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7eednpgiKwjT+iqCAVEC2bvbLcwMj/m8kPSsorysYkE=;
        b=dj8dU6/TfOeFdJ/1Tt3eIKLeDpzl2I13o56g5b89x5EyL1kXJMiXvM8IsFSHXUEZA5
         0A+sS1MXHVjsxzTUZxz1DxuPn2KhIfP5YSVJTAfbyh+Ij+KinS04+QMxt1TflDhjA6V8
         9b0rqNImP5o46waz9RXspcGTRHziOBgTVrz63xpwrkmMuuC7BxaeNLnINDyjoKh4oII2
         LbFS52wQfvPtfmgAKMdyJQ6b9i2SGpV5/tTAakY9MLquQvYO5ZX2NQdOoViDOygvWMS0
         kEitSpojmsttPQqKav8GuNTqtZtlNZPzEiVHL7eqNucDzzew+fAbVbdqNjAOSHNz9UG6
         mHgw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z1l8h+0B;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 2607:f8b0:400d:c09::22c as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELvl/oD2nR2uFGcSEgwe1jDTK3Osd6f6ZseiaxpUmeTYRXjmR6Sfknfmrcj8kvP5W1EVeuJQ6A==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519319311; cv=none;
        d=google.com; s=arc-20160816;
        b=k9gozRQxCcFKlIhEFJ6HPsnNasZziUNadqla9oYpMWiWHDw2fy6xMrgCJXM0N0Hb9V
         Cfc0lsuVldfedYkYashbQhjActZMTwkd+Jith/g7uyJVx57icBDDJV4AdzjicI9LKvlc
         NYxHuK9xBRzXXl5PVu4e0N/eXUAcyMSejxjUCT1TRm4cIQZ2QZ3KIaN3BGk/Fad5w0n+
         1ZzsxOU5m97phoUnyvV/zbe9eQi5efYapxiYvfbDxF6Q65EnRBASTkJo6ejOeX0F1m7+
         n0s92N0UPRmKUQFrFffM2ilQqsylZhInXHTlhLxkwlFSv6EeafnJclZzDduYhUEGGw+3
         eWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+yqKRPx+d4uDzgmTrYOYVWMqkseXXvHrXIjUcMuazkU=;
        b=n7JR3VeWNfUH+y8KDiVAXgh4SInm3UwODX2eAq6s2DIZ9SeYfjHJWATYjvEqEtgPsG
         9znM+O387InPpp/tM4VJPlxwpa2qe/iL77CGl4ROpRLJb63XreJg0D6Ft8Ts9iMXnCWY
         NQvyJv7co8KsL/840Rksdm1Rlpq65GPQNzZOosCpluwMcd71pb67QP+0uzu+bytnJhNG
         N6V3r//PdzymAgyibgeE0A+bGqCGojHLph9pOuDUngTcjYBSkSG19ZHZ9yFn0/4wwoPP
         Qd+RIHkc905DE4/ROmiqiD18bO7gyK9ojmS2Yh5b2RiH2xyCwKgEiVQSi3ifeoevotI1
         pdQg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z1l8h+0B;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 2607:f8b0:400d:c09::22c as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
MIME-Version: 1.0
In-Reply-To: <1519317082-4790-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519317082-4790-1-git-send-email-shreeya.patel23498@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 19:08:29 +0200
Message-ID: <CAHp75VdHFAtGQ7=tRJz=dZJtsSnK_pKbUV=-8WAGOSKJwOQU2w@mail.gmail.com>
Subject: [Outreachy kernel] Re: [PATCH NAND v5] mtd: nand: Replace printk()
 with appropriate pr_*() macro
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	"open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ezequiel@vanguardiasur.com.ar,
	outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: andy.shevchenko@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=Z1l8h+0B;       spf=pass
 (google.com: domain of andy.shevchenko@gmail.com designates
 2607:f8b0:400d:c09::22c as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1593119442965474552?=
X-GMAIL-MSGID: =?utf-8?q?1593121767081803776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 6:31 PM, Shreeya Patel
<shreeya.patel23498@gmail.com> wrote:
> Using pr_<loglevel>() is more concise than
> printk(KERN_<LOGLEVEL>).
> Replace printks having a log level with the appropriate
> pr_*() macros.
> Define pr_fmt() and remove other additional macros from
> the replaced printks.

It makes sense to fix indentation, like in case similar to ' mm?"":""
', and fix the specifiers, when
void *p is printed as 0x%08x or alike.

-- 
With Best Regards,
Andy Shevchenko

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CAHp75VdHFAtGQ7%3DtRJz%3DdZJtsSnK_pKbUV%3D-8WAGOSKJwOQU2w%40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.
