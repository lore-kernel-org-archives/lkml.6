Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3118CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E257F20874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="wp8PdSqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbeL1RWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:22:08 -0500
Received: from cock.li ([185.100.85.212]:45826 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbeL1RWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:22:07 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546017725; bh=DL4aeBvENLYqOgnB5MUOQKI0mrh0rS2+ngUlWFUMbP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wp8PdSqkL+D6uGliPvKXIiDuEEevKq9F4ZGnZsCb7dQON0VMgWzBQh1aXC7kjCYIu
         eu4APjs363mxkgi65xXQ7CdqTbV4rPmJM9SyMdIObvapp7Kgh4UJs84FxQrmjQIswj
         e+yuCWVWfv4zdEWdXBzmNSn4d+8k09WZl2+0XW5TRbGEGNyDMqfY7lwqYwZex4mvHP
         1YuSev7CiKYprF963ZkkwU/gb4rjvsQxXWfgulxCRGT0lyYayWCHmMMyL+wr0K+LNc
         +vS+bXZpGKpbBwVNaBS7i1wWEdB9HTeG78vXAgwzf3Sw6SVAFL9JdDoBkOv6D1bjZb
         8+zKBeZpniD9Q==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 17:22:04 +0000
From:   vsnsdualce@memeware.net
To:     leo_tck@volny.cz
Cc:     Christopher Turkel <turkel.christopher@gmail.com>,
        misc@openbsd.org, owner-misc@openbsd.org,
        linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org
Subject: Re: FU: RE: Why is no one discussing this anymore?
In-Reply-To: <20181227235419.27A8ACE1@volny.cz>
References: <d1a036ae6ecc7614d969e841ee2e9d2f@memeware.net>
 000000003ad1004b89dc0167e16e <20181227235419.27A8ACE1@volny.cz>
Message-ID: <4fca34d1b2c8a7f67c780b5df31f6d58@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was addressing OpenBSD as-well, I chose the lists to CC to: linux 
lists and BSD, since the underlying concerns are the same.

It took slightly longer to find the appropriate openbsd list, infact, so 
you definitely weren't CC'd by accident.

On 2018-12-27 22:54, leo_tck@volny.cz wrote:
> zeur here.
> 
> I now[0] see that a whole bunch of lists were Cc'd, and while I'm not
> sorry for not preserving the Ccs, I realize that you might not have 
> been
> addressing us, misc@OpenBSD.org.
> 
> I still think my point holds, though. This should be a matter of great
> concern for OpenBSD, like it is to just about every other project
> relying on licensed code, "open" or not.
> 
>         --zeur.
> 
> [0] post-coffee-intake =)
> 
>> This whole discussion is best served elsewhere.
