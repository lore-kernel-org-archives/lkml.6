Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22CBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295CD218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="BSv4uqUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfAYQeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:34:46 -0500
Received: from cock.li ([185.100.85.212]:45018 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfAYQeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:34:44 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548434079; bh=TK+tNAy89sPSyNdkFAV6TLfN89aNATDSEnRCTfwPTZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BSv4uqUPj1Ur8RHzQ/n+UDce6l//yjf+dYp0MzOSMH/2WTcPyYyZuShl/MKvgB8bx
         EbaeL+KUivYsYFaVYQd+Tzh6rb8BJ4mkClaISKqDsvG+zK3DBcgNaEtYUD5i9tw6Eo
         /bh/c6ot/cKpbGUrgAJ5cVrzTCVycPolnw6x4A6A4lt7XeH8C/LRvcuHf+et4BEan4
         RKnB+GpV6EE4QF7Cp1sFFM4vg2VgIS4C4E4PCQpmcx3DDIyi407xADRDW8SIyrZaeX
         0olZ6rBACqsKrFqhlXI3zRaMikstAfNNkcABq9oY3Dya3bk4QAE+JNEiXNEKSvsu+r
         q62Lcj+lqHmPQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Jan 2019 16:34:39 +0000
From:   linuxgpletc@redchan.it
To:     Boris Lukashev <blukashev@sempervictus.com>
Cc:     Ivan Ivanov <qmastery16@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gentoo-user@lists.gentoo.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, esr@thyrsus.com
Subject: Re: GRSec is vital to Linux security
In-Reply-To: <CAFUG7Ce87ALJNgOSY5SZYFy4YWnOLdGx_+L-M+BTERBToD9GbQ@mail.gmail.com>
References: <7bdd68b2223ea30da821b37a68d940a7@redchan.it>
 <CAFUG7Ce87ALJNgOSY5SZYFy4YWnOLdGx_+L-M+BTERBToD9GbQ@mail.gmail.com>
Message-ID: <1abb6fa63ec5a9aa94a5b794c93f99e7@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you a lawyer,
Yes (also a programmer)
> acting on behalf of someone
No

> Sue to what end?
I wish I could say "to free the source", a court isn't going to order 
specific performance where there is no contract, and there is no 
contract between the Copyright owners and GRSec. Just a bare (and 
revocable at will) license.

They could revoke if they didn't like Brad's face.
They can sue for damages (profits probably) since he violated the 
license, and thus copyright (he would be more protected if he did have a 
contract with the (C) owners: damages on his end would then more likely 
simply be whatever he paid for the license)

> Force them to freely distribute their work/give up
> all those hours of backports/integration and actual invention?
I wish this were possible, but the GPL is not a contract in this 
instance, so specific performance is not available. It's just a bare 
license, you can get damages ($), that's all.

If the Copyright owners registered their copyrights prior to the 
violation they could go for statutory damages and attorneys fees though.

So to what end...
Rage at GRSec getting off the opensource boat.
Anger at not having the security-code /slave/ we had for years.
Bellowing about how we are servants to our creed, and yet this 
once-compatriot has betrayed that which we hold dear.

An attempt to use the GPL as a sword (instead of as a shield)?

Opensource works because men like being slaves. Slaves to their country, 
slaves to women, slaves to an engineering field, slaves to a belief, 
(and more recently: slaves to Codes of Conducts for hobby projects!).

Should not those who are still the slaves, rage against he who would use 
their free labour and end his contributions back?

I think that is the entire point of "Copyleft". It's a way of getting 
work that would cost millions of dollars, for free.

It works pretty well, up until 40 year old programmer has no stacy to 
fuck, and no possibility of getting one.

But there's one last striving that can be done: one more needle prick 
(or even knife gouge) that can be done against the escapee: and that is 
a copyright lawsuit.

Since I cannot have my free leet secure kernel patch anymore... and no 
one is out-in-the-open posting it in defiance of Brad (the escapee), I 
would like one of the fellow slaves with standing - to sue him. In 
vengeance for his betrayal of our class. They have a justiciable case, 
evidence already in the hands of the courts (thanks to the libel case 
(Thank you Bruce :D)).

What I really want is for GRSec to remain or return to being open and 
free, like the GPL is supposed to provide.

On 2019-01-24 20:18, Boris Lukashev wrote:
> Sue to what end? Force them to freely distribute their work/give up
> all those hours of backports/integration and actual invention? The
> only thing a suit could achieve is to prevent them from doing any work
> at all as you cant force someone to work for free (in the US, under
> most circumstances). No contributor will be able to prove quantifiable
> material damages, and the outcomes are between destruction of the only
> Linux vendor who puts priority on security or a waste of money and
> time in the lawsuit. Only the lawyers benefit, everyone else loses out
> directly or indirectly. Are you a lawyer, acting on behalf of someone
> interested in slowing the progress of defensive technologies, or just
> miss the days when being as script kiddie made people feel powerful?
> 
> On Thu, Jan 24, 2019 at 11:54 AM <linuxgpletc@redchan.it> wrote:
>> 
>> There is ample standing to sue. GRSec made it's "access agreement"
>> public,
>> which included terms to prevent redistribution (if you redistribute, 
>> we
>> punish you). Which is a direct violation of the "no additional
>> restrictive terms"
>> clause in the GPL.
>> 
>> Why won't anyone bring a copyright lawsuit?
>> 
>> Are they happy that GRSec gets to use their code, and prevent anyone
>> from
>> freeing the derivative work? The whole point of the GPL is that
>> derivative
>> works be under the same terms.
>> 
>> Bradly Spengler has violated this understanding, he thinks that his 
>> code
>> doesn't need to be under the same terms. The code which is simply a
>> derivative work of the linux kernel.
>> 
>> There is a valid, actionable case here.
>> 
>> Any of the programmers / copyright owners who's code he modified can 
>> sue
>> him.
>> He is violating their terms of use of their software.
>> He is in the USA. It's not difficult. Just SUE.
>> 
>> Just because VMWare does things one doesn't like doesn't mean you 
>> cannot
>> sue
>> Bradly Spengler.
>> 
>> Another thing is, the "Free software" legal "representation" is trash.
>> The SFConservancy was run for the longest time by a non-lawyer BKuhn.
>> 
>> He advised "clients" to WAIT it out! And then.. guess what they have
>> waiting years?
>> No case because the statute of limitations had been passed.
>> 
>> That's how that baby-faced moron has "helped" the free software legal
>> cause.
>> 
>> You guys need to hire real IP lawyers, not bullshit pretenders.
>> And if Bradly is making money, and enough of it, you might have 
>> profits
>> you could target.
>> 
>> I kinda think that the "Free software legal" teams exist only to 
>> diffuse
>> valid suits,
>> and stymie the guys who actually wrote the code and retained their
>> copyrights.
>> 
>> Pure legal malpractice by any accounting.
>> 
>> On 2019-01-24 16:25, Boris Lukashev wrote:
>> > You've never heard of VMware, I take it? Its a proprietary half Linux
>> > which beats GPL suits with strong arm tactics and technicalities.
>> > Unlike grsec, they don't distribute any source, because it's proof of
>> > theft... Grsecs back port work is also public, since they're public
>> > upstream patches or mailing list patches, the GCC plugins are the real
>> > magic... Those aren't as GPL as the kernel, rap is patented, respectre
>> > likely will be as well. The critical code changes they need (per CPU
>> > PGD, for one) will not be accepted as Linus has "said so." Those code
>> > bits are out there...
>> >
>> > Also, doesn't matter if their patch leaks for the most part (4.4 just
>> > did get leaked a few weeks back), as I wrote before, nobody really has
>> > the time or skill available to maintain at their level of quality...
>> > Linux might be free, but it's not something that should be run in
>> > production when there's data or resource at stake.
>> >
>> > Is the thought process that they should open up their commercial
>> > stable code for free to all? Because RHEL has the same "don't leak"
>> > policy on RHEL sources too... VMware even goes so far as to blatantly
>> > claim not to use Linux. How about Google's internal Linux?
>> >
>> > GPL is dead (has been for 20y), build the strongest defenses you can
>> > with whatever code you can get and prove, because your adversaries
>> > won't care about which license clause their tooling adheres to.
>> >
>> > Boris Lukashev
>> > Systems Architect
>> > Semper Victus
>> >
>> > -------- Original Message --------
>> > From: linuxgpletc@redchan.it
>> > Sent: Wednesday, January 23, 2019 05:35 PM
>> > To: bruce@perens.com
>> > Subject: Re: GRSec is vital to Linux security
>> > CC:
>> > moglen@columbia.edu,bkuhn@sfconservancy.org,compliance@sfconservancy.org,blukashev@sempervictus.com,tcallawa@redhat.com,torvalds@osdl.org
