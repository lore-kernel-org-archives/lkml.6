Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755508AbeE3FYW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:24:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:58139 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753598AbeE3FYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:24:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,458,1520924400";
   d="scan'208";a="233039698"
Date: Wed, 30 May 2018 13:21:10 +0800
From: Ye Xiaolong <xiaolong.ye@intel.com>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/6] mfd: da9063: Replace model with type
Message-ID: <20180530052110.GB27396@yexl-desktop>
References: <20180523114230.10109-2-marek.vasut+renesas@gmail.com>
 <201805261713.OJMLXvlB%fengguang.wu@intel.com>
 <fca2a629-e5e8-6ef8-7e7d-d25353ab4c3e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca2a629-e5e8-6ef8-7e7d-d25353ab4c3e@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marek

On 05/26, Marek Vasut wrote:
>On 05/26/2018 11:16 AM, kbuild test robot wrote:
>> Hi Marek,
>> 
>> I love your patch! Perhaps something to improve:
>> 
>> [auto build test WARNING on ljones-mfd/for-mfd-next]
>> [also build test WARNING on v4.17-rc6]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> 
>> url:    https://github.com/0day-ci/linux/commits/Marek-Vasut/mfd-da9063-Rename-PMIC_DA9063-to-PMIC_CHIP_ID_DA9063/20180526-162613
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>> config: x86_64-randconfig-x002-201820 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64 
>> 
>> All warnings (new ones prefixed by >>):
>> 
>>    In file included from include/linux/kernel.h:10:0,
>>                     from drivers//regulator/da9063-regulator.c:16:
>>    drivers//regulator/da9063-regulator.c: In function 'da9063_regulator_probe':
>>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>>       if (model->dev_model == da9063->type)
>>                ^
>>    include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
>>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>>                                  ^~~~
>>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>>       if (model->dev_model == da9063->type)
>>       ^~
>>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>>       if (model->dev_model == da9063->type)
>>                ^
>>    include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
>>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>>                                              ^~~~
>>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>>       if (model->dev_model == da9063->type)
>>       ^~
>>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>>       if (model->dev_model == da9063->type)
>>                ^
>>    include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
>>       ______r = !!(cond);     \
>>                    ^~~~
>>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>>       if (model->dev_model == da9063->type)
>>       ^~
>>    drivers//regulator/da9063-regulator.c:749:10: error: 'struct da9063' has no member named 'model'
>>        da9063->model);
>>              ^~
>> 
>> vim +/if +744 drivers//regulator/da9063-regulator.c
>
>Is it testing this patch without the other patches in the series or at
>least 1/6 ?

It was tested with the whole patch series as you can see in https://github.com/0day-ci/linux/commits/Marek-Vasut/mfd-da9063-Rename-PMIC_DA9063-to-PMIC_CHIP_ID_DA9063/20180526-162613.


Thanks,
Xiaolong
>
>-- 
>Best regards,
>Marek Vasut
>
