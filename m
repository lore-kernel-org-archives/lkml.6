Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFDB20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFDB20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeIJQRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:17:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55540 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeIJQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:17:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C7118A;
        Mon, 10 Sep 2018 04:23:49 -0700 (PDT)
Received: from [10.4.12.120] (e107158-lin.emea.arm.com [10.4.12.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B96B13F575;
        Mon, 10 Sep 2018 04:23:48 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <ca95124f-db09-c38f-d96a-5240bfe8c024@arm.com>
 <20180907124252.GM24082@hirez.programming.kicks-ass.net>
From:   Qais Yousef <qais.yousef@arm.com>
Message-ID: <477033c2-87e5-0b7e-4263-a8d2e336e050@arm.com>
Date:   Mon, 10 Sep 2018 12:23:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907124252.GM24082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/18 13:42, Peter Zijlstra wrote:
> On Wed, Aug 29, 2018 at 03:08:38PM +0100, Qais Yousef wrote:
>> It was hard to track the history of this and *why* it's needed.
> Yeah, my bad..
>
> So at some point I wanted to do dynamic capacity and dynamic smt gain by
> using the x86 APERF/MPERF stuff. But it never quite worked and we got
> stuck with the remnants.


OK thanks for the info. I think that was 10 years ago? With all the code 
moves and renaming git log -L was getting more difficult to use as I dug 
deeper in history :p

Is this work officially dead then? If yes, it ended up not being useful 
or just never got around finishing it?

Thanks

-- 
Qais Yousef

