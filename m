Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E31C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D77420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D77420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbeHAUkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:40:31 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:49030 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeHAUkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:40:31 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fkwFJ-0003TR-5n; Wed, 01 Aug 2018 20:53:17 +0200
Date:   Wed, 1 Aug 2018 20:53:17 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     joe@perches.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_maintainer.pl and change of email
Message-ID: <20180801185317.ndyxtx4zwdkes2dh@angband.pl>
References: <CAKwvOdmuXvM0qF0zy15Q9yfCUNr+Kd4jDTcERWg1R-R2zDNuTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmuXvM0qF0zy15Q9yfCUNr+Kd4jDTcERWg1R-R2zDNuTA@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:36:23AM -0700, Nick Desaulniers wrote:
> It seems that get_maintainer.pl will make recommendations based on
> commit history to a file, but over time, people change emails that
> they commit from, then get_maintainer.pl recommends the possibly now
> invalid email address.
> 
> I feel like we should have a look up table / file like MAINTAINERS
> that tracks previous and new email addresses, which get_maintainer.pl
> would parse, that way we have a record of movement between committer
> email addresses allowing get_maintainer.pl to make more accurate
> recommendations.  Thoughts?

.mailmap

-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
