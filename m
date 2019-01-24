Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB41C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627062184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="hxju/3My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfAXQkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:40:42 -0500
Received: from cock.li ([185.100.85.212]:36038 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfAXQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:40:42 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548348038; bh=nr56L68jt/bHcgtSOj4u1H0Y+1cbVJA6eI+u4YFivH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hxju/3Myygw8xm0QfhCmFDO5tafnwttQO2QEMefxHF/TCwJ1ImWrmvZuOMwagitCc
         atRZJuvVeXikdGmd5cB8+BioOpU3aJ0fNHwy9rZihsXdFFzB6HFDfg5+eHXRXWMNOs
         SQqRPAApJU1g/i/exed7TQHqXT1AgZfRRDhBpDeN5bdtrBusXqdG8YbX2wNvwmbhI/
         M3QV7l/t4vD6ZaSKPoCrg0FVbt3IStk246T7XONB03d5pZPMsT8N0dtLSRnJKMcMpB
         XkyTbJ4WPdCZOPv5ApcXU3TJmuivRKeGSid7cNt7Kr+EARkD0MkDp9qkRJghFIFlms
         tbBojGOz4FA8w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Jan 2019 16:40:37 +0000
From:   linuxgpletc@redchan.it
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Ivan Ivanov <qmastery16@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gentoo-user@lists.gentoo.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, rms@gnu.org
Subject: Fwd: Re: GRSec is vital to Linux security
In-Reply-To: <3efc6268-747d-0841-4249-5804fa9095ca@metux.net>
References: <fe8a4e103943d671ff0ce2c4f09609f9@redchan.it>
 <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
 <3efc6268-747d-0841-4249-5804fa9095ca@metux.net>
Message-ID: <fefdf0dc5d84105b5877b135a822a52a@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-------- Original Message --------
Subject: Re: GRSec is vital to Linux security
Date: 2019-01-24 16:25
 From: Boris Lukashev <blukashev@sempervictus.com>
To: linuxgpletc@redchan.it

You've never heard of VMware, I take it? Its a proprietary half Linux
which beats GPL suits with strong arm tactics and technicalities. Unlike
grsec, they don't distribute any source, because it's proof of theft...
Grsecs back port work is also public, since they're public upstream
patches or mailing list patches, the GCC plugins are the real magic...
Those aren't as GPL as the kernel, rap is patented, respectre likely
will be as well. The critical code changes they need (per CPU PGD, for
one) will not be accepted as Linus has "said so." Those code bits are
out there...

Also, doesn't matter if their patch leaks for the most part (4.4 just
did get leaked a few weeks back), as I wrote before, nobody really has
the time or skill available to maintain at their level of quality...
Linux might be free, but it's not something that should be run in
production when there's data or resource at stake.

Is the thought process that they should open up their commercial stable
code for free to all? Because RHEL has the same "don't leak" policy on
RHEL sources too... VMware even goes so far as to blatantly claim not to
use Linux. How about Google's internal Linux?

GPL is dead (has been for 20y), build the strongest defenses you can
with whatever code you can get and prove, because your adversaries won't
care about which license clause their tooling adheres to.

Boris Lukashev
Systems Architect
Semper Victus

-------- Original Message --------
 From: linuxgpletc@redchan.it
Sent: Wednesday, January 23, 2019 05:35 PM
To: bruce@perens.com
Subject: Re: GRSec is vital to Linux security
CC:
moglen@columbia.edu,bkuhn@sfconservancy.org,compliance@sfconservancy.org,blukashev@sempervictus.com,tcallawa@redhat.com,torvalds@osdl.org
