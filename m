Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEPTsw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:48:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:24047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbeEPTsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:48:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="59229227"
Date: Thu, 17 May 2018 03:47:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: kbuild-all@01.org, davem@davemloft.net, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, lipeng321@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH net-next 09/10] net: hns3: Add support of
 .sriov_configure in HNS3 driver
Message-ID: <201805170336.ssQ87kX3%fengguang.wu@intel.com>
References: <20180515182014.42196-10-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515182014.42196-10-salil.mehta@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Salil-Mehta/Misc-Bug-Fixes-and-clean-ups-for-HNS3-Driver/20180516-211239
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:266:16: sparse: expression using sizeof(void)
   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:266:16: sparse: expression using sizeof(void)
>> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:1582:5: sparse: symbol 'hns3_pci_sriov_configure' was not declared. Should it be static?
   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:2513:21: sparse: expression using sizeof(void)
   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:2706:22: sparse: expression using sizeof(void)
   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:2706:22: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
