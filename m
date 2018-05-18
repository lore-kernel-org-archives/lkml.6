Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeERFPS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:15:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:12757 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeERFPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:15:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="42795989"
Date: Fri, 18 May 2018 13:14:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Yuchung Cheng <ycheng@google.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-kernel@vger.kernel.org
Subject: [net-next:master 1200/1233] net/ipv4/tcp_recovery.c:24:5: sparse:
 symbol 'tcp_rack_reo_wnd' was not declared. Should it be static?
Message-ID: <201805181300.JN7KwXNm%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
head:   538e2de104cfb4ef1acb35af42427bff42adbe4d
commit: 20b654dfe1beaca60ab51894ff405a049248433d [1200/1233] tcp: support DUPACK threshold in RACK
reproduce:
        # apt-get install sparse
        git checkout 20b654dfe1beaca60ab51894ff405a049248433d
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   net/ipv4/tcp_recovery.c:46:16: sparse: expression using sizeof(void)
   net/ipv4/tcp_recovery.c:46:16: sparse: expression using sizeof(void)
>> net/ipv4/tcp_recovery.c:24:5: sparse: symbol 'tcp_rack_reo_wnd' was not declared. Should it be static?
   include/net/tcp.h:738:16: sparse: expression using sizeof(void)
   net/ipv4/tcp_recovery.c:102:40: sparse: expression using sizeof(void)
   net/ipv4/tcp_recovery.c:102:40: sparse: expression using sizeof(void)
   include/net/tcp.h:738:16: sparse: expression using sizeof(void)
   net/ipv4/tcp_recovery.c:210:42: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
