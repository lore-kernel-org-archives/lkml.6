Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6826DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CCF2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfAaS66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:58:58 -0500
Received: from foss.arm.com ([217.140.101.70]:49930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfAaS66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:58:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCF9780D;
        Thu, 31 Jan 2019 10:58:57 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E76AD3F59C;
        Thu, 31 Jan 2019 10:58:53 -0800 (PST)
Subject: Re: [PATCH v3 3/7] coresight: Use event attributes for sink selection
To:     mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
 <20190131184714.20388-4-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6fa9c1f9-2952-f758-851d-4fe4335d561b@arm.com>
Date:   Thu, 31 Jan 2019 18:58:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131184714.20388-4-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2019 18:47, Mathieu Poirier wrote:
> This patch uses the information conveyed by perf_event::attr::config2
> to select a sink to use for the session.  That way a sink can easily be
> selected to be used by more than one source, something that isn't currently
> possible with the sysfs implementation.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
