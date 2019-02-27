Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9531DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608E520C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="OCtTrHjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfB0R35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:29:57 -0500
Received: from one.firstfloor.org ([193.170.194.197]:52240 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0R34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:29:56 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id AB6EF868ED; Wed, 27 Feb 2019 18:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1551288594;
        bh=9v+DQ30tWezO7q1rCiymgMZ5TcLFIKMPHb4eYvoGhPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCtTrHjD6uRWSXgwF4V6xjXmU9uEdswv7aMY+g0TJpHut0S9YAHGwMNGVBPSeQTl2
         ASVxNKmz4T1CDlWaYCKZFewxCEQXgM9eM/wv4HnQuzOqDvuNYiEdT7FbnDMEcMKCgp
         bS97nZEeeJNE7PSjhtiD5nhbTas0hDl5BrMFJRCg=
Date:   Wed, 27 Feb 2019 09:29:54 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: Support sample context in perf report
Message-ID: <20190227172954.kithpbfndc5jjg33@two.firstfloor.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
 <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
 <20190227161658.GA2890@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227161658.GA2890@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:16:59PM +0100, Jiri Olsa wrote:
> On Wed, Feb 27, 2019 at 08:01:35AM -0800, Andi Kleen wrote:
> > > > Also available in
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> > > 
> > > your post is missing this patch, it's only in the branch:
> > >   perf tools: Add utility function to fetch executable
> > 
> > Because Arnaldo already merged it. But the branch is still based
> 
> can't see it on his perf/core branch,
> please paste me commit id

I don't know the commit id, but there was an email from him earlier
that said "applied". Maybe he hasn't pushed yet.

-Andi
