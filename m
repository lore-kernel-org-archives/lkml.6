Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E4C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6221902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392515AbfBMPnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:43:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:44431 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392502AbfBMPnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:43:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 07:43:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="126167104"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.68.82]) ([10.252.68.82])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2019 07:43:02 -0800
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
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <308aa852-b2c3-3336-707f-d54de6ad77b7@linux.intel.com>
Date:   Wed, 13 Feb 2019 21:13:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213152326.GA1883@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Feb-19 8:53 PM, Borislav Petkov wrote:
> On Wed, Feb 13, 2019 at 08:38:06PM +0530, Rajneesh Bhardwaj wrote:
>> Add CPUID of Icelake (ICL) mobile processors to Intel family list. The
>> information related to ICL CPUID is referenced from below Coreboot
>> project link.
>>
>> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
>>
> I believe tglx was suggesting you should drop this link. If you can't
> reference an official document, then you don't need any reference.

Icelake related information is  available here 
https://www.intel.in/content/www/in/en/design/products-and-solutions/processors-and-chipsets/ice-lake/overview.html 
but it may require a login either with Intel or a Partner ID.

The CPUID mentioned in this document is 0x706E0 which is same as per 
this coreboot link.


>
