Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeCTRRm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:17:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:12639 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbeCTRRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:17:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,336,1517904000";
   d="scan'208";a="29696233"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Topic: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Index: AQHTv61aFYaSukXqZEajMVMtZoAMNaPZnPEA//+lWwCAAAhkAA==
Date: Tue, 20 Mar 2018 17:03:46 +0000
Message-ID: <09869EF2-48CC-4C66-A762-94C0C2B798E1@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com>
 <B96DA962-6278-4FDE-A8C6-020E789CE67F@intel.com>
In-Reply-To: <B96DA962-6278-4FDE-A8C6-020E789CE67F@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.178.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AAE629C9D53F742B28B8A6AB1134B54@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KHHkIf029954

On 3/20/18, 07:58, "Andy Lutomirski" <luto@kernel.org> wrote:
> The original version of these patches (mine and Andi’s) didn’t have
>  this comparison, didn’t need RDMSR, and didn’t allow malicious user
To be clear, RDMSR is not needed (with FSGSBASE)
    
    
