Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D1C46464
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB7B20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s8TRRTPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB7B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeJKSJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:09:12 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:44708 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeJKSJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:09:12 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 16A8340719;
        Thu, 11 Oct 2018 12:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received; s=mail20150812; t=1539254545; bh=dYOdwvUrrd
        GOwCyibk+kKTAadUhocrlWJ/K9UWVMSpY=; b=s8TRRTPQJKNpurYyx7gyoxWAJv
        4sEfqSznsA/wUZXeiLhM5VEpIlDKTWKBIoqEDPNnMO9QsUBpS3qxGm9fdFVLBQk0
        Qy+NYTrvI3jeS/+A2vKFVOiRT7x6j9O0snXMrupt30gYc8Alh3DzDYX4nXHPDp27
        IkZ6kvkOgkswCQjATNhYh+m1Wop+ji3qRwjO754xBina2ShgNFQn39Z3b44ur4nl
        7NZqGNTBD+bhBqh+4sAaPYAAkAeiZdfH7rZTRdozDCnlhZsI+mhrbpZtNoNxqB9W
        8CageyoCupGsdH/Oqw2fzMb2Jr29gTcVoNhqu5LRH9AZl9LRDdpFfpmgu+hA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id Y5e_7EHg9Wa4; Thu, 11 Oct 2018 12:42:25 +0200 (CEST)
From:   Rainer Fiebig <jrf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] code of conduct fixes
Date:   Thu, 11 Oct 2018 12:43:45 +0200
Message-ID: <8067297.9B3jLnrCay@siriux>
In-Reply-To: <87efcxtmhf.fsf@xmission.com>
References: <1539202053.12644.8.camel@HansenPartnership.com> <87efcxtmhf.fsf@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Oktober 2018, 18:23:24 schrieb Eric W. Biederman:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> 
> > Resend to show accumulated tags and also to add a third patch listing
> > the TAB as the reporting point as a few people seem to want.  If it
> > gets the same level of support, I'll send it in with the other two.
> 
> 
> There is also:
> 
> > Our Responsibilities
> > ====================
> > 
> > Maintainers are responsible for clarifying the standards of acceptable behavior
> > and are expected to take appropriate and fair corrective action in response to
> > any instances of unacceptable behavior.
> > 
> > Maintainers have the right and responsibility to remove, edit, or reject
> > comments, commits, code, wiki edits, issues, and other contributions that are
> > not aligned to this Code of Conduct, or to ban temporarily or permanently any
> > contributor for other behaviors that they deem inappropriate, threatening,
> > offensive, or harmful.
> 
> Which is very problematic.
> a) In append only logs like git we can not edit history.
>    Making it a mainters responsibility to edit the history, to do the
>    impossible is a problem.
> 
> b) There are no responsibilities of for people who are not Maintainers.
>    That is another problem.
> 

As a reminder/clarification one could introduce a line like this:


Responsibilities
================

All participants are responsible for complying with this Code of Conduct.

Maintainers are responsible for[...]


> c) The entire tone of the reponsibilities section is out of line with a
>    community where there are no enforcement powers only the power to
>    accept or not accept a patch.  Only the power to persuade not to
>    enforce.
> 
> Overall in the discussions I have heard people talking about persuading,
> educating, and not feeding trolls.   Nowhere have I heard people talking
> about policing the community which I understand that responsiblity
> section to be talking about.
> 

I think Eward Cree aired this concerns early on in the discussion:
https://lkml.org/lkml/2018/9/19/234

> Increasingly I am getting the feeling that this document does not the
> linux development community.  Perhaps a revert and trying to come up
> with better language from scratch would be better.
[...]


+1.
Nobody would get hurt or loose face by doing so. On the contrary.

My suggestion would be:
- revert the patch
- discuss the matter (and the way it was introduced) at least at the next MS
- setup a task-force to come up with a new proposal
- discuss the proposal
- make corrections, if necessary
- implement it

IMO there's no need to rush things in a matter so important for the future 
of the project.


So long!

Rainer Fiebig


-- 
The truth always turns out to be simpler than you thought.
Richard Feynman
