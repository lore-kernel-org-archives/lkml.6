Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B7020C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfB0QRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:17:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfB0QRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:17:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A037FC0860DC;
        Wed, 27 Feb 2019 16:17:01 +0000 (UTC)
Received: from krava (unknown [10.40.205.100])
        by smtp.corp.redhat.com (Postfix) with SMTP id EF42D1001DE5;
        Wed, 27 Feb 2019 16:16:59 +0000 (UTC)
Date:   Wed, 27 Feb 2019 17:16:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: Support sample context in perf report
Message-ID: <20190227161658.GA2890@krava>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
 <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 27 Feb 2019 16:17:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:01:35AM -0800, Andi Kleen wrote:
> > > Also available in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> > 
> > your post is missing this patch, it's only in the branch:
> >   perf tools: Add utility function to fetch executable
> 
> Because Arnaldo already merged it. But the branch is still based

can't see it on his perf/core branch,
please paste me commit id

jirka

> on tip/perf/core, which doesn't have it yet.
> 
> -Andi
