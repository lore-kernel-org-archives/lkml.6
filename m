Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72EC222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbfBMQfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:35:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:15631 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404377AbfBMQfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:35:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 08:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="126178809"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.68.82]) ([10.252.68.82])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2019 08:35:19 -0800
Subject: Re: [PATCH v2 06/10] x86/cpu: Add Icelake to Intel family
To:     Borislav Petkov <bp@alien8.de>
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
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <d1d8a2fb-f8f9-7712-d53f-fac4bb2065a8@linux.intel.com>
Date:   Wed, 13 Feb 2019 22:05:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213160405.GC1883@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sure did, perhaps it wasn't clear in my response. I can remove 
coreboot link in next version but please clarify whether i should keep 
other link that i mentioned or just keep the commit without any link?

On 13-Feb-19 9:34 PM, Borislav Petkov wrote:
> On Wed, Feb 13, 2019 at 09:13:01PM +0530, Bhardwaj, Rajneesh wrote:
>> Icelake related information is  available here https://www.intel.in/content/www/in/en/design/products-and-solutions/processors-and-chipsets/ice-lake/overview.html
>> but it may require a login either with Intel or a Partner ID.
>>
>> The CPUID mentioned in this document is 0x706E0 which is same as per this
>> coreboot link.
> You did not read what I wrote.
>
