Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395FFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C632218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="kxFPPTsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfAXQyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:54:02 -0500
Received: from cock.li ([185.100.85.212]:52380 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfAXQyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:54:02 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548348839; bh=j+q1NjqRgkdeBIHexjF7fhyzGhND/YanDXQAtXmShH8=;
        h=Date:From:To:Cc:Subject:From;
        b=kxFPPTsCKGVpV/dFvK2sq4XbpOx0Fagbfohc5WLH35v8b6VaLyUwZR29ffCI6u/HC
         DYz1SYKTos+UUUCUqGvWwyFdUyy8Zva7+rdEnK4+OtKprKOz176/cUS18ZOHr4wDLs
         t1/8j2qAElq4GWpt76d4CATFiY4VUflXC4WjulXlKT5VYSRggDsyv1CaqOZ3ZNyS/7
         zpLZhemxWgACaUL4EEqfQ5m7v6nY8Hb+LMTVHS8PRESAbVBqWzAMXGXy/zWrbMAvxf
         69JncV3ej/6hOSRea6PmkSXapKwemyFcgfdQvF5yfvKzOxicevyzKx22Wy2EqI/PeT
         NXR+14PEySacQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Jan 2019 16:53:58 +0000
From:   linuxgpletc@redchan.it
To:     Boris Lukashev <blukashev@sempervictus.com>
Cc:     Ivan Ivanov <qmastery16@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GRSec is vital to Linux security
Message-ID: <7bdd68b2223ea30da821b37a68d940a7@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is ample standing to sue. GRSec made it's "access agreement" 
public,
which included terms to prevent redistribution (if you redistribute, we
punish you). Which is a direct violation of the "no additional 
restrictive terms"
clause in the GPL.

Why won't anyone bring a copyright lawsuit?

Are they happy that GRSec gets to use their code, and prevent anyone 
from
freeing the derivative work? The whole point of the GPL is that 
derivative
works be under the same terms.

Bradly Spengler has violated this understanding, he thinks that his code
doesn't need to be under the same terms. The code which is simply a
derivative work of the linux kernel.

There is a valid, actionable case here.

Any of the programmers / copyright owners who's code he modified can sue 
him.
He is violating their terms of use of their software.
He is in the USA. It's not difficult. Just SUE.

Just because VMWare does things one doesn't like doesn't mean you cannot 
sue
Bradly Spengler.

Another thing is, the "Free software" legal "representation" is trash.
The SFConservancy was run for the longest time by a non-lawyer BKuhn.

He advised "clients" to WAIT it out! And then.. guess what they have 
waiting years?
No case because the statute of limitations had been passed.

That's how that baby-faced moron has "helped" the free software legal 
cause.

You guys need to hire real IP lawyers, not bullshit pretenders.
And if Bradly is making money, and enough of it, you might have profits 
you could target.

I kinda think that the "Free software legal" teams exist only to diffuse 
valid suits,
and stymie the guys who actually wrote the code and retained their 
copyrights.

Pure legal malpractice by any accounting.

On 2019-01-24 16:25, Boris Lukashev wrote:
> You've never heard of VMware, I take it? Its a proprietary half Linux
> which beats GPL suits with strong arm tactics and technicalities.
> Unlike grsec, they don't distribute any source, because it's proof of
> theft... Grsecs back port work is also public, since they're public
> upstream patches or mailing list patches, the GCC plugins are the real
> magic... Those aren't as GPL as the kernel, rap is patented, respectre
> likely will be as well. The critical code changes they need (per CPU
> PGD, for one) will not be accepted as Linus has "said so." Those code
> bits are out there...
> 
> Also, doesn't matter if their patch leaks for the most part (4.4 just
> did get leaked a few weeks back), as I wrote before, nobody really has
> the time or skill available to maintain at their level of quality...
> Linux might be free, but it's not something that should be run in
> production when there's data or resource at stake.
> 
> Is the thought process that they should open up their commercial
> stable code for free to all? Because RHEL has the same "don't leak"
> policy on RHEL sources too... VMware even goes so far as to blatantly
> claim not to use Linux. How about Google's internal Linux?
> 
> GPL is dead (has been for 20y), build the strongest defenses you can
> with whatever code you can get and prove, because your adversaries
> won't care about which license clause their tooling adheres to.
> 
> Boris Lukashev
> Systems Architect
> Semper Victus
> 
> -------- Original Message --------
> From: linuxgpletc@redchan.it
> Sent: Wednesday, January 23, 2019 05:35 PM
> To: bruce@perens.com
> Subject: Re: GRSec is vital to Linux security
> CC:
> moglen@columbia.edu,bkuhn@sfconservancy.org,compliance@sfconservancy.org,blukashev@sempervictus.com,tcallawa@redhat.com,torvalds@osdl.org
