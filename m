Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEVJm2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:42:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33794 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEVJmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:42:25 -0400
Subject: Re: [PATCH 2/6] arm_pmu: Change API to support 64bit counter values
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
References: <1526638943-2110-3-git-send-email-suzuki.poulose@arm.com>
 <201805220546.ySDTMDEX%fengguang.wu@intel.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <8b243663-5ea6-b2a4-a57f-4e0f5b130070@arm.com>
Date: Tue, 22 May 2018 10:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201805220546.ySDTMDEX%fengguang.wu@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/18 00:30, kbuild test robot wrote:
> Hi Suzuki,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on v4.17-rc6 next-20180517]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/arm64-perf-Support-for-chaining-event-counters/20180521-102117
> config: arm-corgi_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
> 
> All errors (new ones prefixed by >>):
> 
>     arch/arm/kernel/perf_event_xscale.c: In function 'xscale2pmu_init':
>>> arch/arm/kernel/perf_event_xscale.c:741:24: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
>       cpu_pmu->read_counter = xscale2pmu_read_counter;
>                             ^
>     arch/arm/kernel/perf_event_xscale.c:742:25: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
>       cpu_pmu->write_counter = xscale2pmu_write_counter;
>                              ^
>     cc1: some warnings being treated as errors


Thanks for the report, I have fixed this for the next version.

Suzuki
