Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5498FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9CE2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="GqzG4yVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbeL0U57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:57:59 -0500
Received: from cock.li ([185.100.85.212]:51116 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbeL0U56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:57:58 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1545944275; bh=PDArw3eCKrgBPn3Du2da92DBo+ZezoXuDe42llF0hQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GqzG4yVjyvoaG/mriKkLP4VARTnTgJZ9LVYGHQM9lsyp/z1O2Pie+bosmCnir7JPS
         c6IpDx2wRsKvvKJd6l4PyhFNAPWjxN+PgbmQvquCOylNF/8qYf9y/j7tWlY8PPWLV1
         3fDvfFpm2xM7HsiJsXMhFf11OMt4qawR8oLhlTuqLT/9qxeVo8e1MvFZuFeS56xt6R
         Y3xSdkQJkw/JbHrke/BpfXAI23tGc7v05tn+YrIg78SBRnbDvzaM3ie94XWiEmAVNE
         gj3zxMygHArMBE2mdoqtw8IMhEOhuKHqVmDKC+u+LyiDRZzBTcgsJFmMKPseWslvyy
         OSIL7vcHNGzRA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Dec 2018 20:57:55 +0000
From:   vsnsdualce@memeware.net
To:     Paul Stuffins <mail@paulstuffins.me.uk>
Cc:     owner-misc@openbsd.org,
        OpenBSD general usage list <misc@openbsd.org>,
        Raul Miller <rauldmiller@gmail.com>,
        linux-kernel@vger.kernel.org, freebsd-women@freebsd.org,
        freebsd-chat@freebsd.org, visionsofalice@redchan.it,
        owner-freebsd-chat@freebsd.org
Subject: Re: Why is no one discussing this anymore?
In-Reply-To: <CAKtRYpcHnGW9ftu7UaimH6RejgezeqNZW+rFkEm_GdYdGuXO5A@mail.gmail.com>
References: <d1a036ae6ecc7614d969e841ee2e9d2f@memeware.net>
 <CAKtRYpcHnGW9ftu7UaimH6RejgezeqNZW+rFkEm_GdYdGuXO5A@mail.gmail.com>
Message-ID: <f11c56360b48b5c4a2a1ae60fdc2f2f8@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting quietly for two months for Eben Moglen's preliminary write-up 
(which I was to be sent to "correct") got me no-where. Every seems to 
have concluded that the issue is settled since there was no more public 
discussion.

All the "other side" said was "nuh-uh" and "you're not a lawyer" (false: 
I am) and "you deserve to be in prison , isn't practicing law without a 
license a crime!" (I have a license), and "I'm sure RMS would have made 
sure the license was not revocable" (he required everyone to sign over 
their copyright to his foundation... guess why...).

Along with "This Artistic License Case decided the AL was not a 
contract, it was simply a copyright license!! SO THERE!!" (AL is not the 
GPL... but... the finding in that case helps me, why are you citing 
it?).

(They wisely did not cite the printer driver case where the court looked 
at the offer to do (paying) business and decided that their was an offer 
and acceptance based on that other additional writing... since that one 
isn't on point at all except for the fact that one of the options in 
that writing was a choice of a GPL licensed work if you didn't want to 
pay a commercial fee. (The contract there was the other writing giving 
the option: Pay and get more rights, don't pay and here's the GPL), so 
at-least there's that.)

Being nice did nothing but harm the case of the truth in the eyes of the 
people however.

The guys on the DNG list (Steve Litt I believe) are the ones that want 
me jailed...

On 2018-12-27 20:37, Paul Stuffins wrote:
>> <snip>Are you idiots aware <snip>
> Insulting people is not the right way to get your point across!
> _______________________________________________
> freebsd-chat@freebsd.org mailing list
> https://lists.freebsd.org/mailman/listinfo/freebsd-chat
> To unsubscribe, send any mail to "freebsd-chat-unsubscribe@freebsd.org"
