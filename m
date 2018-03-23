Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeCWJhc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:37:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:14643 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752405AbeCWJhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:37:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,349,1517904000";
   d="scan'208";a="41512246"
Date: Fri, 23 Mar 2018 17:36:38 +0800
From: kbuild test robot <lkp@intel.com>
To: Benjamin Warnke <4bwarnke@informatik.uni-hamburg.de>
Cc: kbuild-all@01.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, minchan@kernel.org, ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 2/5 v4] crypto: add zBeWalgo to crypto-api
Message-ID: <201803231728.EQZdGg40%fengguang.wu@intel.com>
References: <1B59F77F-1AD8-484A-BA18-255502527323@informatik.uni-hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B59F77F-1AD8-484A-BA18-255502527323@informatik.uni-hamburg.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc6]
[cannot apply to next-20180322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Warnke/add-compression-algorithm-zBeWalgo/20180323-155925
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> lib/zbewalgo/zbewalgo.c:70:12: sparse: symbol 'zbewalgo_stat_combination' was not declared. Should it be static?
>> lib/zbewalgo/zbewalgo.c:71:12: sparse: symbol 'zbewalgo_stat_count' was not declared. Should it be static?
>> lib/zbewalgo/zbewalgo.c:79:9: sparse: symbol 'zbewalgo_combinations' was not declared. Should it be static?
>> lib/zbewalgo/zbewalgo.c:80:4: sparse: symbol 'zbewalgo_combinations_count' was not declared. Should it be static?
>> lib/zbewalgo/zbewalgo.c:92:5: sparse: symbol 'zbewalgo_early_abort_size' was not declared. Should it be static?
>> lib/zbewalgo/zbewalgo.c:97:36: sparse: symbol 'zbewalgo_main_data_ptr' was not declared. Should it be static?
>> lib/zbewalgo/zbewalgo.c:103:9: sparse: symbol 'zbewalgo_base_algorithms' was not declared. Should it be static?
>> lib/zbewalgo/zbewalgo.c:104:4: sparse: symbol 'zbewalgo_base_algorithms_count' was not declared. Should it be static?
--
>> lib/zbewalgo/JBE2.c:46:44: sparse: constant 0xF0F0F0F00F0F0F0F is so big it is unsigned long
>> lib/zbewalgo/JBE2.c:47:42: sparse: constant 0x0F0F0F0F00000000 is so big it is long
   lib/zbewalgo/JBE2.c:127:40: sparse: constant 0xF0F0F0F00F0F0F0F is so big it is unsigned long
   lib/zbewalgo/JBE2.c:128:40: sparse: constant 0x0F0F0F0F00000000 is so big it is long
   lib/zbewalgo/JBE2.c:184:40: sparse: constant 0xF0F0F0F00F0F0F0F is so big it is unsigned long
   lib/zbewalgo/JBE2.c:185:40: sparse: constant 0x0F0F0F0F00000000 is so big it is long

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
