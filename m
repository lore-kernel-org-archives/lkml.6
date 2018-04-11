Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDKBNp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:13:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:38277 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeDKBNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:13:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,434,1517904000";
   d="scan'208";a="46857327"
From: "Li, Philip" <philip.li@intel.com>
To: David Howells <dhowells@redhat.com>
CC: lkp <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Hao, Shun" <shun.hao@intel.com>
Subject: RE: [PATCH 05/45] C++: Set compilation as C++ for .c files
Thread-Topic: [PATCH 05/45] C++: Set compilation as C++ for .c files
Thread-Index: AQHT0LDG5GGUjSz0lkeNrVQuIyH9kqP6wmcw
Date: Wed, 11 Apr 2018 01:13:40 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CAA4EAB@shsmsx102.ccr.corp.intel.com>
References: <20180403132713.cffx5mpfrnwuokeh@wfg-t540p.sh.intel.com>
 <201804021242.NgXgixG7%fengguang.wu@intel.com>
 <152261524532.30503.16094079179209557382.stgit@warthog.procyon.org.uk>
 <18231.1522761410@warthog.procyon.org.uk>
 <19628.1523349854@warthog.procyon.org.uk>
 <20180410094553.6psva5rntlizm6pz@wfg-t540p.sh.intel.com>
In-Reply-To: <20180410094553.6psva5rntlizm6pz@wfg-t540p.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjJiYTNlMTgtNGM3My00MzYyLWI1ODgtNzBkMjY3OWNmN2ZjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiI3UEdydmtvekVcLyswOGR1WEVWWnRiamlLVVBaOUFzOVlnUDR1ZGZXMnhpeE9TZmltVWNaRURXWlVlK3NoZVR1NSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi David,
> 
> On Tue, Apr 10, 2018 at 09:44:14AM +0100, David Howells wrote:
> >Hi Fengguang,
> >
> >There's another kbuild test that's probably worth adding if you don't do it
> >already: create a c++ source file that just #includes all the exported UAPI
> >headers and then try to build it.  This should catch words like "private"
> >cropping up in structs.
> 
> That's a good idea! And it looks straightforward to do.
> CC Philip (current LKP maintainer) for possible plans.
Thanks David, we will look into this and planned with other priorities.
We will share estimation for possible target date next week.

> 
> Thanks,
> Fengguang
