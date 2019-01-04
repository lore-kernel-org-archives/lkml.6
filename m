Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613E1C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C162184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="Qi/y2Jeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfADG7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:59:49 -0500
Received: from cock.li ([185.100.85.212]:59426 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADG7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:59:48 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546585185; bh=mq9GT4/gfrryNANB6qb35FNyLLdqaPWYZS/BxkiLA/4=;
        h=Date:From:To:Cc:Subject:From;
        b=Qi/y2JeuPgWvvOY9agzKuMFR4BfjGvtwceVSft2b5v4xfeGodvL5AF4h3UKprOf2g
         E+Hf3TxeURmtkUK8CMddLDEENQu42Ih1rG2mxlW6qMq8orVjC+IF7zZjPf607VL6k1
         ML5/wnS0Rsd+buM2ZWhADM578BGDFzBMNM1K/jMe1iJ0xXZYnGf0tK+Hby6+TTCL71
         K9TyQCUHwmDpwc9r9OKVD2V5aIkCelb6xYkbcGSmXOEUwCSOkIbb6EXpCOJS/4iK2Y
         v8Xn9FbevFQ4MD02ba29dD+qK/mHsGGJ08SG3vyC76c/8wyDxg0U1ncas9clGFit2t
         KW+rzFNY1rFLw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jan 2019 06:59:44 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Cc:     freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, esr@thyrsus.com, moglen@columbia.edu
Subject: ZDNet article on GPL is wrong and misleading. PJ (paralegal) does not
 fully understand the law she's spoke about.
Message-ID: <5918e2886da009d3a2e962d1c7c8b2da@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Often cited now is a ZDNet article as proof that the black-letter law is 
wrong.

https://www.zdnet.com/article/what-happens-if-you-try-to-take-your-code-out-of-linux/

In there is quoted:

> In 2008, Pamela Jones at Groklaw remarked to an earlier attempt to take 
> code out of the kernel, "[You] can't retroactively revoke licenses 
> previously granted, unless the license terms allow you to do so. The 
> most you can do is stop granting new licenses."

(Pamela Jones was a paralegal).

> Jones continued "Here's the GPL v2. See any terms allowing you to 
> revoke? Me neither." In short, we've seen this problem before.

Now, this is true for commercial licenses which are contracts, that is 
because an interest is attached: You payed consideration for the terms 
of the contract. The contract states a method of revocation, you payed 
the owner for that term, that term controls.

This is NOT true for a license (permission to use property) that has 
simply been given to you.

This is a crucial point that they keep ignoring, intentionally.

I have the legal books they are reading and operating from, and they 
simply speak about commercial licensing contracts.

They're helpful if you're just going through the motions to get cases 
before a judge, but without knowing the rest of the law: one doesn't 
know what one doesn't know.

Basically how they are researching the law is: "ok let's look up the 
subject: Copyright", they then look up "revocation", and read how the 
courts generally resolve these issues, these issues always involving 
commercial paid licensing contracts, and not gratuitous licenses.

They do not ask "well why is it that these various copyright licenses 
are irrevocable?". The reason is: they are irrevocable because the taker 
has payed for them to be irrevocable. They payed the owner for that 
term, and the owner can't then take away what he gave them.

(A lawyer, generally, knows this and has a wider view of the law. A 
paralegal: no - they work mostly on whatever their employer works on. 
And yet ZD Net and everyone else cites her and ignores the underlying 
law.)

Which simply is not the case with a gratuitous grant of permission.

They either didn't pay attention to that part in law school, forgot 
about it, or are trying to defend the position of their clients.

Many of the various linux programmers simply gave permission, and didn't 
ask for anything in return. Additionally the takers did not give them 
anything in return (not that an un-asked for payment would sufficent: it 
wouldn't be).

Thus it is a gratuity from linux-coder-1007 to 
downloading-and-hacking-entity-10000007 that said entity may use 
linux-coder-1007's code, and modify it, and redistribute the 
modifications.

It's a pure gratuitous license from linux-coder-1007 to whomever.

And that permission can be rescinded by linux-coder-1007 when he wishes.

Basically the words of a paralegal is taken as gospel truth, the words 
of a license attorney, even when explaining the issues in great detail, 
including their foundations, is taken as dog shit.

> "LOL NOPE: PJ said otherwise in 2005, u wrong!"

<"PJ is repeating the rule she knows from a section in Copyright 
Litigation Handbook, which applies to commercial copyright contracts, 
very specifically _because_ they are _commercial_ _contracts_ (that is: 
the taking side has secured his interest, there has been a meeting of 
the minds, etc). And yes I have the same handbook, along with many many 
other volumes"

> "Haha fuck you you don't know anything and are LYING!"
