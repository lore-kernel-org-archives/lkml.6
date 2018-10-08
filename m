Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCA4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DE320858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DE320858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJHVGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:06:21 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:06:21 -0400
Received: from [192.168.1.110] ([77.4.53.57]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0Fl9-1fnslY0C6p-00xO45; Mon, 08 Oct 2018 15:54:27 +0200
Received: from [192.168.1.110] ([77.4.53.57]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0Fl9-1fnslY0C6p-00xO45; Mon, 08 Oct 2018 15:54:27 +0200
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Pavel Snajdr <snajpa@snajpa.net>, michaeljpwoods@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
 <93424bb0-180e-71ff-f0d6-602caa2d5883@gmail.com>
 <260205ec45d097fb037f71ae42e7b69e@snajpa.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <dc799c03-fefd-45f2-e0bc-b65e356dce61@metux.net>
Date:   Mon, 8 Oct 2018 15:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <260205ec45d097fb037f71ae42e7b69e@snajpa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NaKyiJRmCAtTG2GoMpHPSyIRpFmuokCxAnBY+b1hUt4wQZawva+
 o3YSwnL9zDMjfD0zIMQHrYXpBEBjhlPew3T+xgMQC7oQVvpIeqt63GlIlIQwEu1S4kKpWLM
 h357r3DpRTiiRUo9JjJpSCstb9a6/bEh6/JmFnw4L8FEAd5Riceg1R3jVyaMsMf4B83zQqK
 FYJ0Rmpo4QllT33k9lmeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tUQBIM/66gI=:AyPhQv1K1L00Wbf2KjHkQd
 4jnAp1psGzPb1TfBNZ4MoLDlAfuHFKdipMSf4s8/Zf6VFa2TjekyotWCaGI70LBmT84LN9A6h
 z5YZPvjtAvjYYgrSb70UPiAtgRcJ2GchoKi2qNnqq7lHMwwOUW9GQn0GNuyP1V6vbitK02aUv
 w9QjwI7tskE6B4Jm4eQGTFRZd93m/PAZo4QLXC5pXFvrVbA1I/UiTe2Mj1b8YF9iCczPjQW7u
 /pcp6qxKwHMW/YrAKf1cbbOESDhft5xywl+mqIN6R/+nQS0a5lqlg7LEBsRf519rV2G0UlRLI
 6mZfj21gzGwgYJdNfptvHu7PUc2f2oWBHJxezWQSv55Ml062LoOHI5vwhNw9Bf5jXsUQetI+l
 PhG2fDpj4SKWw+Ytmoo949XIp/O4NQcXPI7XFtudODf7RYOxLaAsd0jeOMcRQXECbdXOCvmsZ
 Xw5jmdYCG7ptg5OYL67u9VBfwXa+44r/B2lvAcHseZIH0+EO2/Jco9yvFcSJPpPnCiK7WLWUI
 oV/VImenEtXN95IZZq/fASmzzXF++KsDM8XtiqybFWY8VqPo33+4L0tPlS1TLf3Py4QPy7Qk6
 Rn5bsVaM/7c+Rh68nbdhxnYKYmIBNeWtkmpohfiwNc8NoeqfplZ+Js3pYL4XCk0FJZRlMJmSi
 oRoSNAlert7KdzeQGio8eXSt7GhPcwETaIrPfl4BPJP04QLlj/odmxjljf4LwbafDcE/2vxSZ
 DtlNm9ZTX3AjHGdJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.2018 03:30, Pavel Snajdr wrote:

Hi folks,

I usually try to stay out of political issues in software projects
(there're already too much real political problems, where people need
to stand up and push away actual oppressors), but now I have the bad
feeling that political (or more precisely: social engineering)
techniques are abused against the Linux kernel project.

> and how about if we viewed the new Code of Conduct as about the same> thing as BitKeeper was for the development process?
Bitkeeper was used as an intermediate workaround for conceptional
deficiencies in CVS (and all other tools based on the same principles).

But I really don't see any conceptional deficiencies in the way the
Linux kernel community worked in the last decades. Actually, it worked
very, very well. It created the best general purpose OS kernel in
known history, that scales from small embedded to big clusters.

And this has *VERY MUCH* to do with how the community worked for the
last decades. IMHO, it's even the primary reason. Not having to care
about personal behaviours, corporate hierarchies, marketing, whatsnot,
only care about technical excellence. Nothing more, nothing less.

> It was not perfect, but wass *something* for a start. 

A start for what exactly ? Just for the sake of doing *something* ?

Well, that sounds like the typical corporate manager's / politician's
behaviour pattern: There seems to be a problem, we need to do something
fast - doing nothing is worse than not doing anything quick enough.

Yeah, that's exactly what I'm regularily observing with my clients (the
bigger the corporation, the worse). And that's exactly why so many of
their projects fail so miserably, and products are such a crap.

I really hate the idea of the Linux community falling into the same
trap. (many of the GUI projects already did, and their code is crap)

The best thing, IMHO, is to totally ignore any kind 'social rules'
and focus on the actual technical goals. And don't take anything here
personally. *If* there really happen some ugly personal attacks, we
can talk about that on a case by case basis.

> I've been always looking up to the guys leading major community projects> and how they go about things - and I think, that most of the bad>
fall-out in them is caused by insanely high expectations - firstly from>
the leader themselves, and secondly from others as well.
Can you give some example of such bad fall-out ?

> P.S.: this is my first "contribution" to LKML, I hope to start sending> up some of my very prototype work soon for discussion, regarding the>
Cgroup subsystem ID allocation & limits - and subsequently, start a>
discussion about getting Linux to do better OS-level containers (ie.>
those, which have a "look&feel of a real VM" from the admin's perspective).
Please add me to CC. I'm working on similar areas (if my time budget
allows ;-)).

Even better: create a separate maillist for that, if there's not already
some fitting one. LKML's a pretty crowded already.

> We started our organization (vpsFree.org) on top of OpenVZ patch set and> are now working to get vanilla up to the task of replacing the
venerable> 2.6.32-based OpenVZ 6 Linux-like thing.
What exactly are you yet missing in current mainline ?
Are these things that really need to be done in the kernel or could
it be done in userland ?

My personal area of interest in the container context isn't the usual
'put a whole system in a box'-thing, but instead using namespace
isolation an general software architectual feature, similar to the
Plan9 world - eg. allow unprivileged processes to manipulate their own
fs namespace at will, use synthetic filesystems as generic IPC, split
huge applications into small and resusable programs, etc.

> The new Code of Conduct is a guarantee for us, that we won't be laughed out
> of the room  and that our members won't be demotivated to contribute upstream

Seriously ? You really need some kind of 'social law' that protects you
from the risk of being laughed out ?

No offense, but if that's really the case, then you've got a much
bigger, more serious problem, which also persuades you in your daily
life: deep lack of self confidence. I feel very sorry for that,
and I'm offering my help. For anybody who feels that way.

Yes, I had exactly that problem for my whole childhood and youth, until
I've learned a vital lesson: It just *DOES NOT* matter whether some
people laugh about you or your work - as long as you're sure that you
your work is the right thing for *YOU*. Simply ignore the trolls.
(BTW, the really good point on FOSS is: you can fork anytime and do
whatever changes you feel right for you - no matter what anybody out
there thinks about them).

So, don't let such things come into your way. Just do whatever you feel
the right thing to do and then let's talk about that.

I have no idea whether your patches have a chance to mainline anytime
soon. But that shouldn't even matter. Solving a specific problem and
fitting in something into the big generic world are two entirely
different things. Many great things (eg. various container subsystems,
realtime, android stuff, ...) went a long way towards mainline, some
still have a long way to go. That's just because it's these topics
are far from being trivial. And that shouldn't stop anybody.

> If I understand the context correctly, the previous "regime" could be
> the culprit, at least to some extent, why still don't have the VM
> look&feel-having containers with vanilla. 

Why exactly do you think so ?
What exactly are you missing here ?
Where's the connection to social rules ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
