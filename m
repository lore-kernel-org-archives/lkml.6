Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4A6ECDFDF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C720835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="guq/5jXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827C720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJJBqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:46:53 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:45122 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeJJBqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:46:50 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BDF0D405F6;
        Tue,  9 Oct 2018 20:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received; s=mail20150812; t=1539109712; bh=5nqLz1UDgm
        fJxGryT86h8lM4B8ngIvDnxkckVijhEuI=; b=guq/5jXYsP99hkkSAc3D1vj4eH
        D9udeu56tcImDLOWKr74Vdwa0cY3YTwAVthPFf2AdDL0XQyXamhhgOmR0l3OZQL5
        h8mi0drbCR+oWKN7r9T8AQAXOI4v0gMHHbljeb4niAmb5+TJYQbZ2KCFSQpwLwvV
        T+QQUpj0kpvF1jy4wAqbWuzPqwZipNzfFIjFLkExas9UOzH92k8l9/g2EmzDqAhw
        AYx9IcLivB/2fJ/MOZW+BlWzvlKCfbRqJrKjcuey/oRh6al2hBgY/U0ZX/2cWWGA
        3fqJPzCD+nJve9VFtvvCgoSWB6I9Ty+1S+bOBnFn+gviPcnnm7OSmgqu88CA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id uqIpUB_H9GV2; Tue,  9 Oct 2018 20:28:32 +0200 (CEST)
From:   Rainer Fiebig <jrf@mailbox.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     james.bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email addresses
Date:   Tue, 09 Oct 2018 20:29:24 +0200
Message-ID: <1718828.OxLgMoHbrt@siriux>
In-Reply-To: <20181008152043.GA5796@localhost>
References: <1538861738.4088.5.camel@HansenPartnership.com> <1538861799.4088.6.camel@HansenPartnership.com> <20181008152043.GA5796@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 8. Oktober 2018, 08:20:44 schrieb Josh Triplett:
> On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley wrote:
> > The current code of conduct has an ambiguity in the it considers publishing
> > private information such as email addresses unacceptable behaviour.  Since
> > the Linux kernel collects and publishes email addresses as part of the patch
> > process, add an exception clause for email addresses ordinarily collected by
> > the project to correct this ambiguity.
> 
> Upstream has now adopted a FAQ, which addresses this and many other
> questions. See https://www.contributor-covenant.org/faq .
> 
> Might I suggest adding that link to the bottom of the document, instead?
> (And then, optionally, submitting entries for that FAQ.)
> 

The Code of Conflict has 28 lines, including the heading. 
The Code of Conduct has 81 lines, including the heading. And it needs a FAQ. Hm.

Here's a one-line Code of Conduct from Kant:
"Act only according to that maxim whereby you can, at the same time, will that it should become a universal law."[1]

Put another way: 
Don't do to others what you don't want others to do to you.

Simple beats complex. No FAQ necessary, imo.


Regards!


Rainer Fiebig


[1] https://en.wikipedia.org/wiki/Immanuel_Kant

-- 
The truth always turns out to be simpler than you thought.
Richard Feynman
