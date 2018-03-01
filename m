Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELswBlVLHVrzNdwpKiqpMBGxOkzcyNr6NEgX2MHL2f2Ew3pYl927OGH0qpyF1kkFt4a8HDmY
ARC-Seal: i=1; a=rsa-sha256; t=1519916625; cv=none;
        d=google.com; s=arc-20160816;
        b=d4qCSpntcnom/1SOc3RBu6nIVejQ0zB05cz/1UeTbz52sF6PtFk3N59E+heKilMzEq
         LEgua6AXeLnU+6JeHDQ3gFEYE4EpcZ4L9X9F2niKDkUJHwHN8e5px+fZkb+56YTumSyo
         dIKMxfVACSqIJL5Ih99LBnsUAaFDDEjL41xoaqkmRsRFaiIhrcuNklyYGZuXV8aHm8nf
         2OREmY/JCoyabrZ0XkM87bkDH0Y2m18dO8375yCVAKvGz9Lrxc1oqBIjleI772+wq51W
         0Ka8NxIfN9EzOmZFVPTxzfto9q1Wk+yGEe9Xm49knxSG6nd7Ic2OAINNl73ASJeuVb06
         NN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=dngUkNj/jBXBPwxi1v+J4jncRYU09T3fLA8PzEZSPqc=;
        b=Mes4m1qVSAhvqS8fDe8Jd+6CTXKABYOi3z3J3ButII6Cho7pw/4z1+BFzqHI90CBuq
         m+CXz+QCN4w93BCRbrOSUS1qDUR52enJTRlhE6LnFQjjSfjKNEz/MU39TMCIlZd4TZ4z
         2a1FGIzkJsjccn/bfhj27LrF5VFwxNpxPAJiHPGp3soeS4PBrJ8zr+ilyqLzGFtv5z0M
         AeR9CvgbFJTW6DBbN1ir/ojMjGxbyEe4MlSkCY7YeczvkcMotxotsK0XI5B4mkiONIUn
         roylIC8dhMQ+S1WMFbl31A5JsHJ8qNUt7dX/KnkEoGdUzyR/f6KDeUqoKtxmR4JY9T8O
         ipXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=3AgYQD45;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=3AgYQD45;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w21F3RYx028990
X-Nifty-SrcIP: [209.85.213.42]
MIME-Version: 1.0
In-Reply-To: <1518806331-7101-4-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com> <1518806331-7101-4-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Mar 2018 00:02:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5TT0qcnVk3yMATvw=g_LwLPJ36pZBWJhTF=aQ3aSu4A@mail.gmail.com>
Message-ID: <CAK7LNAT5TT0qcnVk3yMATvw=g_LwLPJ36pZBWJhTF=aQ3aSu4A@mail.gmail.com>
Subject: Re: [PATCH 03/23] kconfig: add xstrdup() helper
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925439348866?=
X-GMAIL-MSGID: =?utf-8?q?1593748095106009782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-17 3:38 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> We already have xmalloc(), xcalloc(), and xrealloc(().  Add xstrdup()
> as well to save tedious error handling.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


This is a trivial patch,
so I will pick it up now.




-- 
Best Regards
Masahiro Yamada
