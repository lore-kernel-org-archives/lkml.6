Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B1121019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="t+LGHX3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfAAUQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 15:16:21 -0500
Received: from cock.li ([185.100.85.212]:44220 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfAAUQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 15:16:20 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546373777; bh=zaJQ2FgZ8mqejKJ/tuvAYL9DELeGKI2UKSMIpxVia0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t+LGHX3lgmCqpJ+/W8TUnqjq32aeNIhEPw36F8IV5ktf59dJyYnzInwXDd0isW7w9
         XKakBkAaK6RmT/S7om1NdUn78dzJxBf9ESv8zDQHahC/WgwnhVArJVYlOJAgouI7wZ
         y8RHNy9m7MdVcFjPiUfsmt/FDODYyqej8hgoIMiGclrXdFjEw4a7omXlZGm9y5pXNr
         ER24cDY0N0P+VHJWddYpPkmMRZzQ+u9oVRwi3tgLuCte1NGxxWK2vB338mWNiM8T4M
         5cHkjLUszuldEovUJf37tKGPc8llsk9tSyoIGPdvN83baau/WH/arG4CnvhAWVf3+K
         RwkfGSIwZHwgA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jan 2019 20:16:16 +0000
From:   vsnsdualce@memeware.net
To:     william@techservsys.com,
        "Ubuntu user technical support, not for general discussions" 
        <ubuntu-users@lists.ubuntu.com>
Cc:     misc@openbsd.org, gentoo-user@lists.gentoo.org,
        linux-kernel@vger.kernel.org
Subject: Re: CoC loving Linux programmers swear the GPLv2 is irrevocable. They
 are wrong. (As are the women they wish to empower).
In-Reply-To: <q0fn2v$q4j$1@blaine.gmane.org>
References: <a6f3c4d6d8c85f1db2e84682b8305339@memeware.net>
 <q0fn2v$q4j$1@blaine.gmane.org>
Message-ID: <604e57a471c4ce5ecca308125e9bb25b@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What promise did you rely upon?

It is the right of the property owner to revoke.
You payed the property owner (Linux Programmer 721) nothing for his 
code.

He never promised you that he would forgo his right to revoke
(Read the GPLv2, there is no mention of not revoking the license. 
Something which the GPLv3 adds).
(The SFConservancy's artistic interpretations were debunked 5 hours 
after publication)

Additionally you did not pay the LICENSOR for this forbearance.
It is not reasonable for you to rely on a promise that was never made, 
and a promise that you never payed the owner for.

In short: you are wrong,
and you and others are attempting to convert the property of the 
copyright owners to your own property, essentially.

(Your claim is that another's property can be taken from him because to 
do otherwise would be inconvenient to the people that are committed to 
committing the taking.)


On 2019-01-01 12:42, william drescher wrote:
> "Consideration" can be in form of "
> detrimental reliance." That means that you relied on the license and
> that reliance cost you something.
> 
> So if you spend money to pay programmers or if you spend time writing
> programs based on the license you have paid for the license.
