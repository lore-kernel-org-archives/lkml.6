Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C065C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3376C2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392374AbfBMRNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:13:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:46528 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfBMRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:13:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 09:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="126187440"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.68.82]) ([10.252.68.82])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2019 09:13:31 -0800
Subject: Re: [PATCH v2 06/10] x86/cpu: Add Icelake to Intel family
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     platform-driver-x86@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <20190213150810.32750-7-rajneesh.bhardwaj@linux.intel.com>
 <20190213152326.GA1883@zn.tnic>
 <308aa852-b2c3-3336-707f-d54de6ad77b7@linux.intel.com>
 <20190213160405.GC1883@zn.tnic>
 <d1d8a2fb-f8f9-7712-d53f-fac4bb2065a8@linux.intel.com>
 <46ad3b08-b96b-6ef2-a5e4-fb0865865916@intel.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <1836a770-86ce-fc34-f7fd-6d1692fa184a@linux.intel.com>
Date:   Wed, 13 Feb 2019 22:43:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <46ad3b08-b96b-6ef2-a5e4-fb0865865916@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Feb-19 10:10 PM, Dave Hansen wrote:
> On 2/13/19 8:35 AM, Bhardwaj, Rajneesh wrote:
>> I sure did, perhaps it wasn't clear in my response. I can remove
>> coreboot link in next version but please clarify whether i should keep
>> other link that i mentioned or just keep the commit without any link?
> I think we're hearing loud and clear from the maintainers that they
> prefer *public*, official documentation from Intel to back up our patches.
>
> Barring that, they'd rather have no link than a link to some other
> random project.

Thank you Dave for the clarification.

Hi Borislav, I realize that the link i mentioned is not public. 
Apologies for creating confusion around that and for the previous top 
posting.  I will drop references to the coreboot link too in the next 
version.

>
