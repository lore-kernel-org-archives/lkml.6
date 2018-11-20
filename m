Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5725C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF9220671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF9220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeKTVOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:14:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46690 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbeKTVOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:14:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C7C80D;
        Tue, 20 Nov 2018 02:45:47 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 541223F575;
        Tue, 20 Nov 2018 02:45:47 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9A3B91AE0759; Tue, 20 Nov 2018 10:46:02 +0000 (GMT)
Date:   Tue, 20 Nov 2018 10:46:02 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Michael Halcrow <mhalcrow@google.com>,
        Jonathan Corbet <corbet@lwn.net>, torvalds@linux-foundation.org
Subject: Re: [PATCH] Documentation: Use "while" instead of "whilst"
Message-ID: <20181120104601.GB24824@arm.com>
References: <1542625365-21886-1-git-send-email-will.deacon@arm.com>
 <87in0sf35w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in0sf35w.fsf@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Linus]

On Tue, Nov 20, 2018 at 12:34:35PM +0200, Jani Nikula wrote:
> On Mon, 19 Nov 2018, Will Deacon <will.deacon@arm.com> wrote:
> > Whilst making an unrelated change to some Documentation, Linus sayeth:
> 
> Reference?

This was on the security list where we were dealing with something else, so
I'm afraid that it's not archived.

> >   | Afaik, even in Britain, "whilst" is unusual and considered more
> >   | formal, and "while" is the common word.
> >   |
> >   | [...]
> >   |
> >   | Can we just admit that we work with computers, and we don't need to
> >   | use þe eald Englisc spelling of words that most of the world never
> >   | uses?
> >
> > dictionary.com refers to the word as "Chiefly British", which is
> > probably an undesirable attribute for technical documentation.
> >
> > Replace all occurrences under Documentation/ with "while".
> 
> It's an innocent enough change I guess... but seriously? Do we now need
> a documentation style guide too...? Should we block an otherwise good
> patch with "whilst" in it from now on?

No, I don't think either of those two ideas are being proposed here.

"Whilst" feels natural to me, but apparently it comes across as strange
and antiquated to others. The dictionary confirms that it's not in
widespread use, so I don't see the problem with making the Documentation
clearer by using words that are more easily understood by the English-
speaking world (and I suspect it helps the poor souls that try to translate
this stuff as well).

> Personally, I'd accept that our documentation is a hodge podge of
> regional dialects, written by native and non-native speakers with
> incredibly diverse backgrounds and different levels of education and
> experience. If we can keep the documentation understandable and mostly
> typo free, I'd be happy. Even good grammar seems to be a stretch
> goal... ;)

This patch is definitely a drop in the ocean, but it also only took about
5 seconds to write using sed. If it stops a handful of people reading a
sentence twice, then it's a win imo.

Will
