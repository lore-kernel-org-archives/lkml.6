Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeEKECE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 00:02:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:27189 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeEKECD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 00:02:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="scan'208";a="40914163"
From: "Li, Philip" <philip.li@intel.com>
To: "Wu, Fengguang" <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>, lkp <lkp@intel.com>,
        "Du, Julie" <julie.du@intel.com>
Subject: RE: cross-compiling a 64-bit kernel on a 32-bit host
Thread-Topic: cross-compiling a 64-bit kernel on a 32-bit host
Thread-Index: AQHT6Nsl0At3YPCiIUa6sxRNLx/YiqQp5ehg
Date: Fri, 11 May 2018 04:01:46 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CB0F860@shsmsx102.ccr.corp.intel.com>
References: <20180510223619.jwdlle42brksfp4v@treble>
 <20180511033950.ahkey2jnsd5i2gvi@wfg-t540p.sh.intel.com>
In-Reply-To: <20180511033950.ahkey2jnsd5i2gvi@wfg-t540p.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjI3NGY4ODEtZjkxNC00YjczLTk4YTEtMDkyYjlhMzQzODYzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJzUVwvdVJZOUF3YitrbzVWWGtNQldjR04xYW9BQ3g5dlk1TGRva1VzMGNEVHVhanZ3b0xQTURXYXYzbE45NG1WdSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: cross-compiling a 64-bit kernel on a 32-bit host
> 
> Hi Josh,
> 
> CC LKP team.
> 
> On Thu, May 10, 2018 at 05:36:19PM -0500, Josh Poimboeuf wrote:
> >Hi Fengguang,
> >
> >I occasionally get compilation bug reports from people who are
> >cross-compiling an x86-64 kernel target on an x86-32 host.
> >
> >Any chance the 0-day build bot could test that configuration?  I think
> >just building a defconfig would be sufficient.  It would help sort out
> >issues in objtool and other host-built scripts.
> 
> To do that we'll need to create a new build chroot. Julie/Philip
> should be able to evaluate the efforts and do the plan.
got it, we will consider this in future plan after some evaluation.

> 
> Thanks,
> Fengguang
