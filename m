Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4DE21850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="ezYZsg90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfAWSTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:19:16 -0500
Received: from cock.li ([185.100.85.212]:52262 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfAWSTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:19:15 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548267552; bh=m6Hkaa0uw9ENznnd+WQDlT/SHQLXPafqcsmxsn2wJh8=;
        h=Date:From:To:Subject:From;
        b=ezYZsg90uq78XFad0r4guae7GCGHbUp9zglZWMqvqLQeg3TqfOBV8lbcb6CsYp7nI
         vUdMuKO7AGpGmXwAq9XjP5asSiSQo3CEk7KJQFc+OkcVl7g+lHPxrCewYSwDk04Fnu
         lVBh5toJQRaU6RymjgVAUb1sLadjQtX+zYlXmp6ksPe1Zpsy5ZOR14tzpZG9GOz/Hp
         pJpXr0jKyorKGiA2kq3EhSrvkujuT6bIcy/2YiaOTt1HKKVSx5YUAea0H1ideW73iB
         spkmGgc8gPlc5jzjnGsgFWGMnHiOFyvHfuyoNPsq8ZSd+t65D2UsvYxrsLKOGu6Vlk
         S6A9zWJlY8AZA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 18:19:12 +0000
From:   linuxgpletc@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: GRSec is vital to Linux security
Message-ID: <fe8a4e103943d671ff0ce2c4f09609f9@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two iron laws when it comes to the linux-kernel and it's
facing towards the larger world.

1) The grsecurity-pax patch is absolutely vital if one wishes to not be
hacked by chinese(TM). (And has been vital for the last 15+ years.)

2) GRSecurity is _blatantly_ violating the GPL by adding additional
restrictive terms.


Other things we have come to know is that
A) Linus is a poor judge of quality, or just out of touch.

To say that GRSecurity is garbage?
No linus, it's just the layer covering up the shit heap that the
linux-kernel is when it comes to exploitable code.
That stench you smell is not that nice grassy cover over the garbage
tip, it is what is below, what that top is holding down.

You know... I would expect the things that Linus said about GRSecurity
from a white woman... I would expect that. Knowing nothing, spouting
bullshit, destroying lives. That's their _thing_.

But from a man?

Well, goes to show you. White men ain't men. Best they are is 40 year
old bois. Faggots to say for short in American parlance.

Same reason they won't hold it down when a bunch of fucking cunts CoC
them. You build the whole edifice, then you let a bunch of do-nothing
white women rule over the thing you built and you.

But hey, that's Linux!
