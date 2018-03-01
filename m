Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033093AbeCAQZy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:25:54 -0500
Received: from foss.arm.com ([217.140.101.70]:41566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032953AbeCAQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:25:51 -0500
Subject: Re: ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
References: <201803011134.bk1IHi9I%fengguang.wu@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a7358051-b4a0-c07c-1747-f4702abf220f@arm.com>
Date: Thu, 1 Mar 2018 16:25:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803011134.bk1IHi9I%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/18 03:18, kbuild test robot wrote:
> Hi Robin,
> 
> First bad commit (maybe != root cause):

I have to admit I'm slightly intrigued how this commit could possibly 
appear relevant to the IA64 build at all, let alone to this error :/

Robin.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   97ace515f01439d4cf6e898b4094040dc12d36e7
> commit: e1a50de37860b3a93a9d643b09638db5aff47650 arm64: cputype: Silence Sparse warnings
> date:   12 days ago
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout e1a50de37860b3a93a9d643b09638db5aff47650
>          # save the attached .config to linux build tree
>          make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>     ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
