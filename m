Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C102C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261712184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="qgDEq6q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfAFIjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:39:08 -0500
Received: from cock.li ([185.100.85.212]:35942 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfAFIjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:39:06 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546763944; bh=uMTxlglQJHuJHmdOaMtA6J0KZbbjGY+3+HcFOgEg7a0=;
        h=Date:From:To:Cc:Subject:From;
        b=qgDEq6q1NV1wykArZUywdCB4J2d5yBVwERTvgo4JuEZVep8zkQ8jX+IOimjUU9PL8
         eOcjRx2cDEvxPiYMLGzP8afipefYqtnFuk5+D5HmNFqWZ0RaFjYDh1EmYfyh2vU4Ql
         CYv6zoxQFbdbIgGNwvJdkPsfcgn6O+FLNz91ohoniOJWSK/wrXIlnZLqex0JrWeRUL
         U/52la7GEb25f4VEHVghPRHTXFDZJWKvtc7OhePIa6g/UnMOi4EYKHnxurtv2vF5DR
         KxT+ToFhx7jRxA2D/YGUIbmh0GMHPBhBULliaf+nau1RfytmMggLmSKWwOb/5x7bOs
         4bCYi/tPLsRKQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 06 Jan 2019 08:39:03 +0000
From:   vnsndalce@memeware.net
To:     schwarze@usta.de, misc@openbsd.org
Cc:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org
Subject: Re: Yes: The linux devs can rescind their license grant. GPLv2 is a
 bare license and is revocable by
Message-ID: <9a1150a8b8b1113b93ecba87b973d483@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That may be OpenBSD policy, but it is not the law.
Your OpenBSD policy cannot bind the copyright holder of the works you 
distribute.
It's also an incorrect statement of the law.

If the copyright holder did not receive consideration/payment/etc from 
you: you have no interest to bind him with.

He can rescind.

If you read the BSD license(s) there is never a 
"no-revocation-by-grantor" clause, so you cannot even make an argument 
that you relied on a promise of his (he made no such promise). 
Furthermore you never paid for that non-existent promise to begin with: 
he just gratuitously gave you permission to use and modify his property.

He end that permission.

Why would you think that you can make promises for some other entity 
even? How does that even make sense to you?

Additionally, the *BSD projects (as entities) cannot make promises about 
code they do not own the copyright to. So if you did not require 
copyright assignment from developer X, Y, Z, said developer still owns 
the copyright: not the project.

So, maybe the project or entity E is making some promise: but that 
promise was not made with respect to code snippet FOO since the project 
or entity E does not actually OWN code snippet FOO but instead there has 
been granted a license to use and modify it. Permission that can be 
rescinded from the licensee E unless the licensee E secured an interest 
regarding that (paid the programmer, for instance, and he agreed to 
terms etc).

The rule is that a license is revocable absent an attached interest.
Gratuitous licenses are not worth the paper they are printed on.
(usually they are never printed out tho :P, or even read).

They do not bind the grantor.
They bind YOU. Not the property owner.
(If you want the property owner bound to the terms you purchase that 
right from him in some way.)




Ingo Schwarze <schwarze () usta ! de> wrote:
--------------
Hi,

i'm not replying to the trolls (or their off-topic rants) in this
thread, and i'm not spamming other project's lists.  Instead, i'd
merely like to clarify a point that is actually on topic on this
list, to avoid that users get confused by FUD.

One of the trolls wrote:

> A gratuitous license, absent an attached interest, is revocable at 
> will.
> This goes for GPLv2 as used by linux, just as it goes for the BSD
> license(s).

That is not what /usr/share/misc/license.template means,
and i'm sure all OpenBSD developers are aware of that.
The OpenBSD website makes the meaning very explicit:

   https://www.openbsd.org/policy.html

   [...]
   Finally, releases are generally binding on the material that they
   are distributed with.  This means that if the originator of a
   work distributes that work with a release granting certain
   permissions, those permissions apply as stated, without 
discrimination,
   to all persons legitimately possessing a copy of the work.  That
   means that having granted a permission, the copyright holder can
   not retroactively say that an individual or class of individuals
   are no longer granted those permissions.  Likewise should the
   copyright holder decide to "go commercial" he can not revoke
   permissions already granted for the use of the work as distributed,
   though he may impose more restrictive permissions in his future
   distributions of that work.

Yours,
   Ingo
