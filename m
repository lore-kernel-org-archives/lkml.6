Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76293C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A57A216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A57A216E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeHOJz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:55:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeHOJz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:55:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7A87819700A;
        Wed, 15 Aug 2018 07:05:02 +0000 (UTC)
Received: from krava (unknown [10.43.17.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E3172156712;
        Wed, 15 Aug 2018 07:05:00 +0000 (UTC)
Date:   Wed, 15 Aug 2018 09:04:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
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
Message-ID: <20180815070459.GC3180@krava>
References: <20180808155548.510187543@goodmis.org>
 <20180810092137.GB14485@krava>
 <20180810090010.4537e14a@gandalf.local.home>
 <20180810131401.GB4162@krava>
 <20180810165706.GH5395@kernel.org>
 <20180814225435.370210d7@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814225435.370210d7@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 15 Aug 2018 07:05:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 15 Aug 2018 07:05:02 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:54:35PM -0400, Steven Rostedt wrote:
> On Fri, 10 Aug 2018 13:57:06 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > > Arnaldo takes care of that, but I guess pulling from branch is the prefered way  
> > 
> > I'll try pulling and building it automatically patch by patch,
> 
> Hi Arnaldo,
> 
> Were you able to take this? We have another patch series that's ready
> to go (it can wait till after the merge window though).

I see all that in Arnaldo's perf/core branch

jirka
