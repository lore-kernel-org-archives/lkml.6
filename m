Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeDEBZd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 21:25:33 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:47419 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeDEBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 21:25:32 -0400
Subject: Re: [PATCH] ARM64: dts: meson-axg: enable the eMMC controller
To: kbuild test robot <lkp@intel.com>
References: <20180403102651.60340-1-yixun.lan@amlogic.com>
 <201804040211.7wh3FnSx%fengguang.wu@intel.com>
CC: <yixun.lan@amlogic.com>, <kbuild-all@01.org>,
        Kevin Hilman <khilman@baylibre.com>, Nan Li <nan.li@amlogic.com>,
        Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <05e90560-46a7-7e4f-c4cf-13d8d6e754b3@amlogic.com>
Date: Thu, 5 Apr 2018 09:25:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <201804040211.7wh3FnSx%fengguang.wu@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.93.211]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin

On 04/04/2018 02:26 AM, kbuild test robot wrote:
> Hi Nan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20180403]
> [cannot apply to robh/for-next v4.16 v4.16-rc7 v4.16-rc6 v4.16]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/ARM64-dts-meson-axg-enable-the-eMMC-controller/20180403-224314
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm64/boot/dts/amlogic/meson-axg-s400.dts:49.24-25 syntax error
>    FATAL ERROR: Unable to parse input tree
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

oops, need to add this header (I fail to do a last check when rebase to
the dt64 branch)

+#include <dt-bindings/gpio/meson-axg-gpio.h>

will send a patch v2

Yixun
