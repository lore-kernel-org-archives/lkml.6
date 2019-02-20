Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666FB20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfBTNcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:32:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfBTNcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:32:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BAA7C049E1F;
        Wed, 20 Feb 2019 13:32:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id BEBC55D71A;
        Wed, 20 Feb 2019 13:32:38 +0000 (UTC)
Date:   Wed, 20 Feb 2019 14:32:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH 00/10] perf: Multi-die/package support
Message-ID: <20190220133238.GC25423@krava>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
 <20190220124619.GB25423@krava>
 <20190220132413.GH32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220132413.GH32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 20 Feb 2019 13:32:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:24:13PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 20, 2019 at 01:46:19PM +0100, Jiri Olsa wrote:
> > On Tue, Feb 19, 2019 at 12:00:01PM -0800, kan.liang@linux.intel.com wrote:
> 
> > > The code bases on the top of Len's multi-die/package support.
> > > https://lkml.org/lkml/2019/2/18/1534
> 
> > what is based on? I'm getting conflicts when applying
> > on tip or Arnaldo's perf/core

ugh, thanks ;-)

jirka
