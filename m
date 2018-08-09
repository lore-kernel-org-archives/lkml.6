Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD34C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D821AA7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1D821AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeHIKft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:35:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbeHIKft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCF314022905;
        Thu,  9 Aug 2018 08:12:07 +0000 (UTC)
Received: from krava (unknown [10.40.205.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id 979D821568A3;
        Thu,  9 Aug 2018 08:12:03 +0000 (UTC)
Date:   Thu, 9 Aug 2018 10:12:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH 00/24] tools lib traceevent: Rename pevent to tep
 for preparation for library
Message-ID: <20180809081202.GC19243@krava>
References: <20180808155548.510187543@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808155548.510187543@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 08:12:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 08:12:07 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:55:48AM -0400, Steven Rostedt wrote:
> Having libtraceevent turn into a proper library has long been asked for.
> I never had time to do it before. Luckily, Tzvetomir was able to spend
> the time to start the preparation. The first thing that needs to be done
> is to handle namespace collisions. "pevent" was the prefix I chose, but
> many people were displeased by it, as it didn't express what the functions
> were used for. After discussing with many people at many conferences
> I've come up with "tep", which means "Trace Event Parser". Please don't
> question this. The bikeshed has been painted and I'm not changing the
> color.

nah... now when I see it 'te' actualy sounds better ;)))) just kidding,
great we finaly got to this.. is there a branch somewhere with this?

thanks,
jirka
