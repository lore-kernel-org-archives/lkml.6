Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226g79r3QOU2qIg/ayH9sotfWJtpBDpQV29hxoRADtBYfZxugnOc83Hv+6/Ww3If/jA1rlx2
ARC-Seal: i=1; a=rsa-sha256; t=1518512443; cv=none;
        d=google.com; s=arc-20160816;
        b=s7kvS9K3F3WDvVDdKwH1P0oqd5B+diIAX4CfXy6Km2WE9vhHrWWa1W1vNY53fqR2aC
         WUI3oN9illSkeJ/N9UCcFeYl/FuqnQI7PCUTsr1AdRHT9uKFFAPgvyehQdjgp4cOncvS
         gasj6bxUm9v651/gzOOAHKAQbhiz+2OPXHAUjCrHsYPDlWVDIszbrXuGVwiQAXS914oS
         gZa2yC89NXTXYLVHFgfm+fZphJlFTu5hj4duwBTq5HzpR66FtN3xOjIa8kkEsrDMLchS
         sXbtRF8w423acxX/HrYDpqjf3OZVSvb7RHIv4axYzfsrYqiDUTfRc8eWZOgGOMwb9GtR
         llYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=OoHN3L+EgMi3QdRVCikhsLANjFHuDxATT8s2PGOuNn0=;
        b=cWfMl6PC6B8hnIQ1a5MerUGiNDNZHlUUHI6+K84Ji/6NRK15IuCIrPOu55C2g+1ffr
         Ef7fquaLK6l5qmxlpBAdYLvoFBZzk+HEjH3XgPGzpQD14zMDDiLIz7yAEPbJg4NOjGJn
         y9fnIXEWD+nVEcEbuT2s5fXzwbDhJensEeyhDO01tSP5twSWlWa1BMUEwYxxcGBR1WmP
         0IWe0jKYtkOQKbY/KEiJjy59Nf356Ty1i8JlCRrMpgZqDJNxsKYmc6fu+gjGf7Uy6F5q
         idA7pHHI+KVdwVqazYxAP9ikeAZ+2p3gQoAL5LI3XYOz99U8nTx6udmS+fHfncJIS2B6
         tWBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QH7LZWwI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QH7LZWwI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w1D906tR012229
X-Nifty-SrcIP: [209.85.213.51]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1SiejhK+eSx_mYqJratytU+_6FSjjatZE9n171GiA0mg@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
 <CAGXu5j+7kv=jrg2u7jaxFEXwHoyzDXP_jyKHYA682_BrYuHwQQ@mail.gmail.com>
 <49c196ec-891d-2030-bd6c-7222feb22059@infradead.org> <CAK7LNAREEJ_k9x2QXaT73nBg934pb9YvO9DfzhhU7+_fpDdH8g@mail.gmail.com>
 <b17cc8ff-1bf1-1026-d028-f9552701403d@infradead.org> <CAK8P3a1SiejhK+eSx_mYqJratytU+_6FSjjatZE9n171GiA0mg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Feb 2018 17:59:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNARXz-SYZrnyWedh6nxLYS-T18RdEPFsmBxHUW_4jQERPA@mail.gmail.com>
Message-ID: <CAK7LNARXz-SYZrnyWedh6nxLYS-T18RdEPFsmBxHUW_4jQERPA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Arnd Bergmann <arnd@arndb.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, Kees Cook <keescook@chromium.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
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
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592275703402855740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-13 17:35 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 13, 2018 at 2:53 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 02/12/2018 05:41 PM, Masahiro Yamada wrote:
>>> 2018-02-13 8:48 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>>>> On 02/12/2018 07:24 AM, Kees Cook wrote:
>>>>> On Mon, Feb 12, 2018 at 6:39 AM, Masahiro Yamada
>>>>> <yamada.masahiro@socionext.com> wrote:
>>>>
>>>>>>> (And in thinking about this, does Kconfig know the true $CC in use?
>>>>>>> i.e. the configured cross compiler, etc?)
>>>>>>
>>>>>> I was thinking of removing CONFIG_CROSS_COMPILE.
>>>>>>
>>>>>> A user can dynamically change CROSS_COMPILE from
>>>>>> "make menuconfig".
>>>>>
>>>>> Most builds I've seen implement cross compilers as an environment
>>>>> variable during all "make" invocations.
>>>>
>>>> I agree. I think you would break a bunch of build bots if you remove that.
>>>
>>>
>>> For clarification, I suggested to remove CONFIG_CROSS_COMPILE.
>>>
>>> The following code:
>>> https://github.com/torvalds/linux/blob/v4.16-rc1/Makefile#L315
>>> https://github.com/torvalds/linux/blob/v4.16-rc1/init/Kconfig#L58
>>>
>>> I hope build bots are not using this.
>>>
>>>
>>> Passing CROSS_COMPILE via the command line, environment
>>> is still supported.
>>
>> OK, I misunderstood.  That one can go away IMO.
>
> Removing it will break the workflow for some people in a minor way
> though. Could we have the top-level Makefile try to detect the
> CROSS_COMPILE? Instead of just using CC=gcc as the default,
> we could check for ${ARCH}!=`uname -m` and then see if $PATH
> contains a ${ARCH}-linux-gcc, ${ARCH}-elf-gcc or ${ARCH}-gcc.
>
> it will need slightly more complexity to deal with architectures
> that have different identifiers in linux and gcc, but I think it would
> be a nice feature anyway.
>
>      Arnd

Some architectures such as m68k, mips, etc.
do this in their arch/*/Makefile
by using $(call cc-cross-prefix, ...)

But, currently we do not do this globally.

It would be possible to do it, but it does not mean
backward-compatible with CONFIG_CROSS_COMPILE.


-- 
Best Regards
Masahiro Yamada
