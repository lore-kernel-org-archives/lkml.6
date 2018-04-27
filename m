Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757026AbeD0BA3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:00:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:57650 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeD0BA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:00:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="34968117"
From: "Li, Philip" <philip.li@intel.com>
To: "Wu, Fengguang" <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
CC: lkp <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Hao, Shun" <shun.hao@intel.com>
Subject: RE: Makefile:636: arch/score/Makefile: No such file or directory
Thread-Topic: Makefile:636: arch/score/Makefile: No such file or directory
Thread-Index: AQHT3TBCNJzSxNFxX0KPZLeNWlwBrKQTy0/A
Date: Fri, 27 Apr 2018 01:00:25 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CAE8B50@shsmsx102.ccr.corp.intel.com>
References: <201804261013.6YZ6XwpM%fengguang.wu@intel.com>
 <CAK8P3a0tpU7RFasJUuG7V2ZYUoR-iYDzjO13neF08ToAdnLX+w@mail.gmail.com>
 <20180426072846.pa72ohtstnyjsa42@wfg-t540p.sh.intel.com>
In-Reply-To: <20180426072846.pa72ohtstnyjsa42@wfg-t540p.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTk1OWQ1NTQtZWE4My00ZWQ2LWFjZWMtZjk1NWQ4MTJiZGQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJYQ1lTV2ZzMlBxYnlMT2hqdXEzYVo0bGRNa0JVMTBcL0NoVzE1U1E0czZKaEdXM3BXSSs0VlBhWWpyWXFoUE9yeCJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >Please stop trying to build the removed architectures: tile, blackfin,
> >metag, m32r, frv, mn10300, cris and score.
> >
> >https://lwn.net/Articles/748074/ has details about why this broke.
> 
> Sorry about that!  It looks the architectures removal is not thorough
> enough. Hao, would you help take a look?
sure, we will handle this.

> 
> >Note that we do have a few new architectures that you may want
> >to add if you haven't done this already: nds32 and riscv were added
> >this year, and a couple of older architectures that didn't have upstream
> >gcc releases now have those, and I uploaded gcc binaries to
> >https://cdn.kernel.org/pub/tools/crosstool/.
> >
> >This should allow building everything we have in the kernel now.
> >Unfortunately the nds32 toolchain I uploaded is a little incomplete,
> >but I have a gcc-6.4 build that (mostly) works and gcc-8 should
> >be fine as well once it gets released.
> 
> OK, thanks for the tips! Philip may help plan add the 2 new archs
> nds32 and riscv.
thanks for info, we will add new archs support in near future.

> 
> Thanks,
> Fengguang
