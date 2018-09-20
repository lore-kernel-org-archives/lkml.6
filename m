Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15197C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B444C21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="lj46TnEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B444C21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbeITPMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:12:19 -0400
Received: from cock.li ([185.100.85.212]:40396 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeITPMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:12:19 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537435784; bh=M/bscz/46iS2yInXVOpnXAgkfTApS+vS3ToRlCjoJpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lj46TnEXDNrK64ZlM3GeVYNOQBcH/heY3NDoXlyFCbrjkTZNLpPQbRcP062bivQuz
         EhYezXn/PSHiT5x7iDNJjygFTPNAT6OQ6K952YEdrzvNPoupIk1TUcUtOI2j/fImtm
         o28wZI5rB3j2DrAMXIF+Ddqebn9yQS8PvHQwSXU+1XOZpssf5c/rvt9lV/CTQTleGq
         0g8LAoi5Qg+x2if7qWZpir1kMKcZCHqT9XhpNywFcGPfS4gu3mg9RJ+5CJEiX+Ftu+
         m6OYuOlYV9KqIlEwUXonH6XKVjGpE6Tu75SGwh8ZoQpQ9Jx0AdVVJpG+FnxFfhtKKP
         4wxCksUpgTlkg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 09:29:43 +0000
From:   unconditionedwitness@redchan.it
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
In-Reply-To: <20180920041846.GA4418@1wt.eu>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <20180920041846.GA4418@1wt.eu>
Message-ID: <ecd49658734e29c440c3345237fb0693@redchan.it>
X-Sender: unconditionedwitness@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code of Conduct: Those Ejected should rescind their license grant.

The grant is not supported by consideration.
It dispenses only largess, and asks for no recompense.
It is a bare license.
Thus it can be revoked by the grantor at any time.
His act of grace bestowed,  and his act of propriety can rescind.

The free software world is held up muchly by a gentleman's agreement.
The agreement is that we shall take mutually beneficial actions, vis a 
vis the field of software engineering, to increase the net freedom 
available to all.

It is not so much held up by law, regardless of what the lay programmers 
and users of programmers would imagine to believe.

To turn one's contributions around as a weapon against the contributor:
to tell him he must not say this or that, he must not act this or that 
way,
lest he be barred from his hobby; let he be barred from freely giving
dispensation, is an abhorrent abuse of his magnanimity

Now this gentleman's agreement is being, or has been shattered.
You will find that the law has no supports to bind him;
but many to fell the ungrateful who saw themselves the inviolate 
annuitants of his altruism.

Bare licenses are revocable at will. They always have been.
Those who are thrown out of the "Linux Kernel Community" in punishment 
for not obeying this CoC, who's past contributions count for nothing in 
the face of those who will throughout the ages to control men in all 
things; for not "behaving properly" here or there, within their public 
or private life; for not bending the knee to the Anglo-American 
religion, should absolutely rescind the grant they have dispensed.
They are well within their rights to do so, and hostile action must be 
met with the same and worse in response.
