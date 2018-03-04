Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeCDNFM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 08:05:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:16303 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752638AbeCDNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 08:04:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,423,1515484800";
   d="scan'208";a="32290027"
Date: Sun, 4 Mar 2018 21:04:27 +0800
From: kbuild test robot <lkp@intel.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: kbuild-all@01.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 13/22] nvmem: lpc18xx_otp: Convert to use
 devm_nvmem_register()
Message-ID: <201803042052.Y1F9bkSU%fengguang.wu@intel.com>
References: <20180228144106.16363-14-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228144106.16363-14-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc3 next-20180302]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/Verbatim-device-names-and-devm_nvmem_-un-register/20180303-220801


coccinelle warnings: (new ones prefixed by >>)

>> drivers/nvmem/lpc18xx_otp.c:90:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
