Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB9220676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="Op37z2vP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB9220676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeIXXYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:24:22 -0400
Received: from cock.li ([185.100.85.212]:45396 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeIXXYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:24:18 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537809665; bh=9Aho6QKO5nohRXkH6PhijSNlpAmhHOgpLR8+1r3xMWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Op37z2vPC/TVqVaBZsGTrqeYyf3hIu6qzXlmWhGYScBEUmmTnmzg6ZfEtzSDDz8xK
         aKYweVeNdrffarCR26eJ+IDnJe8KzsYU65QV0P/Dg9V77LN/5Uw6iPdx3pUjFVoyNA
         ALcmwUhgpAfku5Q4jf3sFInsrguwIojYhlL/OHCZ6dVeAP1Mva4oSh9U2yvXsuj6V3
         c2nAkDcj7ttqo9rhLnCIk7to8jOEe/aUMXJd8BVa/ImNWuDYMS0CfMJEpYK0bF/rBA
         hPsF4xpKx6Vu2Y9XxRKViGGMJy+vB83pBMLhkusc8wvIHagHzGF/0v1OlGytte44Jz
         vAS+LJCYqBDYQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Sep 2018 17:21:05 +0000
From:   unconditionedwitness@redchan.it
To:     Edward Cree <ec429@cantab.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
In-Reply-To: <a9db544f-db9d-d6c4-67d8-43db2eb591fc@cantab.net>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <20180920041846.GA4418@1wt.eu> <206423b0a199c1f12e61364d6e687e09@redchan.it>
 <a9db544f-db9d-d6c4-67d8-43db2eb591fc@cantab.net>
Message-ID: <465e1aa6d734e66ab07bc11a9b52ae2f@redchan.it>
X-Sender: unconditionedwitness@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

better to bury a corpse than to let it rot in the air.****
> This is legally nonsense.  The only way I can revoke someone's rights 
> to

It is not nonsense. Gratuitous licenses are and always have been 
revocable at the will of the grantor.

(Yes, I am a lawyer)

Property law 101.
"But this is COPYRIGHT"
 From the US statute: copyright is alienable in the same way property is.
That's where you acquire they ability to license your work in the USA; 
congress' copyright act.
Prior to the Statute of Anne there was no copyright what-so-ever. It's a 
statutory right.
The statute grants the right to alienate said right(s), and, the 
drafters not feeling the need to re-invent the wheel, simply declared 
that the operation there-of would be by the established law of property.


> In short, "unconditionedwitness", please shut up.  You're not helping.
I am informing those who are being threatened with expulsion about their 
rights and what steps they can take against their enemies.
Matthew Garret claims your "consent" is immaterial (on the lwn thread).
He is wrong. The contributors must be kept happy.

You (providing you are the copyright holder to your own code) can revoke 
at any time.
There is nothing between you, and putting your detractors to task... 
except for your force of will and some paperwork.

****
> Moreover, even if I _could_ revoke the license, I wouldn't want to do
>  so; it would be ridiculously petty in itself and the precedent it 
> would
>  set would be destructive to the entire open-source community, about
>  which I care deeply.  It is _because_ Linux and other open-source
>  projects are so important to humanity that I spoke up about what I
>  perceive as a threat to it.

You and others are being threatened with sanction by people such as 
Matthew Garret if you do not obey their diktats.
They say essentially: if you want to contribute to opensource (haha 30k 
projects have CoCs now!) you will be BARRED from doing so if you do not 
obey our religion (anglo-americanism).

If you're not a feminist: you're sanctioned (punished)
If you're not opposed to men marrying female children (a practice 
permitted by YHWH in Devarim chapter 22, vers 28 (na'ar), aswell as by 
Sunni Islam), you are punished.
If you are not polite to women you are punished.
If you speak out of turn you are punished.

Yet they continue to use your code while spitting on you and besmerching 
your name.
While making sure you are forgotten if you step out of line.

(You do the work. They take your work. They try to harm you and reduce 
your civil rights. Sound like anything familiar... (c.p.t.l.i.s.m))

You must respect women who do NOTHING for you and even NOTHING for 
anyone else except exist as a USELESS physical entity (females who are 
not sweet young brides for men or mothers and just consume are not 
useful for anyone other than themselves: the purpose of females is to 
create more human beings and to bring happiness and pleasures to men: 
they are superfluous in any other capacity, as a class)...
who rules over you ...
or else you are punished.

You slaved away writing the code.
When they feel they don't need you anymore they seek to tear you down.

You have a remedy: Recind the grant.
You did NOT sign away your OWNERSHIP of the code you wrote.

The anglo-american belief system is that males are to be slaves of women 
and their masters.
This belief system is now being imposed on even hobbies like gratis 
software development.
They wish to give men no refuge, no place to build something outside the 
eye of the middle-class ("white" or english) woman.
To keep men checked and obedient at all time in all things.

But there is a way to strike back, to strike at the heart.
There is a dagger at the neck of that which you built but is now being 
repurposed to bind you.
All you have to do is push.
Such is all any rights-holder has to do.

Gratuitous licenses are revocable at will.


On 2018-09-20 22:57, Edward Cree wrote:
> On 20/09/18 10:27, unconditionedwitness@redchan.it wrote:
