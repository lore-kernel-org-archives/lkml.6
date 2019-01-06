Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFFC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 06:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AC22184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 06:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="vehBMpcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfAFGgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 01:36:41 -0500
Received: from cock.li ([185.100.85.212]:39578 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfAFGgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 01:36:40 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546756596; bh=3aJZsbJG5Z0bkrditZmO6noQzvc+9C7BhhVpSUpcF5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vehBMpcx0nwIsJz2gvdkjBSvwowDNBNYEB+M0UbpX7lMKYzENY2pfXWbEAeJTA3dO
         Q6sZY1uR/qS7iiylmuX9O9Z74eA98aAYb8bsQo/9Jf5xBJxzWLCwxCGiN/dYTh4mIx
         L1a02p1996LTyZlVWeZKsOUkEhFG8FjsHsvFejB/HR6uTSTGZ1HW1RKpznn9ZuvXB2
         pCVjxSgQpZWyjrftp+u5j2VtkOzNKJ0oEG9TvLIvqqPkahx1llo3h/oq9aRaR+LTCi
         c1uOhcN4Xhglz8Lb9w8qYVF7VHAjptABG5zWYyaRPvMS0Y9eE3qZ+C4W3qcykIk58A
         t5ftaJc6VF4ng==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 06 Jan 2019 06:36:35 +0000
From:   vsnsdualce@memeware.net
To:     Emanoil.Kotsev@fincom.at
Cc:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org,
        misc@openbsd.org
Subject: Re: knifeshack (Linux Property rights)
In-Reply-To: <201901031319.04730.Emanoil.Kotsev@fincom.at>
References: <201901031319.04730.Emanoil.Kotsev@fincom.at>
Message-ID: <754b0378b47ee8c3761f3de43a452ff8@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your "no it does not because we are talking about software" argument is, 
to put it simply in a way you can understand: retarded.

It shows that you, a software engineer, because you are learned in one 
field of endeavor, believe yourself to be "smart" and "reasonable" in 
unrelated fields of endeavors. You are wrong. This really shows how 
stupid alot of you western software-only guys are. (Also moronic is your 
constant disparagement of those who have to deal with the physical 
realities of things: the hardware guys).

I have gone to lengths to attempt to teach you the foundation of 
licensing law, how it interacts with copyright, and how such applies to 
the specific facts surrounding the linux kernel; myself knowing the 
history of the kernel, and also being studied in US law.

It doesn't seem to get through.
So simply: You are not a lawyer. Do not think your "common sense" as a 
software engineer applies to the law.

---
(On to the knifeshack analogy/story:)
In the USA, the law regarding licensing of various properties is 
similar. The key here is that the owner simply gave permission to use 
his property (he did not seek payment for extending that permission).

To illustrate the fact, so that non-lawyers would understand, we have 
used a Knife as an analogy.

Also note: It is from the USA that the CoC problem is emanating, so it 
is right to use the law of the USA to illustrate the point (also since 
that's where lawsuits are most likely to occur: You do know about the 
USA, correct?)

It doesn't matter so much, in this corner of the law, that IP is not 
physical property. In the area of giving permission to use it, it is 
treated much the same.

Remember: the "Thing" that was extended to you was the permission, that 
is what you "have", you do not own the intellectual property you were 
licensed.

Now, once we look at commercial licenses, things get more complicated 
because you paid for the license. But the key point here is that this 
isn't such a situation. We are not discussing commercial software 
licensing here.

When you cursory look up information to "fact check" me, 9 times out of 
10 you will be reading about the law as regards to commercial licenses 
where there is bargained-for consideration. Then you cite that to say 
that I'm wrong. (PJ made this very same mistake on this issue in 2005, 
she's still "cited" even though she's just a paralegal (still) and not a 
lawyer, and is wrong (maybe that's why she shut-up once her identity was 
know)).

A license not coupled with an interest is revocable by the property 
owner. It's fairly simple. Ask yourself "did I pay linux 
programer-copyright-holder 7829 for permission to use his code?". No? 
Then you have not paid for whatever "promise" he made to you (if any). 
Thus you cannot bind him. And as I have shown; he never even made the 
promise you imagine he did.

The whole counter-argument is to concoct some non-existent attached 
interest. The fact that we are dealing with software and not land or 
personal property is NOT controlling. I know you think it should be 
handled differently, but your uneducated opinion is not controlling law.

Perhaps you would be better off with a video recorded in American to 
explain it all simply:

Video: https://openload.co/f/mT_AH3xmIUM/TruthAboutLinuxandGPLv2__.mp4
Audio: https://ufile.io/sdhpl

On 2019-01-03 12:19, MPhil. Emanoil Kotsev wrote:
> vsnsdualce@memeware.net wrote:
> 
>> On 2019-01-02 02:32, Mike Galbraith wrote:
>>> Take your medication.
>> 
>> Don't like the story? Why what is wrong with it.
>> 
>> Was it the entrance, the middle, or the conclusion?
>> 
>> It simply explains licensing in a way you might find helpful, as it
>> relates to linux.
> 
> No, it does not, because you can not copy and redistribute anything but
> software.
> 
> PLS give us a break!
