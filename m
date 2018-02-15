Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425563AbeBOQIZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:08:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:39255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424477AbeBOQIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:08:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="31730153"
Subject: Re: apm_32.c: undefined reference to `cpuidle_poll_state_init'
To: Meelis Roos <mroos@linux.ee>
References: <alpine.LRH.2.21.1802141954010.25362@math.ut.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <aa8d3514-a22c-703b-f59a-a05bad9cfdf6@intel.com>
Date: Thu, 15 Feb 2018 17:08:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1802141954010.25362@math.ut.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 7:02 PM, Meelis Roos wrote:
> This is 4.16-rc1+git as of today, on a IBM PC 365 that uses APM instead
> of ACPI. APM linking fails:
>
>    MODPOST vmlinux.o
> arch/x86/kernel/apm_32.o: In function `apm_init':
> apm_32.c:(.init.text+0x597): undefined reference to `cpuidle_poll_state_init'

There is a fix for that already in the linux-pm tree: 
https://patchwork.kernel.org/patch/10212015/

Thanks,
Rafael
