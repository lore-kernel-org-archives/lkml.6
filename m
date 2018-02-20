Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBTJNW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:13:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:36445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeBTJNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:13:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,538,1511856000";
   d="scan'208";a="31357668"
Date: Tue, 20 Feb 2018 17:12:25 +0800
From: kbuild test robot <lkp@intel.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: kbuild-all@01.org, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@bootlin.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v4 06/13] power: supply: axp20x_battery: use data struct
 for variant specific code
Message-ID: <201802201606.lLg38XZv%fengguang.wu@intel.com>
References: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-support-for-AXP813-ADC-and-battery-power-supply/20180220-051138
base:    
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/power/supply/axp20x_battery.c:479:23: sparse: symbol 'axp209_data' was not declared. Should it be
>> drivers/power/supply/axp20x_battery.c:486:23: sparse: symbol 'axp221_data' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
