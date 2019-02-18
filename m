Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE0D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfBRI4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:56:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:26783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfBRI4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:56:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 00:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,384,1544515200"; 
   d="scan'208";a="139487105"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2019 00:56:35 -0800
Received: from [10.125.252.185] (abudanko-mobl.ccr.corp.intel.com [10.125.252.185])
        by linux.intel.com (Postfix) with ESMTP id 900D75804B4;
        Mon, 18 Feb 2019 00:56:31 -0800 (PST)
Subject: Re: [PATCH v3 0/3] admin-guide: extend perf-security with resource
 control, data categories and privileged users
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
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
References: <784bbe0d-56c1-bd63-1879-b7db988e40c0@linux.intel.com>
 <20190217161428.6b43608a@lwn.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c26bd0a2-f0a3-47d4-0ff8-620a677d7a91@linux.intel.com>
Date:   Mon, 18 Feb 2019 11:56:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190217161428.6b43608a@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18.02.2019 2:14, Jonathan Corbet wrote:
> On Mon, 11 Feb 2019 16:32:33 +0300
> Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>> The patch set extends the first version of perf-security.rst documentation
>> file [1], [2], [3] with the following topics:
>>
>> 1) perf_events/Perf resource limits and control management that describes
>>    RLIMIT_NOFILE and perf_event_mlock_kb settings for processes conducting
>>    performance monitoring;
>>
>> 2) categories of system and performance data that can be captured by
>>    perf_events/Perf with explicit designation of process sensitive data;
>>
>> 3) possible steps to create perf_event/Perf privileged users groups for 
>>    the current implementations of perf_events syscall API [4] and Perf tool;
> 
> I've applied the set, thanks.

Thanks a lot Jon!

~Alexey

> 
> jon
> 
