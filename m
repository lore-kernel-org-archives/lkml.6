Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9543EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD3207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBVM43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:56:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:38296 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVM43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:56:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 04:56:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,399,1544515200"; 
   d="scan'208";a="149127276"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2019 04:56:26 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, Mansour Alharthi <malharthi9@gatech.edu>,
        acme@kernel.org
Subject: Re: [PATCH v0 1/2] perf: Copy parent's address filter offsets on clone
In-Reply-To: <20190215181038.GK5784@redhat.com>
References: <20190215115655.63469-1-alexander.shishkin@linux.intel.com> <20190215115655.63469-2-alexander.shishkin@linux.intel.com> <20190215181038.GK5784@redhat.com>
Date:   Fri, 22 Feb 2019 14:56:26 +0200
Message-ID: <87d0nkc77p.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@redhat.com> writes:

> Em Fri, Feb 15, 2019 at 01:56:54PM +0200, Alexander Shishkin escreveu:
>> When a child event is allocated in the inherit_event() path, the VMA
>> based filter offsets are not copied from the parent, even though the
>> address space mapping of the new task remains the same, which leads
>> to no trace for the new task until exec.
>
> Peter, I'm processing this one, ok? Ack?

Any news on this one?

Thanks,
--
Alex
