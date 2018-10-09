Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CECEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F802087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F802087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJIV3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:29:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:16418 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJIV3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:29:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 07:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,360,1534834800"; 
   d="scan'208";a="95953408"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.66.135]) ([10.252.66.135])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2018 07:12:33 -0700
Subject: Re: [PATCH] MAINTAINERS: intel_telemetry: Update maintainers info
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        David Box <david.e.box@linux.intel.com>
References: <20181008144303.23878-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VfNsasf-hpiubrfw=x+iVjBOOcY=uj6dB97iVpkoT6K=w@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <f6742716-d302-9af6-4d7f-428def965279@linux.intel.com>
Date:   Tue, 9 Oct 2018 19:42:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfNsasf-hpiubrfw=x+iVjBOOcY=uj6dB97iVpkoT6K=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09-Oct-18 5:07 PM, Andy Shevchenko wrote:
> On Mon, Oct 8, 2018 at 5:44 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> Add myself and David as the new maintainers for Intel Telemetry driver.
>>
> There is no explanation why.
> (Like previous one left the company, and / or you are doing set of the
> drivers related to PMC where telemetry is part of, etc)

Hi Andy,
  Souvik no longer works with Intel. I and David are volunteering to 
take up the task on his behalf since we do work on drivers which are 
pretty close to this one in terms of functionalities.

Thanks
Rajneesh

>> Signed-off-by: Box, David E <david.e.box@linux.intel.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> ---
>>   MAINTAINERS | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 22065048d89d..f33ebd1b8034 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7530,7 +7530,8 @@ F:        arch/x86/crypto/sha*-mb/
>>   F:     crypto/mcryptd.c
>>
>>   INTEL TELEMETRY DRIVER
>> -M:     Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
>> +M:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> +M:     Box, David E <david.e.box@linux.intel.com>
>>   L:     platform-driver-x86@vger.kernel.org
>>   S:     Maintained
>>   F:     arch/x86/include/asm/intel_telemetry.h
>> --
>> 2.17.1
>>
>

