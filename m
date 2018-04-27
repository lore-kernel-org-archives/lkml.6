Return-Path: <drdeimosnn@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524819284; cv=none;
        d=google.com; s=arc-20160816;
        b=Qx3xPJtlPkpx+SR+QY2jyoibJBD9yLLIfJEUxXwpIAWFvT/FLxjsbFVkbxT1Magyki
         iGQU8NlAFmYYrxR3Mp4tohl2Yd5GEeBRQkeKTTSHSfVzKEVUvXXG2DM3petA4FIMFGFh
         JLi7YZupiKlcjbdjkL9UTC+Kt2iekUSn9PKHgxauyhKACs7VbMx92zhOiZNG6sgXm+zA
         2fhBppqwcnfRc74zYTezf4qIlLd3TcLxtYR8Ngm01qUvOyTaWvyfAdOkE8MUY87V+Lfb
         Wn0khBWu0OVziRTGQiHQkyC6ySwV1TGzq4AkxcGgFR9A/EAjLy6xaBtt1y6ShbYQbIm0
         idWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=I+n2XkDc9kxbo4yrjb6/9t50CHeI+tOzZM+13hd9gbA=;
        b=kC+S+dOwaOc0DRr4alQdsna8adNzoGf/RKwdp6uCTMClMvgzEu+EpEgnKRw2uc2UzV
         ra0tmoRkHfTb8xzExy9+ZI5bW8uWux/2C8/ECoj2y8tS2HD1J+PUDE+ubMBlWYbWDOas
         +8jaRxGRyNKcFPuBzEXt7iDJzVm3tz3czqj7uyLxWXxG/xAdSAEQYvZs7fPl/TazqTBA
         OsJBaTd1GCOrOiB8dnoNvgr753zVUzxu2pA5mvbcEopP6x2DKgWjGxNXO1mKY9lqrGLv
         gijChO3SkKwLR9PnqJWbaMXD+RBej6IIg9Y3nN68rnf67Z8mvRrpy+Tzf8wkNNkJKBIv
         M8iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dl7Q4H2I;
       spf=pass (google.com: domain of drdeimosnn@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=drdeimosnn@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dl7Q4H2I;
       spf=pass (google.com: domain of drdeimosnn@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=drdeimosnn@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZohuTfRuHCVaW5uuZ0ZGGzVH1p6JUVz7xiEeyP++3ooCq3rmJbiu5N4rxsaC9ntpTQC9yl7tnDqwD/qLj7fsGc=
MIME-Version: 1.0
In-Reply-To: <20180427073004.GA12770@kroah.com>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
 <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com> <20180427073004.GA12770@kroah.com>
From: =?UTF-8?B?0JzQuNGF0LDQuNC7INCd0L7RgdC+0LI=?= <drdeimosnn@gmail.com>
Date: Fri, 27 Apr 2018 11:54:42 +0300
Message-ID: <CA+MChEowy7zXtfU2Z9f2KgWegDELPVX-T_rAfEY7NquUHCVsqw@mail.gmail.com>
Subject: Re: stable 4.16.5 hmm build error
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598847241183995427?=
X-GMAIL-MSGID: =?utf-8?q?1598888905683696237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>What .config is creating this?  I have not seen any kbuild reports of
this in the past.

.config - https://bugzilla.kernel.org/attachment.cgi?id=3D275579
src - https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.5.tar.xz

2018-04-27 10:30 GMT+03:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Fri, Apr 27, 2018 at 02:19:24AM +0300, =D0=9C=D0=B8=D1=85=D0=B0=D0=B8=
=D0=BB =D0=9D=D0=BE=D1=81=D0=BE=D0=B2 wrote:
>> Oh. Yes. Tag v4.16.5 without commit
>> 9d8a463a7016e9e5578a561588a18acef139919c.
>> It's in v4.17-rc1/2.
>> Thank you.
>
> That patch does not apply to the stable trees.  I'm also confused by the
> lack of "real" git commit ids that are being referred to here, that
> commit refers to one that is not valid.
>
>> 2018-04-27 0:52 GMT+03:00 Randy Dunlap <rdunlap@infradead.org>:
>>
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D199515
>> >
>> > kernel/fork.o: In function `__mmdrop':
>> > /kernel/build_kernel/linux-4.16.4/kernel/fork.c:600: undefined referen=
ce
>> > to `hmm_mm_destroy'
>
> What .config is creating this?  I have not seen any kbuild reports of
> this in the past.
>
>> >
>> > "It is also reproduced in linux-4.16.5"
>> >
>> >
>> > There have been a few attempts to fix this build error.  The kernel
>> > mainline
>> > repo seems to have it fixed, but it looks to me like Arnd's latest pat=
ch
>> > (9d8a463a7016e: "mm/hmm: fix header file if/else/endif maze, again")
>> > was mis-merged to 4.16.5 stable.
>> >
>> > Please take a look.  Do you already have a fixup for this?
>
> thanks,
>
> greg k-h
