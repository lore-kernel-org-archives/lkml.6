Return-Path: <outreachy-kernel+bncBD2YBJOB4QPBBW5HVPKAKGQE4L64BVI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519047644; cv=pass;
        d=google.com; s=arc-20160816;
        b=aDbOKX1gaPu2iHGZ6WPYue6u6eSWiBMsfIh8SL0XDPxKUvj2WsdzdZXVNQNaI+jEH5
         C8IRjAk8IZ3Cv8bhFAzVbomXwXeS9B3FLRjZ1OnqOXnMBJO1pMTinsiQ/TaGOqWBGZnx
         yTfWRC5Gd0b7qhiC0o52QBAG/Z/Q6CXKXJ/wMy+HNEWli7UP0RIuJhojUJMxHrYDVefB
         dMfRBb2CCGwHfGwmpyYwB8iFW0sCsxCCra/JsWZpvH7M/UiQQOakAKMD9nnDLNchGKNn
         ZPLHGq1zwV5avMv+qfaZlulnC1NdgfZV3mMMC+48d9X2xvlAQr7TqPmEVWO+P9CXuJVI
         Pzhw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=gOPuTLd+7usGzE4V+oOl5KUzRX2VbqBNKL9nb4DgNQk=;
        b=dBN3NdnUZfQoj3InusOV3BmTqMClWpcHRaCipOSa15l96jKdl65LA3z+RWsw29rKcY
         R+f3QHQnv8LaLyCiNHix3YJ0w/RjjULhzdp5mDO6h9ecySDEakesGxujKTrDTNwZLWiJ
         q1OO4UUEsJWqd30LU9Dl/iEjPMemCD7UDyS7dPYPNrORjG9R+2FSOJkdIhPrSwjUkAjI
         K6LGRTfX/WrakIbdMZZYCNi0dknUNNejfY8zkWgWrHkz3zCgr62JA4RD6FNybJoeAKT2
         NlOQNJseO1nMbbuMiK/sVC/0yQsCGTbTRH8IzaBmIpcXsLXtvpA7YVKAUVTtXYb7aJV9
         pAkg==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=DoLjRE7m;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AwgvCR57;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbw5hvpkakgqe4l64bvi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBW5HVPKAKGQE4L64BVI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=DoLjRE7m;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AwgvCR57;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbd2ybjob4qpbbw5hvpkakgqe4l64bvi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBD2YBJOB4QPBBW5HVPKAKGQE4L64BVI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519047644; cv=pass;
        d=google.com; s=arc-20160816;
        b=MaBe6zKkOJrBDiRTchvslCyJIQL7CYQIMPV66X4ZRX6HIX7t9KZw9eNh6m+hc0IRL3
         fMQ1qFQj/EM71YPUPibSIZMQXJJbPFD2uu3xietR3jePsR9faJNHowwS7OdONwzp43D8
         2+EmCtXtNo+zkMpBkBsBlGb6C8ny8epsLKqre2tacQtgCNQXcQ1yhBl6jSWVrWfD96qC
         9+0E/ey1A6iSKjFmwrZR776mvTRG6/qyRo/Uj19cjP3ULnTp41X1iH3yaBR2+YF/WLml
         776dqgPW+OeQVJAOGEC6iAWtPaqA0/H2eonFBLj4sVWM5J3jZN6ncMtB4Qw9uNKObASU
         Gocg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=gOPuTLd+7usGzE4V+oOl5KUzRX2VbqBNKL9nb4DgNQk=;
        b=VIn3xKNVnNwIk8IBenyCVgNBAmRBdsF11Vp7JgjlatdAG77kvkA5vgGfgp7TKw5u7N
         9PM1DYaiPUWh3r9T6DGiJUGmsU5ZtJgbAFrm4R0x9qTxjJRs+atXKJNsbHWuVzEzZIRE
         HyOPfuvvMjxng4kZqw+dh1jEPVNT7ns3zg2+JfRxc7kfP/joEuJ8pTFo4kLNQMgqhnJL
         kbkCOF4yuJyPQbSt5RRCEWAZyRnG3Rs7HHUVKF0HkexrcWj90MqXNsafC6jhIDXqT5ry
         F5dlJqhmNpnue+Xw7wFqY2ZmZCdZCVSmD43ZZuvLAWPThQiCXfuJgXtRuT88VjQNFs6C
         lE/g==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XrqE2XQb;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c00::231 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x226dszkAGtgUZ+DYAQ/TyeLTjF7Hj0DWvlWNrT+z/JGT0IvFLf9V+LsT4CzHdWTQHDTSQVYTmg==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519047643; cv=none;
        d=google.com; s=arc-20160816;
        b=j7dfXw0vS05qOHkav3nMj7KxDTCfAzCzTt8ROVmWuG9dEF0r28hcENy0bXzsXPhVFP
         hZC9LG9p0M9G79BkIbTosMoLXTm+koMwTFE8nplyrTyWnzHCeXOjKtj6m9h0sA9X7olY
         a07DG9cVCyKu5LlXxu3THWcQUAyaEdcd/V6eA+se0Te6uom/K5hben9aJvOUEmHCvlVF
         EsBV7jvQR/kLFoJfJA2pRMy6T55BHmeSigm3Pa9bxZKLJzwey6AGw7x1/p90WGAFoffG
         oUmnO91omWxa1MNX9RnY34vDjmF+LFIAnGDgUTSBxX261D3DQUORCSZ7fxIHl5pjV3Uo
         hVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=37Vn7zBGKYtdhGIN77JNbWAj4PY4rio8BZ0xdPnfzXw=;
        b=JKVaHJSF8LooFiHaV7hceby0hot763dMsRuTllQwGbnjQwyDqOikydGObJtvz6UBGy
         N+XaGK20uzoXMX+e7cTJLO0eyTrKsy3oZf3FjVlmScLALHdRpCA7oD7+gj8OmpTi28I3
         L++sAqmvDoOxTlwzFTzcQDlrZuGi7jIsljfujyubZb9N4RiRooUeZ1WaLhp8EatbqI0u
         njMzgAK6ZHR6iXCL3tN89Fu6Wr6j1dyPBXZmBhV82NzxlE/NuMDzyMIG7Y1Nyw4QRS5A
         B0sJHQNRWGf6aRnJoEsiLPS0BBxt2ZcJFWkYmJV7m3TpM2PKFn/7brWm2h6voQLsZAYh
         R5tA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XrqE2XQb;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 2607:f8b0:400e:c00::231 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Message-ID: <1519047636.2063.3.camel@gmail.com>
