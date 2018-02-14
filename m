Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031608AbeBNVlZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:41:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:35060 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031419AbeBNVlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:41:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,514,1511856000";
   d="scan'208";a="20088283"
Subject: Re: ERROR: "sst_context_init"
 [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <201802150332.ujDzQYVH%fengguang.wu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bc8a4057-f666-30a4-9144-3bd01db1b6ba@linux.intel.com>
Date: Wed, 14 Feb 2018 15:41:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201802150332.ujDzQYVH%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 01:23 PM, kbuild test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6556677a80400ca5744340d8ff6fbed22621293e
> commit: 4772c16ede522d46219a59646503d2020841a6f4 ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies
> date:   5 weeks ago
> config: x86_64-randconfig-s2-02150010 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>          git checkout 4772c16ede522d46219a59646503d2020841a6f4
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>     WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o
>     see include/linux/module.h for more information
>     WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o
>     see include/linux/module.h for more information
>     WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o
>     see include/linux/module.h for more information
This was reported by Arnd Bergman and fixed with a patch sent on January 
24 to alsa-devel ("ASoC: Intel: atom: fix ACPI/PCI Kconfig"), but I 
don't see it in Mark's tree?

http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/130979.html


>>> ERROR: "sst_context_init" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
>>> ERROR: "sst_context_cleanup" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
>>> ERROR: "sst_alloc_drv_context" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
>>> ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
>>> ERROR: "sst_configure_runtime_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
