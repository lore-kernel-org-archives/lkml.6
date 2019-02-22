Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80678C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558DA20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfBVCJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:09:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:22731 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfBVCJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:09:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 18:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="145543908"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.90]) ([10.239.197.90])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2019 18:09:43 -0800
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait instructions
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-6-git-send-email-fenghua.yu@intel.com>
 <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
 <20190221192424.GA158428@romley-ivt3.sc.intel.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <759a969e-0f61-7f57-5216-598e93ae22dd@intel.com>
Date:   Fri, 22 Feb 2019 10:09:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221192424.GA158428@romley-ivt3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2019 3:24 AM, Yu, Fenghua wrote:
> On Wed, Feb 20, 2019 at 10:37:27PM -0800, Andy Lutomirski wrote:
>> On Wed, Feb 20, 2019 at 7:44 PM Tao Xu <tao3.xu@intel.com> wrote:
>>>
>>> From: Fenghua Yu <fenghua.yu@intel.com>
>>
>>>
>>>  From patchwork Wed Jan 16 21:18:41 2019
>>> Content-Type: text/plain; charset="utf-8"
>>
>> [snipped more stuff like this]
>>
>> What happened here?
> 
> I don't know either:(
> 
> Tao never talked to me before he sent out this patch set. And the email
> format is totally wrong and he didn't change any code in this patch set.
> 
> I have no idea why he sent out this patch set. As of now I haven't got
> any response from him yet.
> 
> I believe he made a mistake here.
> 
I am really sorry for sending the wrong email. Yesterday I make a 
mistake to cc Fenghua's former patch file when I sending other patch.

I'm sorry for this trouble and I will be more careful in my work.
