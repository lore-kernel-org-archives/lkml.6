Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518110849; cv=none;
        d=google.com; s=arc-20160816;
        b=fBb2xasmCHytezwrvCkhl9NWgte9ua+5/NjaIE2y6ESjyrO+3rnobyr7wP8V5Eysjk
         k9lhRfXHOfYAcAIc6NYwmOi02FU5Fr7ISmBSu8+Rg3d7FocJtsKXBjMsitqJuPPOtyKN
         MEluapvpEMGImj3kRMlI1Ioe0M3LSxmayScskvgVhPAr4Da2pMX94xVYXKfn6gd3WsBo
         Qa2u8iiD5tUkw10zfMBkMG2c7Eha72wp3iHxKTtOgY6YLwj65oO4QvGi7MjKGISuCh3k
         QWU6NAFm5kDv3F3wnbyqJP70tLt0x/dWLcLXNBEufaIqrTAxpXmBb0uvfqGF28895VjS
         aCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7qLhHLq7GgsQneXki9z7kk9Fc8dBcC0O7aN4Mba34Qc=;
        b=j4hlZY3KlD41zTM3tTjI+pYDF0cmoXD3NJroeIWuaORUaUhi7sRyv/KZ+mUJHF2Bgl
         IE3FmW0Yz6qvW2xCAzLx7Pxe9iclG6ey2+z6gJGWynrqorZBZ9q/yiurkDCbsGWAXEow
         PkddgdA/fPaX77KF42qTy7Ngon+VZpVXEMXsT5oTZgpxx94Ca6KJe45t9WpjlwFnSJYz
         7qsTjUHQqD6Ziqi46qfvwTePmfY6Z4OAOiJ3AybEY+2vBQMrTYFyFKJYChf2d5NqSFJy
         fhlpDlDrWYyqpmnSHIyZX8exFEqLnQ8BKJbVTDJseukfcfstcRHfVY7aRm7LCAiDJ1TM
         dAAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sSYC56jh;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sSYC56jh;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227YtGyvSfG/SPLU/Y5SoBw3eB34UXcQ5/zUcWqlFHes4kt8Hm352e/Xogkt/iRER1CGvL+t1YFSi4i+sD5Ar3Y=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517950494.3677.30.camel@infradead.org> <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
 <201802070918.18978.linux@rainbow-software.org> <20180208134908.4b516794@alans-desktop>
 <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com> <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
From: tedheadster <tedheadster@gmail.com>
Date: Thu, 8 Feb 2018 12:27:08 -0500
Message-ID: <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Ondrej Zary <linux@rainbow-software.org>, David Woodhouse <dwmw2@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugh Dickins <hughd@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
	Jamie Iles <jamie@jamieiles.com>, Eduardo Valentin <eduval@amazon.com>,
	Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591854602097528341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 12:02 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Bergmann
>> Sent: 08 February 2018 15:23
> ...
>> The Winchip is what eventually turned into the VIA Nano, which does
>> have speculative execution, but I don't think the earlier C3 and C7 did,
>> they are much closer to the original Winchip design.
>
> We had terrible trouble getting (IIRC) the C7 to execute functions
> that were called in 16bit mode and returned in 32bit mode and v.v.
> (for boot code bios calls).
> The problems seemed to imply that it was caching return addresses
> and the translation (to uops) of the instructions that followed.
> So it would effectively decode the first few bytes in the wrong mode.
> So there might be scope for one of these attacks.
>
> OTOH these devices were so slow that I doubt any are used for anything
> serious - and certainly won't get a kernel update even if they are.
>
> Also worth nothing that the difference between the cpu and memory
> speeds is much lower - so far fewer instructions could be speculatively
> executed while waiting a cache miss.
>
> Tempting to disable everything.
>
>         David

You might think this absolutely crazy, but I would be willing to test
such systems if I can get my hands on the needed hardware that I lack.
I am already doing sanity testing on Intel
i486/i586/i586-MMX/i686-PentiumPro systems, I just don't have the
clone cpus (Cyrix, etc).

While few people are using the 32bit kernel, I don't think we want to
kill it completely just yet.

- Matthew
