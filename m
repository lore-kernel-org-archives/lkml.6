Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9852145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9852145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJHXsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:48:50 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeJHXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:48:50 -0400
Received: from [192.168.1.110] ([77.4.53.57]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkpKR-1fPX2e0z79-00mKN9; Mon, 08 Oct 2018 18:36:15 +0200
Received: from [192.168.1.110] ([77.4.53.57]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkpKR-1fPX2e0z79-00mKN9; Mon, 08 Oct 2018 18:36:15 +0200
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d6e5d719-2709-d1bf-77ca-b99ca0b0ea94@metux.net>
Date:   Mon, 8 Oct 2018 18:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GjWAOtGgh2QqaH0rNFa+NFKwYjGQ99q01HVJDDeFjOHFc6ll5Cm
 C3q/H2L6Tqh6f/m87DVvYYts/hRQQTvPI/xEfKvwSSAt29ecQoncJYBijlqEr7LVAzoJHZQ
 +nk/2BRYDwM0p5OieQOAJ7X8bmZODl2M87C5QlmP0bv7OFihMismYnhR1m2npJ571PI1sNb
 D0YLViJDHCDMjSfEUpd6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qsaGARcp/8g=:1cccwWlX3s0y2JIxQO3x90
 YXrWis//qchYbfPM3qkoHaxrxMGGMbaJ0jrbh2b4i8CZrTLaE5EyFDTAOFNZ1KHquLm66cO0l
 wacCva5D6+SLurTYkByShgUcoknhsCWNCvuOipmFtw9zRSNmBkXHOGNstj3ckz8UtyypEyLLa
 3klfCYImDkSrkU7t+snlC748BMK9QsDgVbifqe4QfEnwNSkea7IPd+NyIX24mBVRfA49IsjHd
 6MC62d8oox+n9joKe9s7MMOPUuCsfQPf0gLThEO1W3bRHVuqUMx8e8bOWE7r7bTntimVa3164
 MivnJDYpIt0vKQUAlD1vGoqUn81TFdnR6FQI27Dk0nhM1JAjefdsls4Fqt4ZizFSTvLvrDLGT
 154wTbbzKJimW4VSRofaomswQvhye4fjW16ZI+eb2bbqtbuofG/T7iR7d0A0GmgdO6WzQiFBk
 P1Lyb2/gYZOZ/MbflwD0cBRdwcaeHQhaZPW95CXk7mhPn85U0qUmErfXYyDZCtUz+wQUgt0/L
 eZx2b0X6p1+Fsn5vUjlQpduRNGJHZHm7d60IpYp48QEEZ2wY7bowEthoSQIbzzKhgjgIJAa/i
 zhPFc52lQgXmlFMetHM0+/+cL7TCAZ3jO61SSV1wmbzLAXa4EpHxdv5mWOzGH6hrHeI514LOr
 MYb6tybMg9dlPXiGfWn8il7a+arYJzMFS/72mw2Uhzr6meMNXPI7cVALzsRDFsxE2veoMlxq/
 9P8yAf8g0BXeJ24v
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.2018 21:22, Linus Torvalds wrote:

Hi,

<snip>

> One was simply my own reaction to having screwed up my scheduling of
> the maintainership summit: yes, I was somewhat embarrassed about
> having screwed up my calendar, but honestly, I was mostly hopeful that
> I wouldn't have to go to the kernel summit that I have gone to every
> year for just about the last two decades.

IMHO, if you - for whatever reason - want to skip a conference, it's
your right to do so. You've done so much for us, you deserve a break.

> This is my reality.  I am not an emotionally empathetic kind of person
> and that probably doesn't come as a big surprise to anybody.  Least of
> all me.  The fact that I then misread people and don't realize (for
> years) how badly I've judged a situation and contributed to an
> unprofessional environment is not good.

I, personally, never felt the Linux kernel community was anything like
an unprofessional environment in any way. Quite the opposite.

Certainly, there's room for improvement here and there, but IMHO, the
general situation is the best of all projects I've been involved in.

Don't be so hard on yourself.

> This week people in our community confronted me about my lifetime of
> not understanding emotions.  My flippant attacks in emails have been
> both unprofessional and uncalled for.  Especially at times when I made
> it personal.  In my quest for a better patch, this made sense to me.
> I know now this was not OK and I am truly sorry.

Maybe I've missed these mails you're referring to, but I didn't see
anything which IMHO wasn't justified. Even if you'd call a patch of
mine "the greatest bullshit i've ever seen", I wouldn't consider this
a personal attack for a ns. Because I know I would have come from a
completely different perspective than mine.

> The above is basically a long-winded way to get to the somewhat
> painful personal admission that hey, I need to change some of my
> behavior, and I want to apologize to the people that my personal
> behavior hurt and possibly drove away from kernel development
> entirely.

I don't know anybody of these people personally, so I won't judge on
that. I've just seen some blog posts, which looked pretty subjective
to me and didn't tell what exactly happened. My theory is that people
took things personal, which haven't been personal at all. But that
seems to be a general problem, which is far out of scope of any
professional software project.

> This is not some kind of "I'm burnt out, I need to just go away"
> break.  I'm not feeling like I don't want to continue maintaining
> Linux. Quite the reverse.  I very much *do* want to continue to do
> this project that I've been working on for almost three decades.

:)

> And yes, some of it might be "just" tooling.  Maybe I can get an email
> filter in place so at when I send email with curse-words, they just
> won't go out.  Because hey, I'm a big believer in tools, and at least
> _some_ problems going forward might be improved with simple
> automation.

In that case, I doubt it's a matter of tooling. It would require a kind
of artificial intelligence, that hasn't been invented yet. NP complete
problem.

If you really feel, your reactions on certain things, your way of
communication was a problem, then I'd raise the question why such
feelings, that trigger these reactions, come into your mind in the
first place.

I've been through something similar. I easily got angry about by bad
code and people not understanding things I considered self-evident.
And in my case, it actually escalated onto the personal level.
My approach was self-monitoring of my feelings and behaviour. Whenever
I felt my blood presure reasing, I took a cigarette break and thought
about why I'm thinking that way now. Usually, I came to the conclusion
that these folks who did some crap again, just don't know better, they
never seen what I've seen. And it's my job to train them.

This way of thinking helped me a lot, maybe it could help you and all
there other, too.

> I know when I really look “myself in the mirror” it will be clear it's
> not the only change that has to happen, but hey...  You can send me
> suggestions in email.

Unfortunately, I have no idea, what exactly you've seen in the mirror.
I can only judge on what I've seen here in the last decades. And I like
you exactly that way. Especially the rude part, eg. when it's about
corporations like NVidia, or people who try to refit the Kernel for
their broken userland stuff.

If I may propose a patches to your /dev/brain, the only issue would be
100% strict GPL enforcement ;-)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
