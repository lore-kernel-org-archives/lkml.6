Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40177ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A8520C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=snajpa.net header.i=@snajpa.net header.b="w8NhzWG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A8520C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=snajpa.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeIRHHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:07:18 -0400
Received: from mail.snajpa.net ([185.8.165.152]:37656 "EHLO mail.snajpa.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbeIRHHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:07:17 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 03:07:16 EDT
Received: from authenticated-user (unknown [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.snajpa.net (Postfix) with ESMTPSA id 9DCA7236026;
        Tue, 18 Sep 2018 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=snajpa.net; s=mail;
        t=1537234238; bh=qhRK4PSkV3dLLEFV3EQ7S3DDwtkwyupnZJ+KIYKiGsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w8NhzWG82cIG4Z6U0M9F39ADC2M/mhLc7X0qpB5ZlO2TwWLGEzWsdi6swkqPcNbJJ
         j9QA54ucIxDlmfprnuL75yHscdXI5T3HnJ8+vsMqAeEl4TmdbYg4I268V6BJj6luTK
         xT6b43UrP1LtkFZlOeLbYUB1D0ssOli3nHAkxZrM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Sep 2018 03:30:38 +0200
From:   Pavel Snajdr <snajpa@snajpa.net>
To:     michaeljpwoods@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
In-Reply-To: <93424bb0-180e-71ff-f0d6-602caa2d5883@gmail.com>
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
 <93424bb0-180e-71ff-f0d6-602caa2d5883@gmail.com>
Message-ID: <260205ec45d097fb037f71ae42e7b69e@snajpa.net>
X-Sender: snajpa@snajpa.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-17 23:09, Michael Woods wrote:
> 
> The Code of Conflict was perfectly fine. Whomever convinced you to add
> the Code of Conduct was convincing you to give control over to a
> social justice initiative that has no interest in the kernel's core
> function or reason for existence.
> 

Hi Michael,

and how about if we viewed the new Code of Conduct as about the same 
thing as BitKeeper was for the development process?

It was not perfect, but wass *something* for a start. And I believe that 
Linus will probably come back with a Git of CoC, or something in that 
fasion.

I've been always looking up to the guys leading major community projects 
and how they go about things - and I think, that most of the bad 
fall-out in them is caused by insanely high expectations - firstly from 
the leader themselves, and secondly from others as well.

/snajpa

P.S.: this is my first "contribution" to LKML, I hope to start sending 
up some of my very prototype work soon for discussion, regarding the 
Cgroup subsystem ID allocation & limits - and subsequently, start a 
discussion about getting Linux to do better OS-level containers (ie. 
those, which have a "look&feel of a real VM" from the admin's 
perspective).

We started our organization (vpsFree.org) on top of OpenVZ patch set and 
are now working to get vanilla up to the task of replacing the venerable 
2.6.32-based OpenVZ 6 Linux-like thing. The new Code of Conduct is a 
guarantee for us, that we won't be laughed out of the room  and that our 
members won't be demotivated to contribute upstream - if we can all 
agree to be nice on each other; yet we still need you guys to tell us, 
when we're trying stupid things or going about things the wrong way, in 
some way that we will notice & can learn from.
If I understand the context correctly, the previous "regime" could be 
the culprit, at least to some extent, why still don't have the VM 
look&feel-having containers with vanilla. So I'm just really trying to 
say, that I'm really excited about the signal this change has sent.

