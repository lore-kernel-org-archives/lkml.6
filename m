Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeEBHl5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:41:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:37584 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeEBHly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:41:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="50801686"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v6 01/11] perf/x86/intel/pt: Move Intel-PT MSR bit
 definitions to a public header
Thread-Topic: [PATCH v6 01/11] perf/x86/intel/pt: Move Intel-PT MSR bit
 definitions to a public header
Thread-Index: AQHTwLGF7CJ+ZvPIaUyuDPRh98N00qQZDtmAgAM/20A=
Date: Wed, 2 May 2018 07:41:50 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167F6B61D@SHSMSX101.ccr.corp.intel.com>
References: <1521544918-31084-1-git-send-email-luwei.kang@intel.com>
 <1521544918-31084-2-git-send-email-luwei.kang@intel.com>
 <20180430135727.GA12258@hirez.programming.kicks-ass.net>
In-Reply-To: <20180430135727.GA12258@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWI0ZmMzNDEtMTgxYS00NWVjLWEzZmItNTY0ZWY5MDE2YTllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiIraEpLeEFudCthT2lZM2hhUGdoaFNoUloyXC9QakFTTVd0WlBrMW9Oc1Vpc0xtTUpxdGo3K1dTclRsaFFWRjZ0KyJ9
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

> > Intel Processor Trace virtualization enabling in guest need to use
> > these MSR bits, so move them to public header msr-index.h.
> > Introduce RTIT_CTL_FABRIC_EN and sync the definitions to latest spec.
> 
> You forgot to Cc the maintainers.
> 
> Also, this patch does 2 things, I think we have a rule that says that's a bad thing.

I will split it into two patches, one patch to make these #define in a public header and another patch to add new bits for Intel Processor Trace MSRs. Thank for the review.

Thanks,
Luwei Kang
