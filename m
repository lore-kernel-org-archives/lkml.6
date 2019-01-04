Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3BC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C460E21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="XwoaZwd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfADGzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:55:00 -0500
Received: from cock.li ([185.100.85.212]:55278 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfADGy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:54:59 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546584895; bh=BWVILXV5MmsXM2QopGeAHofKxgJdyYcSBsExF/QPlDc=;
        h=Date:From:To:Cc:Subject:From;
        b=XwoaZwd/at/Azd5CfOdrjogWshI8ZU0w2F34GVe42TBKHDB4sIIxfMUx/5WZZ9WFo
         VJF4F9HnOAVqHZ2df9YUMhy/yXkmgePDwmFb8bl8mrlPPyGvHLPe01hm93v/IGhywn
         zR1N0T1UzoV1g4DEUGRiPtZDQMjKmPNvK9eDDJ37g2zMJiGGeuEVFLJkvHKRccjx6S
         DRr9X2opHjXBpQEabDBpNPZ2r801dvapNTlcgBeoTiNo08ZHI/3AzL74PEzDuRqt1O
         rAXh+QzhpwfqadIAOWpkuPb3gdYebuVbUHyeNCEwqs4Lsd7YeA4UUUXMroooPbIrE1
         rY3SL9T60hXGQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jan 2019 06:54:54 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Cc:     rms@gnu.org, freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        misc@openbsd.org
Subject: There is no rule "software distribution licenses are irrevocable"
Message-ID: <fa043cc551361089c860b61928d2f569@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> 1016160

> Everybody else in the SFConverancy and the LKML disagree, a software 
> distribution license is non-revocable.

Yes, and they are wrong.

All the programmers in the LKML are indeed wrong in what they believe.

The non-lawyer* at the SFConverancy is indeed wrong in what he believes 
(They even had to hire outside counsel to draft their response, which 
was full of weasel-words and non-statements)

*https://en.wikipedia.org/wiki/Bradley_Kuhn#Academia_and_early_career

The fact of the matter is, there is no rule "A software license is 
irrevocable".

The rule is, when stated simply: you get what you have paid for.

If you contracted for a specific rule regarding revocation, and you 
payed the grantor for that rule: that rule will apply between you and 
him regarding the piece of property (unless it's against public policy 
etc).

If you did not pay for such, you cannot rely on such a "promise".

That is why you THINK there is a "software licenses are irrevocable" 
rule: because the cases on this issue involve commercial 1990s software. 
In those cases the judges ruled that the company could not willy-nilly 
revoke licenses because the customer had payed them for it: specifically 
for the terms in the license: so since they were paid for the court held 
the company to it's end of the bargain.

Here there was no bargain: The linux coders simply have allowed you to 
use their property without you giving them anything what-so-ever.

That is the crux of the issue.

That is why the FSF and others require copyright assignment for any and 
all contributions of code that they will accept into their own code 
base.

If they did not the actual copyright owner, having been paid no 
consideration for the license terms, can recall the property at any time 
(rescind the permission: the license).

That is absolutely the case with Linux.

That is why the GPLv3 was drafted, that is why they are trying to have 
the kernel programmers electronically assent to all these extra pledges 
now.

They want there to be some interest they can point to as reliance. Right 
now there is NONE.

And even then, even then, even if the programmers put out a piece of 
code and said "I will not revoke this license".

(Which they did not do in the GPLv2).

How is it secured by you, Entity X? How is that promise something you 
can reasonably rely upon? What have you given to Property Owner for that 
promise? And did you come to a meeting of the minds regarding such?

Nothing and no.

You have no case whatsoever. You cannot bind the hand of the property 
owner regarding his own property without giving him something that he 
has asked you for: and you can't simply "give" him back his own property 
as "consideration" either (since you have no prior-rights to it).
