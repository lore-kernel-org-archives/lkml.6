Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeDVGbQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 02:31:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:2231 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeDVGbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 02:31:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,310,1520924400";
   d="scan'208";a="193385169"
Date: Sun, 22 Apr 2018 14:31:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Chao Yu <yuchao0@huawei.com>
Cc: kbuild-all@01.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: sepearte hot/cold in free nid
Message-ID: <201804221427.WmgRaqpG%fengguang.wu@intel.com>
References: <20180420015231.90679-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420015231.90679-1-yuchao0@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I love your patch! Perhaps something to improve:

[auto build test WARNING on f2fs/dev-test]
[also build test WARNING on v4.17-rc1 next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chao-Yu/f2fs-sepearte-hot-cold-in-free-nid/20180421-061929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   fs/f2fs/node.c:486:15: sparse: expression using sizeof(void)
   fs/f2fs/node.c:1744:28: sparse: expression using sizeof(void)
>> fs/f2fs/node.c:2034:6: sparse: symbol 'load_nat_block' was not declared. Should it be static?
   fs/f2fs/node.c:2428:27: sparse: expression using sizeof(void)
   fs/f2fs/node.c:2523:40: sparse: restricted __le32 degrades to integer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
