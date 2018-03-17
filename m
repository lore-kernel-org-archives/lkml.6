Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeCQHiL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 03:38:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:64695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeCQHiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 03:38:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,319,1517904000";
   d="scan'208";a="35782154"
Date: Sat, 17 Mar 2018 15:38:06 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hao, Shun" <shun.hao@intel.com>, LKP <lkp@intel.com>
Subject: Re: [asm-generic:asm-generic] BUILD SUCCESS
 18fd258e74835b40a4f89f11ae933267866cc7af
Message-ID: <20180317073806.ubab7bib7tmftv2h@wfg-t540p.sh.intel.com>
References: <5aa9792f.wV2Hkl94T1JHtkuH%fengguang.wu@intel.com>
 <CAK8P3a2cKhf9iM1DSYDAwz4m94tLA8PQxmH-87O59Ayzo5tj1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a2cKhf9iM1DSYDAwz4m94tLA8PQxmH-87O59Ayzo5tj1w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

CC Shun, who maintains the kbuild test code now.

On Wed, Mar 14, 2018 at 09:00:59PM +0100, Arnd Bergmann wrote:
>On Wed, Mar 14, 2018 at 8:34 PM, kbuild test robot
><fengguang.wu@intel.com> wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git  asm-generic
>> branch HEAD: 18fd258e74835b40a4f89f11ae933267866cc7af  staging: iio: remove iio-trig-bfin-timer driver
>>
>> elapsed time: 192m
>>
>> configs tested: 176
>>
>> The following configs have been built successfully.
>> More configs may be tested in the coming days.
>>
>> blackfin                BF526-EZBRD_defconfig
>> blackfin                BF533-EZKIT_defconfig
>> blackfin            BF561-EZKIT-SMP_defconfig
>> blackfin                  TCM-BF537_defconfig
>> cris                 etrax-100lx_v2_defconfig
>> mn10300                     asb2364_defconfig
>> frv                                 defconfig
>> tile                         tilegx_defconfig
>> m32r                       m32104ut_defconfig
>> m32r                     mappi3.smp_defconfig
>> m32r                         opsput_defconfig
>> m32r                           usrv_defconfig
>> score                      spct6600_defconfig
>
>Hi Fengguang,
>
>Something odd is going in with the reporting here. I got individual reports for
>a number of the above that they failed, but the summary for the branch
>reports the builds as successful.

Yes that looks like a problem. However I don't see obviously clues by
looking at the log file. Perhaps we'll need some more verbose logging
in the hope we can catch the root cause next time it shows up.

>This branch contains the removal of blackfin, cris, mn10300, frv, tile, score,
>m32r, and metag, so none of the above should be marked as successful.
>
>You may want to prevent them from being built in the future, but it also
>seems the reporting needs to be checked.

Good to know that -- I just send patch to remove tests on those archs.

Thanks,
Fengguang
