Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4B217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="mNOdgOZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfB0QBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:01:39 -0500
Received: from one.firstfloor.org ([193.170.194.197]:48410 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0QBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:01:38 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 97D5D868ED; Wed, 27 Feb 2019 17:01:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1551283295;
        bh=mK+OGbQA/sU9curjiuk3bJgtOjdKTqz+Elw3mJpdigI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNOdgOZstenFODFFyp4mlUxZHctO+PaVPoVZpqjxZv6fN9/xvKYKowVxH6RSLySkU
         JOe0M+csP/ewjJ9fCtY/BvD0oaOtU08UG5OrHc7MB+sB3iDd1ld+JFsfm0TI1iytkJ
         hDuGrYLpW18Tcasw3KfJm4y+8VM/ImV+eFv0H3I4=
Date:   Wed, 27 Feb 2019 08:01:35 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: Support sample context in perf report
Message-ID: <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227111801.GA18893@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also available in
> > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> 
> your post is missing this patch, it's only in the branch:
>   perf tools: Add utility function to fetch executable

Because Arnaldo already merged it. But the branch is still based
on tip/perf/core, which doesn't have it yet.

-Andi
