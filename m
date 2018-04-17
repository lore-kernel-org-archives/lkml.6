Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeDQTxz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:53:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:22065 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752310AbeDQTxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:53:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="32704635"
Date: Wed, 18 Apr 2018 03:53:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [spi:for-4.18 12/12] drivers/spi/spi-pxa2xx.c:914:5: sparse: symbol
 'pxa2xx_spi_transfer_one' was not declared. Should it be static?
Message-ID: <201804180300.Pn9JAJQ2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-4.18
head:   d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1
commit: d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1 [12/12] spi: pxa2xx: Use core message processing loop
reproduce:
        # apt-get install sparse
        git checkout d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/spi/spi-pxa2xx.c:877:16: sparse: expression using sizeof(void)
   drivers/spi/spi-pxa2xx.c:877:16: sparse: expression using sizeof(void)
>> drivers/spi/spi-pxa2xx.c:914:5: sparse: symbol 'pxa2xx_spi_transfer_one' was not declared. Should it be static?
   drivers/spi/spi-pxa2xx.c:1672:42: sparse: expression using sizeof(void)
   drivers/spi/spi-pxa2xx.c:1672:42: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
