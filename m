Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FA4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEC2222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfBKN7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:59:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:50208 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfBKN7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:59:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 05:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="318039437"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2019 05:59:18 -0800
Received: from [10.125.252.196] (abudanko-mobl.ccr.corp.intel.com [10.125.252.196])
        by linux.intel.com (Postfix) with ESMTP id 290F25804B4;
        Mon, 11 Feb 2019 05:59:15 -0800 (PST)
Subject: Re: [PATCH v2 0/4] perf: enable compression of record mode trace to
 save storage space
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <64502e28-b312-e59f-5cd7-732c4088c16b@linux.intel.com>
 <20190211135245.GB16528@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f381506b-c67d-e966-9849-ec48b9275a44@linux.intel.com>
Date:   Mon, 11 Feb 2019 16:59:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211135245.GB16528@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.02.2019 16:52, Jiri Olsa wrote:
> On Mon, Jan 28, 2019 at 10:02:49AM +0300, Alexey Budankov wrote:
>>
<SNIP>
>> The patch set is for Arnaldo's perf/core repository.
> 
> hi,
> got here late and can't apply this anymore.. which revision
> (commit id) is this based on? perf/core is moving real fast
> these days ;-)
> 
> based on errors below I suspect u need to rebase anyway :-\

Yes, I will resend shortly.

Thanks,
Alexey

> 
> sry for late response
> 
> jirka
> 
