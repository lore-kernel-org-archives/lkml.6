Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226BxBaDj3o6nfOpOb7Eqh0MLAKiVpw39ESDWGHi4uFgxFxEjN/Z3qqgpg57ZuaUPVfKlxD6
ARC-Seal: i=1; a=rsa-sha256; t=1518486132; cv=none;
        d=google.com; s=arc-20160816;
        b=yBeEwffun9zMKg9xd5uWurlwkB0AOVGf+Rdl3/KY/hxJ7c0hqJXwLb516S9j5Kt43C
         I0cAA9zuj8aOav0vszkqYk9z0/VD27RQT+ITCmx7M5si3vne0z9nLiOSJvSfa+El2Est
         dNv4T7eRczGt33r6G0lbyrD5njcieWfie90xIK/Oq7I+uIgDkdbKseUHbMaNQiWBVXuj
         Hd1EXqqABKpatHt7v6clQPvFHVA0AULxpP+f5v63i/PnGXMVpUYduXhIO0N9Cc++195g
         bHw6wGsRGDYxMpeMt9o+aANBOZnT5fSJcONu12OM8D5aWsl/UCufVaRjHVbi8U0Cscoq
         7gQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=7pWLeBqbqA4MtDq7REe3kbcdc7YY3qX7Gz7g58Ai8MM=;
        b=z8CncILv1N0Kn0vd3YQyDFN7fvrKGn92SiJYG6OU0rftAxyEzHNtNjmN3S3dcNYLnl
         nvYGvgFRcGqyKWbGMA9/lQ4lX2Yw80o46eoUML5U4IDB3BvhdjybRQgv3CuNbAO+lJm9
         rwlporFlww8/8rpX3jYKfPJRHO3WsW0RrDyYkOaU9CLUsoysFMuiiXciat94fsHegALF
         vJVkkTOaw4RpI+o8RTX6iFIeByEaVF0eaxbTVm89SJO4H6UPWkcD3Cnn3N4sJQgkpM5H
         1fLcr+VOCHm0cy5cHZCVdJeAmZI9WEmh079/ytcHw6I6NpKtvYXRB5xc0yh6EtYz9+Nc
         DUpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=SSVKud3v;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=SSVKud3v;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w1D1fp7M003999
X-Nifty-SrcIP: [209.85.217.171]
MIME-Version: 1.0
In-Reply-To: <49c196ec-891d-2030-bd6c-7222feb22059@infradead.org>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
 <CAGXu5j+7kv=jrg2u7jaxFEXwHoyzDXP_jyKHYA682_BrYuHwQQ@mail.gmail.com> <49c196ec-891d-2030-bd6c-7222feb22059@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Feb 2018 10:41:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREEJ_k9x2QXaT73nBg934pb9YvO9DfzhhU7+_fpDdH8g@mail.gmail.com>
Message-ID: <CAK7LNAREEJ_k9x2QXaT73nBg934pb9YvO9DfzhhU7+_fpDdH8g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592248115283050630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-13 8:48 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 02/12/2018 07:24 AM, Kees Cook wrote:
>> On Mon, Feb 12, 2018 at 6:39 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>
>>>> (And in thinking about this, does Kconfig know the true $CC in use?
>>>> i.e. the configured cross compiler, etc?)
>>>
>>> I was thinking of removing CONFIG_CROSS_COMPILE.
>>>
>>> A user can dynamically change CROSS_COMPILE from
>>> "make menuconfig".
>>
>> Most builds I've seen implement cross compilers as an environment
>> variable during all "make" invocations.
>
> I agree. I think you would break a bunch of build bots if you remove that.


For clarification, I suggested to remove CONFIG_CROSS_COMPILE.

The following code:
https://github.com/torvalds/linux/blob/v4.16-rc1/Makefile#L315
https://github.com/torvalds/linux/blob/v4.16-rc1/init/Kconfig#L58

I hope build bots are not using this.


Passing CROSS_COMPILE via the command line, environment
is still supported.



-- 
Best Regards
Masahiro Yamada
