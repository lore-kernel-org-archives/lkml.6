Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518449739; cv=none;
        d=google.com; s=arc-20160816;
        b=W/IocgIBSafXQQtxLnP3puAj0f27awPGY7RmBvU9a0MP4Kll3UDmu2XTp9Ffmou/k7
         E+EBi7XlwysVNzpkzVqYeW+VSiofhFDyvDK+mma12Me6Ipm29g+UiScvVzOtH6krN6DC
         pM2Qg27CKfBDR3sr0SFKidXZyBxI6VfXJ2pysXaJGIEDjk6qQDuztZi29+47ob6k6Y7e
         bw13vyqs2SujqEwTJEGPm+Cks8WXoZeidBb1S7CUmW7j9fjYvpGmlXlh2bTyPNjOITkX
         sBSBl4qnU5NmXL8Snr7JUm1iPnSceSd40PMg6Fb7RmxIh7ySnMX1hT25DS/C11hHWOyz
         xhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=jTH67EZkP1wcoH4mksN7Yn0KPxga7ylKMgVLvvKo4Rk=;
        b=fYQ+LdhCIfm2tK7v+IOr9e3S2bU0YtdZnNF4e4UlQwDeosmwrr7thbBbDrExr/LFnz
         EB8YCOTRY8IS/MqEy7umCYvR3X3Xa8D2wCDJHMCIkViCpK/iuzh7KtODT4HR3h2gaLhC
         Zn3mejXTkLqcPbHV4Jh1ePU138ju0JNDyTXP9OiiD3qmD/o+5YJV1EeZjZpvs6aRGY0X
         Azy+FBSrICYGLe19NsyF80/pS9gIGU5BrnfdJDJrLvv75drVlSrzHGBc6fS/43VfqgNC
         0P1GTM8El7RSWxpzfsAhRbOjJJnZqmZXFZaR8d1Ade9Gw/ERZCjE7mSWhjZZnDoBrflp
         0qMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zz36otNn;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zz36otNn;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227Ypgn/FeRnahfsikoGQWWB0z4KL/M1QGivplmdL9H/Qmr8f1FNk2SY0zpNP5JHE4WRtHEd/56HwAyzMq+weA8=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ8twMnB9wEb+2gjzW2oDGPJf+p7qW=wja7SPGj9Nixyw@mail.gmail.com>
References: <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAFkk2KSk_OpwagN_Ru0fHPyALK5HwtxHOcMhT8OHqeOH3hOP+w@mail.gmail.com>
 <CAFkk2KRm+_NQ2QLUta7fbezngLpD3eZ5NEp57SymBRMUZQZ4wQ@mail.gmail.com>
 <20180212125458.vb4ve3ieejvuvo65@huvuddator> <CAK7LNAQPGht_wBPr_66shL-59mvaXRzDeuSNKicf+zu5Y1CmCA@mail.gmail.com>
 <CAFkk2KTdXNWNGgGw32NXOG6+10mUDDJ9ngXkcOAQ7QnYtd2TYw@mail.gmail.com> <CAK7LNAQ8twMnB9wEb+2gjzW2oDGPJf+p7qW=wja7SPGj9Nixyw@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 12 Feb 2018 16:35:38 +0100
Message-ID: <CAFkk2KQHxxLSVuXtv+U=C1OEhi2f2SMe8fk3x3B49qgXWXfV1w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592209953974597812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 4:22 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-12 23:53 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>> On Mon, Feb 12, 2018 at 3:21 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 'syncconfig' in a more proper name
>>
>> Wonder if --update-config-files-for-build or something would be an
>> even better name.
>
> I want to use a name that ends with 'config' like any other config targets
> because:
>
> - I want use the same name for scripts/kconfig/conf option
>   and Makefile target to take advantage of 'simple-targets'  [1]
>
> - I want to use pattern rule to descend into scripts/kconfig/  [2]
>
>
> [1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/Makefile#L84
> [2] https://github.com/torvalds/linux/blob/v4.16-rc1/Makefile#L506
>
>
>
> It would be possible to directly descend into scripts/kconfig/ like follows,
> but I do not have a good reason to break the convention.
>
> include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
>        $(Q)$(MAKE) $(build)=scripts/kconfig  update-config-files-for-build
>

Ah, right, didn't think of that. Thought it might be nice to hint that
it's related to the build phase somehow at least.

Not that important I guess. --syncconfig is a big improvement already.

Cheers,
Ulf
