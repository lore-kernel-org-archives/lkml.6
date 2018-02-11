Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518383996; cv=none;
        d=google.com; s=arc-20160816;
        b=wMySduu0EDM17d655K/ir3CJ1pKamuvMvtYGQyrjGvmnHEYy9mUFlvmA59lRlm9xHg
         Md5LIgmfbBzheE9HaXp1qPeqOKsQprUvHq6LDUuyWtsi7WkTAExmQewd945Ly97pgzFy
         /KY/S04A2qDsKGP/thUlnt2toWYTKHv70zd5fNeu9f5AalsSwFzY3KdCQFs8Fz4WHwcx
         zcsCpwI5jWHsGxhVX8/axg/t/iNuCg8uApwZkbzYZiI2ElWvrO4oZnkp7I/S01AWpax1
         WWlRoK2Y1hzVDQ764N4YTvpcKtG2ED/CP76sAylzapa9lnxF+yrgTqFQMWuWHe/Eiuiy
         IrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=E4upVd9LOZb4cnqKo7RdEVCrn20gYwmowIX6bhjZVm0=;
        b=v9kGLaU+D2IfQ82FzeryuBlFQP5kqkBPmHldfS4FLsEQHJ3XaguYXCYtD3HbAuO42E
         vByhP7pnGHmK84Uz9u8LeqxueeT5qQA8KmJ+UtO6mDlB2aO9MCNOZCT1Ggv7Co41T/ld
         AKy/U/bmBOGm1StJ8Sdc3t+atcOqwCVPjOMVd5A6ObzzV+Ru6SnwV0CtUzgFD9E2IN2j
         getUDIi3xAF8tG8YtAj+Str3yqzGaxJk8lwv68WKxpKsXJGTXC3iZoVp6otqFndfVMan
         Z5tpUb/V9pg5H6dZHhYJkkNP3lc17YcdrKi3j7XEnOkt+i85/NYqRLn4leZqOSrdWeld
         w9ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=pxKxL7yM;
       dkim=pass header.i=@chromium.org header.s=google header.b=WNHICy79;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=pxKxL7yM;
       dkim=pass header.i=@chromium.org header.s=google header.b=WNHICy79;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x2262oaLb7zT/BTqmG+FX/FDfWTPqkKuRcrTfHpUaIaCoeE7o7r+LYyugh1HG5G3XmnOI4WDxhLJv2c4Fe5THuI0=
MIME-Version: 1.0
Sender: keescook@google.com
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
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Feb 2018 13:19:54 -0800
X-Google-Sender-Auth: -s67sCmW7Lbvwwe0SMG07mVIKLA
Message-ID: <CAGXu5jLjGxbPQ_mNjV06f66a2xevmGp5w3f7X+nhYO4GYHa_zw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ulf Magnusson <ulfalizer@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592141017433490725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 1:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
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
>
> gcc-4.3 in turn is used by default on SLES11, which is still in support,
> and I've even worked with someone who used that compiler to build
> new kernels, since that was what happened to be installed on his
> shared build server. In this case, having gcc-4.3 actively refused to
> force him to use a new compiler would have saved us some
> debugging trouble.
>
> In my tests last year, I identified gcc-4.6 as a nice minimum level, IIRC
> gcc-4.5 was unable to build some of the newer ARM targets.

For reference, the original discussion started here:
https://lkml.org/lkml/2016/12/16/174

I thread-necromancied it here:
https://lkml.org/lkml/2017/4/16/276

Modern analysis of compilers vs versions here:
https://lkml.org/lkml/2017/4/24/481

and seeming conclusion was here:
https://lkml.org/lkml/2017/4/25/66

Quoted:
>> - To keep it simple, we update the README.rst to say that a minimum
>>   gcc-4.3 is required, while recommending gcc-4.9 for all architectures
>> - Support for gcc-4.0 and earlier gets removed from linux/compiler.h,
>>   and instead we add a summary of what I found, explaining that
>>   gcc-4.1 has active users on a few architectures.
>> - We make the Makefile show a warning once during compilation for
>>   gcc earlier than 4.3.

But yes, if Linus wants 4.5 over 4.3, I would agree with Arnd: let's
take it to 4.6 instead.

-Kees

-- 
Kees Cook
Pixel Security
