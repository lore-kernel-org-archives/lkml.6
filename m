Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1865CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A1C20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeIDHIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:35 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58133 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeIDHIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:34 -0400
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id AFC09E0002;
        Tue,  4 Sep 2018 02:45:37 +0000 (UTC)
Date:   Mon, 3 Sep 2018 19:45:35 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Henrik Austad <henrik@austad.us>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Message-ID: <20180904024534.GA29802@localhost>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Trimming to author, linux-doc, and LKML for response.]

On Tue, Sep 04, 2018 at 12:15:23AM +0200, Henrik Austad wrote:
> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise
> anyone what Documentation/sched/sched-design-CFS.txt covers)
> 
> A few years back it was mentioned that these files were no longer really
> needed, and they have since then grown further out of date, so perhaps
> it is time to just throw them out.
[...]
> As a starting point, remove all index-files and references to 00-INDEX and
> see where the discussion is going.

Yes please.

I was *briefly* tempted, reading through the files, to suggest ensuring
that the one-line descriptions from the 00-INDEX files end up in the
documents themselves, but the more I think about it, I don't think even
that is worth anyone's time to do.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>
