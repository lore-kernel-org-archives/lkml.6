Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518432268; cv=none;
        d=google.com; s=arc-20160816;
        b=VPAZIi3MGVr1EFhCX+KsB33kClo6G2mRjclUgjZrbpPMLlE1MJA2IsiKItc+oZaZ7k
         1ffW+rRCKxwQyAzPdpEb3u2UbQNpMpUhYDTERoXLtPz6ZOoeM3LNMVUYHDxKywnjlhr7
         ebUx2A1sl03ywVu5+2oIrlUmHXekKtm92Ji4cyMD2tT6E+zpPBdrLGdDDNNKFYZv5eGO
         NrUFUkeg21fd+kjezUbPB0OiRjPQHSl/p/RYDNCQRUt9SaQzLeO4gVULpwUcDgdpteAy
         ZsYzm+5pMc91LRww5amXWnlZpoCseDN6jCuTO4WybE+sTBJuXAeUycFGyeA10pX8lNGx
         EEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=RkTEunNFoBtHc3BXy1WEzoWTrtv16ZsntJ+KtZ/gPNc=;
        b=ebNUhHh7hCS2A4qIUumCmKZ7fGXlegOuumerHL6uJTMEzuFEQ3Bby+XiNRRI6b9xPc
         Bh4fpYNjWYCfLDittyoAmbUo92jP/Awqel9XrCoNcDd7bmT0Hgl/5lGJ3BWrtyVrhmlj
         JB5Ca3FLZs/SUZ6qXlnPWSBXBagyb9lWfwURSrlXZgHy5Veu4VQZjiXTH4LOhQTMjnYB
         MberkC2wHAFa13ksi7q3mJyJ6sBflGnICNYqY5qCs+yCNn09Z0CCWCalxvw+fRI6VRYI
         yXmbebMx1jPaRoD+Qi31aeTcG6P0NH8gPXl9IjP0q15CVB65vx95zN4d77HbFbiRZuyN
         c58w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rJw2Hv/W;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rJw2Hv/W;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x225Yltn0Yo3aT9qQOrXgn3OznHzTeMzjwYZ4FVvzD2/ZURHefVyn2QNvj3Fs/MqKc6wBcoEozR+HltOrFspqrd4=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CA+55aFznXZ+DXYDVcgUV+yAZPnWagVODhM_-xW=FPhTvZ8G61w@mail.gmail.com>
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
 <CA+55aFy4WNC=pmga19CHhrX9QwOJsu1bUvGL0oNxq5EeMW94eg@mail.gmail.com>
 <CAK8P3a3DHkpbRxUTP77OoeAqRHDz-tL-qYxLfq61Wv8NUPmyjA@mail.gmail.com>
 <CAGXu5jLjGxbPQ_mNjV06f66a2xevmGp5w3f7X+nhYO4GYHa_zw@mail.gmail.com> <CA+55aFznXZ+DXYDVcgUV+yAZPnWagVODhM_-xW=FPhTvZ8G61w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Feb 2018 11:44:26 +0100
X-Google-Sender-Auth: ENepQ3LwGLqIbJnY3Fv0iROVwkc
Message-ID: <CAK8P3a3-63He=LPtqyskQn_J-8VKUTpoFXLPjUU7Vjoj1MYfLA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1592191633651721943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:50 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Feb 11, 2018 at 1:19 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Sun, Feb 11, 2018 at 1:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> In my tests last year, I identified gcc-4.6 as a nice minimum level, IIRC
>>> gcc-4.5 was unable to build some of the newer ARM targets.
>>
>> But yes, if Linus wants 4.5 over 4.3, I would agree with Arnd: let's
>> take it to 4.6 instead.
>
> So it sounds like Arnd knows what the distros have.
...
> If no distro is on 4.5, then there's no reason to pick that. The
> reason I mentioned 4.5 is because that's the "asm goto" point, afaik,
> and that is likely to be a requirement in the near future.

Looking at old distros with long support cycles:

Red Hat have either gcc-4.1 (EL5, extended support ends 2020) or
gcc-4.4 (EL6, regular support ends 2020, extended support ends 2024):
https://access.redhat.com/solutions/19458
EL7 uses gcc-4.8 and will be supported until 2024 (no extended support
planned)

SUSE have gcc-4.3 (SLES11, extended support ends 2022) or gcc-4.8
(SLES12, support ends 2024, extended support ends 2027):
https://www.suse.com/lifecycle/

Debian Jessie (oldstable) comes with gcc-4.8 and is supported until June 2018,
extended support until 2020
Debian  Wheezy (oldoldstable) uses gcc-4.6 or 4.7 depending on the
architecture, extended support ends May 2018.

Ubuntu 14.04 is supported until 2019 and uses gcc-4.8

The latest Android SDK provides (known broken) versions of gcc-4.8 and
gcc-4.9 as well as clang.

OpenWRT 14.07 Barrier Breaker uses gcc-4.8, 12.07 Attitude
Adjustment 12.09 used gcc-4.6, but it's very unlikely that anyone
cares about building new kernels with either.

Most embedded distros just build everything from source and are
used to adapting to new requirements.

>From that list above, it sounds like going all the way to gcc-4.8 would
be a better candidate than 4.5 or 4.6, if we decide that 4.3 and 4.4 are
both no longer desirable to support.

> If SLES11 is 4.3, that's obviously a concern. Although Arnd seemed to
> imply that that had already caused problems, so...

The problems are mainly an excessive amount of false-positive
warnings, which makes it tricky to new warnings when you make
a mistake.

          Arnd
