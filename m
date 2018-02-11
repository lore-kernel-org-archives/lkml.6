Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518388171; cv=none;
        d=google.com; s=arc-20160816;
        b=eX2kheXMgsJncs1mRNNf7CcUq5uAq3/fD4/CCrWK6vRF1fm7j03MawZCSOhN/kD2bA
         f7+KJi9/ic5r9CCAp6aoBAwD0cqO1q4rWXoUsS/atZMAXxLNp3b1PvL58ee4UfIFCb/a
         Dw2FsyF6ZIrjSpTs3CVeE4rSf0FPbxjH9LuvJb2uCw9IewME26xJow9yHXqfOwFyr+VQ
         SCmwBaOXus72kaf5eiikgpnKoeORZYwtOMiMyKzmfSqWVIV1JSg08zECNqlrqJ5lJMZ+
         e9MtPCDGZboUo4QGR6M3TVFsB0wpzn0JIiOHFiGZ5b7PM3aTPnkAOKtr8YbW2leZtgy3
         QWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3pVo0AZgxQRSwx8Wf2D0zZeaHbrnwkSWVeuL5goHXpM=;
        b=G1ay2qiC8hKQyArOePw/mi8KTCv3bGpPbECceQ2NSHI28kpNwlGzvwZ4IzUYJYjzOu
         1IFzPYaoIGXGB8eUkNQnXAux+lwAmQiD+nqkelk10XaYZnZxxw2+USXBhQGJSUDsuVuX
         dyAUa4d8ZQnsviJA+uxBAYymj8RVvGjvB47yJjZhNnL8kpVqGw56l39oEETSgbIGlZBn
         OsVsdIxOz9y0++hiDBVGCp5mVq05ZXKI+I75t3I5wyUXkLhGb0YmC5oH3DpdhYNtd/7n
         vK38lmhoa3zbuJnZ4C4i8XB/poLSViHPZUxtUbXxIxtQdV2TfT4i7wN4Ef4FUI5rFM63
         SU0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=icTpDol7;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=icTpDol7;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AH8x226m3X7pPrwa1pHVoCrVKcqdNhzso3JdMertO6BqWCounKUoiLdBmB0tuFPIF4H7m5apTietTLfkU4+nbqD4mXA=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAK8P3a3DHkpbRxUTP77OoeAqRHDz-tL-qYxLfq61Wv8NUPmyjA@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <CAGXu5jLV-i5OAbXMQiJC-idXB+XrxMCC+RigQ+4R6eZWqn4rgg@mail.gmail.com>
 <CA+55aFwWQ4nL2Asmzn0NSsw=w-tX5hAM9bFiOZhxehnhWH+wkw@mail.gmail.com>
 <CA+55aFy4WNC=pmga19CHhrX9QwOJsu1bUvGL0oNxq5EeMW94eg@mail.gmail.com> <CAK8P3a3DHkpbRxUTP77OoeAqRHDz-tL-qYxLfq61Wv8NUPmyjA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 11 Feb 2018 23:29:29 +0100
X-Google-Sender-Auth: 3SRh_tmD1318LEnlKf2Rvwp0hiQ
Message-ID: <CAMuHMdWoXH3+bifmHAQb8KYz5Tsfz=zxRqAsVmfsexbucX6w0g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592145395355491671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Feb 11, 2018 at 9:06 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Sun, Feb 11, 2018 at 11:53 AM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> Well, it's still not a very *big* bump. With modern distros being at
>>> 7.3, and people testing pre-releases of gcc-8, something like gcc-4.5
>>> is still pretty darn ancient.
>>
>> ... it's worth noting that our _documentation_ may claim that gcc-3.2
>> is the minimum supported version, but Arnd pointed out that a few
>> months ago that apparently nothing older than 4.1 has actually worked
>> for a longish while, and gcc-4.3 was needed on several architectures.
>>
>> So the _real_ jump in required gcc version would be from 4.1 (4.3 in
>> many cases) to 4.5, not from our documented "3.2 minimum".
>>
>> Arnd claimed that some architectures needed even newer-than-4.3, but I
>> assume that's limited to things like RISC-V that simply don't have old
>> gcc support at all.
>
> Right. Also architecture specific features may need something more recent,
> and in some cases like the 'initializer for anonymous union needs extra
> curly braces', a trivial change would make it work, but a lot of architectures
> have obviously never been built with toolchains old enough to actually
> run into those cases.
>
> Geert is the only person I know that actively uses gcc-4.1, and he actually
> sent some patches that seem to get additional architectures to build on
> that version, when they were previously on gcc-4.3+.

And as long as gcc-4.1 helps me finding real bugs (which it did for the
current merge window), I plan to keep on using it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
