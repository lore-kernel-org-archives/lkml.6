Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95F321104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95F321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeK1GPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:15:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:38765 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbeK1GPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:15:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 11:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="112741007"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2018 11:16:13 -0800
Received: from [10.251.85.27] (abudanko-mobl.ccr.corp.intel.com [10.251.85.27])
        by linux.intel.com (Postfix) with ESMTP id 864BD58041B;
        Tue, 27 Nov 2018 11:16:08 -0800 (PST)
Subject: Re: [PATCH v4 2/2] Documentation/admin-guide: update admin-guide
 index.rst
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonatan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <feac7efa-df6f-cca1-e321-28d220bf0411@linux.intel.com>
 <abf0f0ec-15c5-59eb-8657-e1e0e1f396b6@linux.intel.com>
 <CAGXu5jJWTyEzXODmeKkko5A212TAe1KSWGuONRvF7Tt+RY+5Sw@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2e78e2e7-539c-041f-ae0c-feb09f595e97@linux.intel.com>
Date:   Tue, 27 Nov 2018 22:16:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJWTyEzXODmeKkko5A212TAe1KSWGuONRvF7Tt+RY+5Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kees,

On 27.11.2018 20:23, Kees Cook wrote:
> On Tue, Nov 27, 2018 at 12:16 AM, Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>> Extend index.rst index file at admin-guide root directory with
>> the reference to perf-security.rst file being introduced.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  Documentation/admin-guide/index.rst | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Seems like this could just be folded into patch 1? I'm not sure Jon's
> preference here, though.

Let's stick to Jon's preference in comments on v4 2/2.

Thanks for review!

-Alexey

> 
> -Kees
> 
>>
>> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
>> index 965745d5fb9a..0a491676685e 100644
>> --- a/Documentation/admin-guide/index.rst
>> +++ b/Documentation/admin-guide/index.rst
>> @@ -76,6 +76,7 @@ configure specific aspects of kernel behavior to your liking.
>>     thunderbolt
>>     LSM/index
>>     mm/index
>> +   perf-security
>>
>>  .. only::  subproject and html
> 
> 
> 
