Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFEPAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:00:44 -0400
Received: from foss.arm.com ([217.140.101.70]:57030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752057AbeFEPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:00:42 -0400
Subject: Re: [PATCH v2 0/5] arm64: perf: Support for chained counters
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <3cbe09d3-7878-d53d-0918-dfb38ac89353@arm.com>
Date: Tue, 5 Jun 2018 16:00:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/18 11:55, Suzuki K Poulose wrote:
> This series adds support for counting PMU events using 64bit counters
> for arm64 PMU.
> 
> The Arm v8 PMUv3 supports combining two adjacent 32bit counters
> (low even and hig odd counters) to count a given "event" in 64bit mode.
> This series adds the support for 64bit events in the core arm_pmu driver
> infrastructure and adds the support for armv8 64bit kernel PMU to use
> chained counters to count in 64bit mode. For CPU cycles, we use the cycle
> counter in 64bit mode, when requested. If the cycle counter is not available,
> we fall back to chaining the counters.
> 
> Tested on Juno, Fast models. Applies on 4.17-rc4
> 

For the series:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

-- 
Julien Thierry
