Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FD42070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="nvbRv484"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfADHHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:07:50 -0500
Received: from cock.li ([185.100.85.212]:38118 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfADHHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:07:50 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546585666; bh=YFqZtHSmtT4lc+5T62+ferjBVVUiXvt83m4VquVu6wY=;
        h=Date:From:To:Cc:Subject:From;
        b=nvbRv484K5t1RFML/Xd2jCDBo8j164M0YUkfWvFuU+g+5c0I7ZwgPWyf5JbHtqYlx
         SocfsBt5dRXF8iFuBHnOg0it6YvoTViLv3JMvixaXLoNJJMD67bS5adp+svUtnzVWW
         iWOn4kYf+vFXrmIiavezu6ybHgQF1uedaPnF5b7/7k9ihbKYEudko976SKV9RAOi0x
         QrkT2G8+IOVFrge+cR7T/BrjsLqfzsgwk4AUeoWkqUcGc7flaI7shb6VzzXXz9Ky/Q
         hHLmMhgjQFW/MFXP4/TTcHAg0zab6iD2JDfPXWB60SxO4pQSfHqB26yOtKQ2+Zo29C
         5t90z9VyNXtmg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jan 2019 07:07:45 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Cc:     freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, esr@thyrsus.com, gregkh@linuxfoundation.org,
        rms@gnu.org, bruce@perens.com, bkuhn@sfconservancy.org,
        editor@lwn.net, neil@brown.name, labbott@redhat.com,
        torvalds@linux-foundation.org, moglen@columbia.edu
Subject: The GPLv2 does not contain a no-revocation-by-grantor promise.
 (SFConservancy's Opinion Statement claiming otherwise is bullshit.)
Message-ID: <98624aa4b45666cf761c6ad86c06906f@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1016132

I also refuted the SFConservancy's "debunking" within 5 hours, on the 
LKML, of it's publishing its attempted defense of the GPLv2 (they were 
trying to misconstrue a clause in the GPLv2 as a promise by the grantor 
not to revoke, which it was not. A promise, even if it existed, the 
taker didn't pay any consideration for nor forego a legal right etc, so 
would even in that case be void), but everyone treats the issue as 
settled now.

> (Said now more simply than initially:)

> The clause you are referring to there is one that I have addressed 
> previously.

> 

> It states that if a licensee violates the license and suffers automatic 
> revocation, that licensees down the chain do not automatically in-turn 
> have their licenses revoked.

> 

> No more, no less.

> 

> That clause is being cited as a "GPLv2 no revocation by grantor 
> clause". It is not such a thing.

> 

> The SFConservancy etc never responded after I debunked their debunking.

> 

> There is no "no-backsies" clause in the GPLv2, and even if there was 
> you did not pay for it.

> 

> The basis is very simple: you do not get what you do not pay something 
> for.

> 

> YOU did not pay OWNER for his right to rescind. You didn't pay him 
> anything. You just use his property.

> 

> He can say you can't anymore.

However when I talk to other lawyers, professors at the school I went 
to, they take it as a given that a license absent an interest is 
revocable.

When I talked to a relative who has worked in the legal field for 
decades he has confirmed the same thing: even if there is a clause that 
says the grantor will never revoke: if you didn't pay for it that clause 
is likely void.

The GPLv2 doesn't even contain such a clause (v3 explicitly adds such a 
clause, aswell as a term-of-years the length of the copyright term), and 
linux is licensed under version 2, not 3.

And, again, most licensees did not pay those programmers, who still own 
the copyright to their code, anything what-so-ever, so there is no 
secured interest even if Linux was under version 3 (which it isn't).
