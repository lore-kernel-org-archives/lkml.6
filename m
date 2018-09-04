Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC28C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B9720843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B9720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIDSXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:23:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbeIDSXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:23:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75E777DAC7;
        Tue,  4 Sep 2018 13:58:37 +0000 (UTC)
Received: from krava (unknown [10.40.205.171])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1EF5663AF9;
        Tue,  4 Sep 2018 13:58:35 +0000 (UTC)
Date:   Tue, 4 Sep 2018 15:58:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf tool improvement requests
Message-ID: <20180904135835.GA25298@krava>
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
 <20180904071049.GY24124@hirez.programming.kicks-ass.net>
 <20180904134218.GA5364@kernel.org>
 <20180904135325.GI24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904135325.GI24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 13:58:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 13:58:37 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 03:53:25PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 04, 2018 at 10:42:18AM -0300, Arnaldo Carvalho de Melo wrote:
> > So, use 'c2c record' to get the samples:
> 
> IIRC that uses numa events and is completely useless.

I guess perf record on any other event would work
in Arnaldo's workflow

jirka
