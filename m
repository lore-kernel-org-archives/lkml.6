Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52874C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F22207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gfN5B0md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F22207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeJXCOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:14:19 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61770 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbeJXCOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:14:19 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A9E80A1485;
        Tue, 23 Oct 2018 19:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:date:date:message-id:from:from:references:subject
        :subject:received; s=mail20150812; t=1540316990; bh=vtQsp62jAUd9
        x2+A8tEHe0PuVoUxUoMcbcmb02di91E=; b=gfN5B0mdEVYL6Liw4NIZEYzGuqim
        WDF6mSAHsE/v0HUypMs/6xBu8iSWj0elfrNABi8wp60alBsvUneJn3rxJSsf6PhE
        7xHuXWilWxg6BHDc8OAx0c5OosF815u+3EZa5UzBSn/x26JeWTrJgjujezV6VHsM
        k92DuP/RUcLFfzBYoLSCKY4rDX8nXeftx+74qbQhZpYk6ZNMxkCJV8iygh9c9WAl
        /eZ6EPaVlD1ZPU2PcjAArbqs3bjhqvmVdp/ciCChfrIna4qrVwZnnHGlz67q51sU
        VVSHPTLwxF+wQtCRInfPaOddDwkdwHAwQe7LJxk2ZmqJrpIZ0hA9OmEmaA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id qceHAS-YwFGi; Tue, 23 Oct 2018 19:49:50 +0200 (CEST)
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct:
 Fix some wording, and add an interpretation document
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        t@thunk.org, NeilBrown <neil@brown.name>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
 <87r2gh70ij.fsf@notabene.neil.brown.name> <20181023081144.GN1617@thunk.org>
 <1917804.q5V88l7eEq@siriux> <20181023154341.GF6850@thunk.org>
From:   Rainer Fiebig <jrf@mailbox.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jrf@mailbox.org; keydata=
 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
 6/dT7HxuwnVIkER8kg==
Message-ID: <0ece1f04-0f09-c9a5-d67e-2201406e86c2@mailbox.org>
Date:   Tue, 23 Oct 2018 19:51:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181023154341.GF6850@thunk.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Y. Ts'o schrieb:
> On Tue, Oct 23, 2018 at 04:22:54PM +0200, Rainer Fiebig wrote:
>>
>> And whether that CoC does come with a political agenda or is just being
>> *perceived* so, is irrelevant: the perception *is* the reality. And by 
>> embracing this CoC, Linux is now being perceived as also supporting the agenda 
>> that comes with it. But perhaps that was intended?
>>
>> In my view you now have a new, probably even bigger problem: namely that by
>> adopting *this* CoC and by unyieldingly clinging to it, you have alienated 
>> many, if not the majority of loyal Linux-users/supporters.
> 
> Citation Needed: What's your *proof* the majority of Linux
> users/supports have been alienated?  Many people have actually been
> quite supportive of the CoC.
> 
Ah, come on. Proof? Do you have any hard data to underpin your assertion of
"many"?

That it *may* be the majority is the impression I got from the many
discussions that I have seen, I haven't counted the pro- and con-comments.

But I've found a little poll at "Pro-Linux", small sample, no way
representative but accessible only for registered users.[1]

The question was: "The new Code of Conduct: Good or bad for Linux?"

- Brings Linux sympathies and support:	11%
- Costs linux sympathies and support: 	57%
- Will have no impact:			32%
- Nothing of this, but:			 0%

I wouldn't call this "proof" but a worrisome indication nevertheless,
especially if you consider the name of the site.

> And perception is a funny thing.  I have no doubt that there are
> people who will claim that some CoC's that might more be acceptable to
> you would be "useless" or "means nothing".  (Note how simply removing
> three lines that troubled ***many*** Maintainers caused Josh to
> complain that it ruined the CoC).  And there are others for whom the
> Contributor's Convenant automatically seems to mean kangaroo courts
> and harsh punishments with no accountability for minor issues.  I
> suspect that both you *and* Josh are unhappy, in opposite directions,
> might be a hint that we've mostly gotten things right.
> 

I find Josh's position rather extreme - for him it seems to be "All or nothing".

On the other hand, I've already made a proposal that is not too far from what
you have now - without the political sting. Doesn't mean you should use it.

So personally, I would be content already if you modified the first sentence
in the way that has been suggested by others here several times.
Less would be more.

> Another example of this is that zero-day testing bot changed its
> message in order to be more welcoming to newcomers.  ("Thank you for
> the patch! Yet something to improve...".)  At the Maintainer's Summit,
> someone from Germany pointed out that in European and especially
> German cultures, being ultra polite is often a signal that the person
> is considered stupid/incompetent, and he actually viewed it the change
> in the testing bot as making it be *less* welcoming, not *more*.  Not
> that he cared, because he has a thick skin and after all, it's only a
> 'bot --- but in his view he thought it was quite funny that the change
> was welcomed by some as being an improvement when he viewed it
> completely the other way 'round.
> 

Perhaps not *less* welcoming but yes, you might get the impression that this
bot wants to take you on a ride. :)

> Ultimately, we are a world-wide effort, and it's really hard to
> predict or control how people from different cultures will perceive an
> e-mail or some document.  That doesn't mean we shouldn't *try*, and
> there may very well be times when someone will file a complaint for
> what is perceived to be a Code of Conduct which is really a
> misunderstanding due to a cultural mismatch.  (And *obviously* that's
> not a CoC violation either, despite some people trying to spread FUD
> by making the case that it would be.)
> 
>> In my view, the Linux-CoC stands for exactly that sort of extreme "Political 
>> Correctness" that is infesting our societies and has proven its destructive 
>> nature in more than enough instances. For some examples see [1][2][3][4][5].   
>>
>> To me it feels more and more like the dark times of witch-hunts are back or 
>> when it was politically in-correct to say that the earth revolves around the 
>> sun. In those days offenders like Galilei were at least offered the choice 
>> between recanting and the funeral-pile. Today you may recant but you get 
>> publicly burnt anyway.
> 
> Yeah, and that's precisely the FUD that I'm talking about.  I
> understand that is your view.  Let's see if it's actually true.  I

FUD? What happened to those guys and other people is not fiction but reality.
And if a Nobel-laureate can lose his job and even leaves his country because
of a harmless joke which was quoted completely out of context, it's time to be
concerned and alarmed. There's something getting out of hand, imo.

I would have expected Linux to resist this and not invite it.

> haven't seen any witch trials or burnings in the GoLang community,
> which also uses the Contributor hConvenant as their CoC.  Can you be
> open-minded enough to accept the fact that you might be wrong?  And
> are you prepared to change your views if we don't see Maintainers
> getting "impeached" or otherwise burned at the stake in the next year
> or so?

I think I am. But are you open-minded enough to entertain the idea that
introducing *this* CoC *this* way might have been a ghastly mistake?

> And on the flip side, if we continue to have newcomers saying that
> they are feeling more welcomed, I'm hoping that Josh is also open
> minded to understand that the changes the we made didn't completely
> destroy the whole point of the CoC.
> 

Not so long ago I was a newcomer myself. And submitting the patch, discussing
and improving it was a constructive and motivating experience - *no* CoC needed.

What happened in the last few weeks was just the opposite.

We'll see how this pans out.

Thanks and regards!


Rainer Fiebig


---
[1]
https://www.pro-linux.de/umfragen/2/454/der-neue-code-of-conduct-gut-oder-schlecht-f%C3%BCr-linux.html
