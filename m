Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D1024024
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D1024024
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbeGEM14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:27:56 -0400
Received: from foss.arm.com ([217.140.101.70]:48894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753777AbeGEM1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:27:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB5C47A9;
        Thu,  5 Jul 2018 05:27:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204913F2EA;
        Thu,  5 Jul 2018 05:27:52 -0700 (PDT)
Date:   Thu, 5 Jul 2018 13:27:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tobias Tefke <tobias.tefke@gmail.com>
Cc:     tobias.tefke@tutanota.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: events: use correct articles in comments
Message-ID: <20180705122750.2vsgjy35cfri2665@lakrids.cambridge.arm.com>
References: <20180705112756.1663-1-tobias.tefke@tutanota.com>
 <20180705122608.h7j5wo7wd4ndw2jm@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705122608.h7j5wo7wd4ndw2jm@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 01:26:08PM +0100, Mark Rutland wrote:
> On Thu, Jul 05, 2018 at 01:27:56PM +0200, Tobias Tefke wrote:
> > These words are pronounced (and start) with a vowel sound.
> > Therefore the article we use has to be 'an' instead of 'a'.
> > 
> > Signed-off-by: Tobias Tefke <tobias.tefke@tutanota.com>
> 
> To clarify Alexander's reply, there's some guidance on writing commit
> messages in section 2 of:
> 
> Documentation/process/submitting-patches.rst
> 
> The basic idea is that the commit message should make sense on its own,
> even if you can't see the diff. Describe the problem first, any
> caveats, then the solution taken (in the imperative tense).
> 
> e.g. the above could be:
> 
> ----
> Some of the comments in the kernel events code use articles incorrectly,
> 'a' for words beginning with a vowel sound, where 'an' should be used.

Whoops, dropped a word here. That should say:

Some of the comments in the kernel events code use articles incorrectly,
using 'a' for words beginning with a vowel sound, where 'an' should be
used.

Mark.
