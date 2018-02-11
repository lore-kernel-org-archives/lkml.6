Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518385804; cv=none;
        d=google.com; s=arc-20160816;
        b=geGUhITfsq9GYSKepLRVQ3md2bNdzD7FbCjtYnoHUCrBGSo5qSAG89FNNwz3DJ+5XE
         Ez96NtudB67rELcFgtjEh1iRb0P0dw1iWg8WVxVpBeiRmePiN+anm+W1pUB6VsE0t3SE
         az1aF10i1JSnNHJ4xGrs+E9o1bSIStbPIPf64jeWPHiPK7hqa0w7JV58T6+j3zxy3SYQ
         3yV8YTVSpn4XguVYkxAXipkdLZUtibuDxfr2zq8YVic07yLg6//8Eyfv6Nm9WHAzEu/x
         8eoqDKvvXkm+qtittTKnAhqJ/TKx3M+9/evKnY0RoLJhnPrKS5Ubj5Y+dHsfHUjbaMbh
         kmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zGHscw8jGZXlo3uLjdWyjODH26i7rwQF5E4muJS7OLM=;
        b=xu7TtiI6FnyBKYNQx92XFxNH3mwFdZ3Q8VH/a6+14EPLhd8bWVPSBUruYxePmVhW/C
         +jhzO9ss8cvs75e/Nmrywr1gobh2ZS2xFr4zlhqRILEvZb21xHAl5EQ/gNRXR7WibMwr
         s6aMaHuIPdUf838nIYTGekvm8LIO5Sy2vmJstAGMnVkgodVSqZMNoqTODlVhSD/hJzZ9
         VHgWVy8QSsONWu51yYZDrhFA5ZgnplagWy/ZAgDPpPX04tkf3C5V/snxkgkDKsJ7NR+5
         qC2Wea/Uamx8IxIR/ojfN6F+EzQTlKwoAdwsg83LAXEa0+e+/7d1S6PSUaEA/P1Uh5Cq
         5x1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XC4YOpNR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XC4YOpNR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227vbJTKdKCKlTyxEGNe63Y26UCT4ZWG7I6+BwM689/5lYW9Up6VDSlEL6AWjHKjBoCGJC50YlZg/BGoPCiHoXs=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLjGxbPQ_mNjV06f66a2xevmGp5w3f7X+nhYO4GYHa_zw@mail.gmail.com>
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
 <CAK8P3a3DHkpbRxUTP77OoeAqRHDz-tL-qYxLfq61Wv8NUPmyjA@mail.gmail.com> <CAGXu5jLjGxbPQ_mNjV06f66a2xevmGp5w3f7X+nhYO4GYHa_zw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 13:50:02 -0800
X-Google-Sender-Auth: 0bAWNSeUhfJInfOSeA7oqJXu4P4
Message-ID: <CA+55aFznXZ+DXYDVcgUV+yAZPnWagVODhM_-xW=FPhTvZ8G61w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1592142913251369355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 1:19 PM, Kees Cook <keescook@chromium.org> wrote:
> On Sun, Feb 11, 2018 at 1:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> In my tests last year, I identified gcc-4.6 as a nice minimum level, IIRC
>> gcc-4.5 was unable to build some of the newer ARM targets.
>
> But yes, if Linus wants 4.5 over 4.3, I would agree with Arnd: let's
> take it to 4.6 instead.

So it sounds like Arnd knows what the distros have.

Because I think that would actually be the best way to try to
determine where we want to go, because it's what is going to determine
what is most problematic for _users_.

If no distro is on 4.5, then there's no reason to pick that. The
reason I mentioned 4.5 is because that's the "asm goto" point, afaik,
and that is likely to be a requirement in the near future.

If SLES11 is 4.3, that's obviously a concern. Although Arnd seemed to
imply that that had already caused problems, so...

            Linus
