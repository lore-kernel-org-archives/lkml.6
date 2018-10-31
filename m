Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E66FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9641A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9641A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeKABew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:34:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33498 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeKABew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:34:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHtTN-0002mR-Rg; Wed, 31 Oct 2018 16:36:01 +0000
Date:   Wed, 31 Oct 2018 16:36:01 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] mount API series
Message-ID: <20181031163601.GR32577@ZenIV.linux.org.uk>
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
 <87a7mut9cm.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7mut9cm.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:38:17AM -0500, Eric W. Biederman wrote:
> A couple of bugs that I can see quickly.  Several of which I have
> previously reported:
> 
> - There is an easily triggered NULL pointer deference with open_tree
>   and mount propagation.

What the hell?  If the fixes that went in do not handle something,
especially if you have testcases, where the fuck have you been and
where _are_ those testcases, while we are at it?

Eric, this is bloody ridiculous - "I have an easily triggered NULL pointer
dereference in..., here it is" is hard to miscommunicate.  Sure, any such
needs to be fixed.  For crying out loud, that thing has not been hidden -
it sat in -next, it's been reposted several times...

I'm glad that you can see bugs.  How about _showing_ them?  Because I don't
see anything that would prevent this reply of yours from being posted
pretty much verbatim cycle after cycle, no matter what gets done.
