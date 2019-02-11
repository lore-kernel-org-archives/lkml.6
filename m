Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD94AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A827D20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfBKOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:39168 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfBKOWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 06:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="125560745"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2019 06:22:34 -0800
Received: from [10.125.252.196] (abudanko-mobl.ccr.corp.intel.com [10.125.252.196])
        by linux.intel.com (Postfix) with ESMTP id D81BA5804B4;
        Mon, 11 Feb 2019 06:22:29 -0800 (PST)
Subject: Re: [PATCH v2 1/4] perf-security: document perf_events/Perf resource
 control
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <fd896eec-7833-f23a-ad2f-95005dca5fff@linux.intel.com>
 <a108c800-d6c1-fac1-b73b-e390e579e6ef@linux.intel.com>
 <alpine.DEB.2.21.1902102300210.8784@nanos.tec.linutronix.de>
 <969b6ea5-a5bf-70b7-7031-38b07538f744@linux.intel.com>
 <alpine.DEB.2.21.1902111514550.3197@nanos.tec.linutronix.de>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b202708c-1967-f673-16a2-005a67dffebe@linux.intel.com>
Date:   Mon, 11 Feb 2019 17:22:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902111514550.3197@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.02.2019 17:15, Thomas Gleixner wrote:
> On Mon, 11 Feb 2019, Alexey Budankov wrote:
>> On 11.02.2019 1:34, Thomas Gleixner wrote:
>>> On Thu, 7 Feb 2019, Alexey Budankov wrote:
>>>
>>> General note: Please stay in the 80 char limit for all of the text.
>>
>> Yes, sure. [PATCH v2 4/4] implements wrapping at 72 columns.
> 
> So you provide crappy formatted stuff first, just to reformat it at the
> end. I'm missing the logic behind that.

The logic is not to mix new content review with the whole doc 
formatting in the end.

Thanks,
Alexey

> 
> Thanks,
> 
> 	tglx
> 
