Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9780EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A6B20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBEDvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:51:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:15982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEDvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:51:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 19:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="135948623"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.74.67]) ([10.252.74.67])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2019 19:51:15 -0800
Subject: Re: [PATCH 06/10] x86/cpu: Add Icelake to Intel family
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     platform-driver-x86@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
 <20190201073234.13280-7-rajneesh.bhardwaj@linux.intel.com>
 <alpine.DEB.2.21.1902041731500.3006@nanos.tec.linutronix.de>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <15d691de-609a-b74c-5cf4-0e78a88bdc60@linux.intel.com>
Date:   Tue, 5 Feb 2019 09:21:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902041731500.3006@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-Feb-19 11:04 PM, Thomas Gleixner wrote:
> On Fri, 1 Feb 2019, Rajneesh Bhardwaj wrote:
>
>> Add CPUID of Icelake (ICL) mobile processors to Intel family list. The
>> Information related to ICL CPUID is referenced from below Coreboot
>> project link.
>>
>> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
> Coreboot files are hardly authoritive information about CPUIDs.

It may take a while for it to be published in the SDMs.

>
>> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
>> index 0dd6b0f4000e..12b65bdb3d80 100644
>> --- a/arch/x86/include/asm/intel-family.h
>> +++ b/arch/x86/include/asm/intel-family.h
>> @@ -52,6 +52,8 @@
>>   
>>   #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
>>   
>> +#define INTEL_FAM6_ICELAKE_MOBILE       0x7E
> Please use TABs instead of a random number of spaces.

Sure, I will fix this.

>
> Thanks,
>
> 	tglx
