Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225H4K9///+oo8m6ehD+KfwV9BoY69r0GHZHnhQ3QJK8AG7bBEPpJrCGyuC88rpnmRWLv91e
ARC-Seal: i=1; a=rsa-sha256; t=1518449015; cv=none;
        d=google.com; s=arc-20160816;
        b=UQrO0ZVzmN/K+zLh9OA2uAmWyPEgjcktbiFiiE3ABy5u1TvRqJLxVa1XLZ5r6/WDyU
         2Gd2m9jMhUtNIrY7t2h7gSuZUani0JsrC4j3edEqdq2fTcujnUUVcsi8zhXKgdWOaZDq
         D7SD+P/1NfK7d8imBn0fNH3IKxu2E7ZjKjaStfXWLQW3MmEVy7udkTkFKhi4LT2WCROF
         WiBwaQ8PGXjImlGBJ76jKFbeW7ipVWNRDAXCrH9gQiMG14i28HzjKFPacKZJlG0NaYbG
         2/V04gKCQxhHKbnRElEIglmpdLTXpqIWfL0vhEXH1/5MbyKV4O07MBC09V3V4GQRakQ9
         pOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=5PonHrL+WGPaGecsQWWUmMN5nIM70rRNdPhxCdE51Ws=;
        b=OdigMr1kq7xa4TXyGFngXj4onxLi0duZbNucp0SmVoVjm7vBZ6U/++dRFFEp6oHxGD
         BIeFWaJ+CInNFCQbqG7qwL61KMtQ9x9UjSUUgDfX8mWE8Hfz2wV/6EhN2v6ICh+o00Mo
         IwBEAv1DH/JInPsQNt94RT3i6c/XkygnXz5d1j4DzVV9bYzUYjQ5qb3/OYJUTl6uIHon
         16oJyha1VxaEnl+LG8qZ3e5kL7P5xF+b5jOeVz730izKaWiZghPTUZxL76iEyF3LlplR
         Jq6rx+yxujn7/PcHANAgaI3wT4h9KJSAZrpTZBTKbszvAe5EMW2qkk4Ss87gecfP8bKG
         PPSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=I2SDl96m;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=I2SDl96m;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1CFNI4M010388
X-Nifty-SrcIP: [209.85.213.44]
MIME-Version: 1.0
In-Reply-To: <CAFkk2KTdXNWNGgGw32NXOG6+10mUDDJ9ngXkcOAQ7QnYtd2TYw@mail.gmail.com>
References: <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAFkk2KSk_OpwagN_Ru0fHPyALK5HwtxHOcMhT8OHqeOH3hOP+w@mail.gmail.com>
 <CAFkk2KRm+_NQ2QLUta7fbezngLpD3eZ5NEp57SymBRMUZQZ4wQ@mail.gmail.com>
 <20180212125458.vb4ve3ieejvuvo65@huvuddator> <CAK7LNAQPGht_wBPr_66shL-59mvaXRzDeuSNKicf+zu5Y1CmCA@mail.gmail.com>
 <CAFkk2KTdXNWNGgGw32NXOG6+10mUDDJ9ngXkcOAQ7QnYtd2TYw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Feb 2018 00:22:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8twMnB9wEb+2gjzW2oDGPJf+p7qW=wja7SPGj9Nixyw@mail.gmail.com>
Message-ID: <CAK7LNAQ8twMnB9wEb+2gjzW2oDGPJf+p7qW=wja7SPGj9Nixyw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1592209194739616975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-12 23:53 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Mon, Feb 12, 2018 at 3:21 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 'syncconfig' in a more proper name
>
> Wonder if --update-config-files-for-build or something would be an
> even better name.

I want to use a name that ends with 'config' like any other config targets
because:

- I want use the same name for scripts/kconfig/conf option
  and Makefile target to take advantage of 'simple-targets'  [1]

- I want to use pattern rule to descend into scripts/kconfig/  [2]