Subject: [Outreachy kernel] Re: [PATCH NAND v2] mtd: nand: Replace printk()
 with appropriate pr_*macro()
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: boris.brezillon@free-electrons.com, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr,  maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar,  outreachy-kernel@googlegroups.com
Date: Mon, 19 Feb 2018 19:10:36 +0530
In-Reply-To: <5296610.PbIriun04K@blindfold>
References: <1519046025-9412-1-git-send-email-shreeya.patel23498@gmail.com>
	 <5296610.PbIriun04K@blindfold>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: shreeya.patel23498@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=XrqE2XQb;       spf=pass
 (google.com: domain of shreeya.patel23498@gmail.com designates
 2607:f8b0:400e:c00::231 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
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
X-GMAIL-MSGID: =?utf-8?q?1592836902903786865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-19 at 14:30 +0100, Richard Weinberger wrote:
> Shreeya,
Hi Richard,
>=20
> Am Montag, 19. Februar 2018, 14:13:45 CET schrieb Shreeya Patel:
> >=20
> > The log levels embedded with the name are more concise than
> > printk.
> > Replace printks having a log level with the appropriate
> > pr_*macro.
> >=20
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> Multiple patches with the same subject are confusing. :)

I'll keep this in mind.

I did not combine the two patches as they had some different
changes.

Thanks :)
>=20
> Thanks,
> //richard=C2=A0

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/1519047636.2063.3.camel%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
