Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA1DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C852075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C852075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeJLCP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:15:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:40013 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbeJLCP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:15:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="98408895"
Received: from vbgoda-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.69])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2018 11:46:57 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     John Garry <john.garry@huawei.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] docs/completion.txt: Fix a couple of punctuation nits
In-Reply-To: <20181011154143.GB9867@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1539183392-239389-1-git-send-email-john.garry@huawei.com> <20181011152910.GA8191@bombadil.infradead.org> <20181011154143.GB9867@hirez.programming.kicks-ass.net>
Date:   Thu, 11 Oct 2018 21:46:56 +0300
Message-ID: <87bm80wcbj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Oct 11, 2018 at 08:29:10AM -0700, Matthew Wilcox wrote:
>> On Wed, Oct 10, 2018 at 10:56:32PM +0800, John Garry wrote:
>> > This patch fixes a couple of punctuation nits which can make the document
>> > more correct and readable.
>> > 
>> > Also missing "()" are added to some function references for consistency.
>> 
>> While there's nothing wrong here, any chance you want to try converting
>> it to .rst and adding it to the overall index?  It looks a lot like
>> rst already.
>
> I, on principle, will not touch rst files. They are inferior to txt files.

$ git shortlog --author=Zijlstra  -- Documentation/scheduler/

It does not look like you touch txt files either.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
