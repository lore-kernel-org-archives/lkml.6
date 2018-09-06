Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D35C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61E12077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61E12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeIFLdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:33:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:2619 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeIFLdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:33:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 23:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="81306714"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2018 23:59:57 -0700
Received: from [10.125.252.28] (abudanko-mobl.ccr.corp.intel.com [10.125.252.28])
        by linux.intel.com (Postfix) with ESMTP id 590425802B3;
        Wed,  5 Sep 2018 23:59:55 -0700 (PDT)
Subject: Re: [PATCH v7 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <20180905112851.GA29759@krava>
 <34e2f944-f5f3-094a-5997-899cea92d206@linux.intel.com>
 <20180905185141.GA2700@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c10be2f0-fadd-82ce-97a3-6121914f523d@linux.intel.com>
Date:   Thu, 6 Sep 2018 09:59:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905185141.GA2700@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05.09.2018 21:51, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 05, 2018 at 08:37:32PM +0300, Alexey Budankov escreveu:
>> On 05.09.2018 14:28, Jiri Olsa wrote:
>>> can't apply this version on Arnaldo's perf/core...
>  
>> my git remote -v
>  
>> origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (fetch)
>> origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (push)
>  
>> branch is perf/core, according to MAINTAINERS content.
>  
>> What is Arnaldo's perf/core? This one?
>  
>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
>  
>> and branch is perf/core?
> 
> yes.

See patch on top of this branch in answer to Jiri.

> 
> - Arnaldo
> 
