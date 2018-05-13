Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526219615; cv=none;
        d=google.com; s=arc-20160816;
        b=viiIaMw8Ej6C2tXugswTUAL1wWx8z522n8KQmFvgwCwMx2OfB2b+4dIkHi1D5IgZYt
         ZvZDk+8FKVBeUrA7GLNJdZVo0BnYbENR2pBmWFxCT4GS7Ws0c5v12R7oqYQcG1rrDDV/
         BlHFhweNChdoFPd/ru4ce3XwGLCdf0VD0SbVvtK/tnAYtkWVQxEXMzguhMOqS/Q4WlU/
         2uXekfqvWHBZrqk9x83Nf/nI7wfo5r9kYdbAY7WtNbi3z3Y8DbuvY1v/C3O+3Z82MmFg
         PsrbfZ3LrWCmdBMMvjDHotG7scod+CZdfeEZjCkDfpQD/hS8P1uvM0S4hNkJ7Xa+6Yef
         M1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=JkgnrlJwLecWa+Yo02LWnNFI5Ea/GhhgVuctBjruKkk=;
        b=W0oOWhufZztrG52y07dB6J0015UXJPtfyTmrM/vNHBh0LYYXHvpqpt/21yP9ljnHaQ
         uCJKjAV2pB2BdExoTIiiDRRuu9INX8EqxNtWVZi2IgyF48aJ5Vlq5vKMyv5DRsRpRtF0
         uLDUrnWS7yyDsGvXNglOgn+Z0j4S4+v6/EqxjxDgMSmV3SRaeMdLA8FzWkxu1aL7qWOK
         5LAVBdPg/y7jKwfvYpbJvYDFuzM307K3akS5d99nW6opvFAiBM4iC+LDbcUHfAZt4gVu
         HTWrILo45k7s/iUIwm+cydGK95thKmRN0uJB4RNWMYm2BqQKIknKXP+22GXRqMye8CVc
         RBVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g1iwPmNg;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g1iwPmNg;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpxGgiy5UVaJ6FEq+7kDNefARcF+5cV+T1mEDAYyv9UjQA7N+hQDpK50oBk3I5f15+aRrAeW8qkt57Q/DQyMac=
MIME-Version: 1.0
In-Reply-To: <20180512143809.7c6a06ab@canb.auug.org.au>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org> <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk> <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk> <20180509204727.7ff38021@canb.auug.org.au>
 <20180512143809.7c6a06ab@canb.auug.org.au>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 16:53:34 +0300
Message-ID: <CAHp75Vf4-MAODmGUwK1CfqbRs3gMjw3ysn97i27u3ms60ddPjg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600357259654300388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 7:38 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Wed, 9 May 2018 20:47:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
>> >
>> > On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
>> > > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:
>> >
>> > > > I think this is an excellent idea, copying in Stephen for his input.
>> > > > I'm currently on holiday but unless someone convinces me it's a terrible
>> > > > idea I'm willing to at least give it a go on a trial basis once I'm back
>> > > > home.
>> >
>> > > Since Stephen merges all -fixes branches first, before merging all the
>> > > -next branches, he already generates that as part of linux-next. All
>> > > he'd need to do is push that intermediate state out to some
>> > > linux-fixes branch for consumption by test bots.
>>
>> Good idea ... I will see what I can do.
>
> See my announcement of a pending-fixes branch in linux-next (on LKML
> and others)
>
>> I currently have 44 such fixes branches.  More welcome!
>
> We are up to 55.

For PDx86 we have

git://git.infradead.org/linux-platform-drivers-x86.git fixes

branch

-- 
With Best Regards,
Andy Shevchenko