[1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/Makefile#L84
[2] https://github.com/torvalds/linux/blob/v4.16-rc1/Makefile#L506



It would be possible to directly descend into scripts/kconfig/ like follows,
but I do not have a good reason to break the convention.

include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
       $(Q)$(MAKE) $(build)=scripts/kconfig  update-config-files-for-build



>
> Kinda tough to compress it into something that adheres to *nix
> terseness while making it somewhat clear what kind of stuff it deals
> with. :P
>








> Cheers,
> Ulf
>
> On Mon, Feb 12, 2018 at 3:21 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-12 21:54 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>> On Sun, Feb 11, 2018 at 09:42:09PM +0100, Ulf Magnusson wrote:
>>>> On Sun, Feb 11, 2018 at 9:29 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>>> > On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> >> Another case I mentioned before that I just want to make sure we don't
>>>> >> reintroduce the problem of getting "stuck" with a bad .config file.
>>>> >> While adding _STRONG support, I discovered the two-phase Kconfig
>>>> >> resolution that happens during the build. If you selected _STRONG with
>>>> >> a strong-capable compiler, everything was fine. If you then tried to
>>>> >> build with an older compiler, you'd get stuck since _STRONG wasn't
>>>> >> support (as detected during the first Kconfig phase) so the
>>>> >> generated/autoconf.h would never get updated with the newly selected
>>>> >> _REGULAR). I moved the Makefile analysis of available stack-protector
>>>> >> options into the second phase (i.e. after all the Kconfig runs), and
>>>> >> that worked to both unstick such configs and provide a clear message
>>>> >> early in the build about what wasn't available.
>>>> >>
>>>> >> If all this detection is getting moved up into Kconfig, I'm worried
>>>> >> we'll end up in this state again. If the answer is "you have to delete
>>>> >> autoconf.h if you change compilers", then that's fine, but it sure
>>>> >> seems unfriendly. :)
>>>> >
>>>> > Did you mean include/config/auto.conf? That's the one that gets
>>>> > included by the Makefiles.
>>>> >
>>>> > If the feature detection is moved into Kconfig, you should only need
>>>> > to rerun the configuration (make menuconfig/oldconfig/olddefconfig) if
>>>> > you change the compiler. That will update .config while taking the new
>>>> > features into account, and then the second phase during 'make' will
>>>> > update include/config/auto.conf from .config.
>>>> >
>>>> > That second Kconfig phase generates include/generated/autoconf.h and
>>>> > include/config/. The include/config/ directory implements dependencies
>>>> > between source files and Kconfig symbols by turning the symbols into
>>>> > (empty) files. When building (during the "second phase"), Kconfig
>>>> > compares .config with include/config/auto.conf to see what changed,
>>>> > and signals the changes to 'make' by touch'ing the files corresponding
>>>> > to the changed symbols. The idea is to avoid having to do a full
>>>> > rebuild whenever the configuration is changed.
>>>> >
>>>> > Check out scripts/basic/fixdep.c as well if you want to understand how it works.
>>>> >
>>>> > Cheers,
>>>> > Ulf
>>>>
>>>> By the way:
>>>>
>>>> That second phase is also a "normal" Kconfig run in the sense that it
>>>> does all the usual dependency checking stuff. Even if .config doesn't
>>>> respect dependencies, include/config/auto.conf will. So I think you
>>>> might not even need to rerun the configuration (though .config will be
>>>> out-of-date until you do).
>>>>
>>>> Cheers,
>>>> Ulf
>>>
>>> Seems you'd have to rerun the configuration, because
>>> include/config/auto.conf is only regenerated if it's older than .config.
>>>
>>> Here's the bit in the root Makefile that does it (KCONFIG_CONFIG is
>>> .config).
>>>
>>>         # If .config is newer than include/config/auto.conf, someone tinkered
>>>         # with it and forgot to run make oldconfig.
>>>         # if auto.conf.cmd is missing then we are probably in a cleaned tree so
>>>         # we execute the config step to be sure to catch updated Kconfig files
>>>         include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
>>>                 $(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
>>>
>>> silentoldconfig is a terrible name. What it actually does is run that
>>> "second phase" stuff.
>>
>> Right.  This is a historical misnomer.
>>
>> My plan is, as already posted below, to rename 'silentoldconfig' to 'synconfig'
>> https://lkml.org/lkml/2018/1/17/1359
>>
>>
>>
>>> Pretty sure that comment lies by the way. 'make oldconfig' doesn't
>>> update include/config/auto.conf. It's probably outdated.
>>
>> Good catch.
>>
>>
>>>
>>> I wonder if it would be simpler to just always run silentoldconfig when
>>> building. It's not that slow on my system:
>>>
>>>         $ export ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion`
>>>         $ time scripts/kconfig/conf --silentoldconfig Kconfig
>>>
>>>         real    0m0.167s
>>>         user    0m0.162s
>>>         sys     0m0.004s
>>>
>>> That'd both simplify the Makefiles, and make sure that the latest
>>> features are always used if you do feature testing in Kconfig.
>>>
>>> I don't know how strongly people feel about a few tenths of a second
>>> though.
>>
>>
>> No.  NACK.
>>
>> silentoldconfig touches include/generated/autoconf.h
>> so, files that depend on it will be re-compiled, unnecessarily.
>>
>>
>> silentoldconfig ( 'syncconfig' in a more proper name)
>> should be run only when necessary.
>>
>>
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
