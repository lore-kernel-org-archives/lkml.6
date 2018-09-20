Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD32ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0DA204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0DA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbeITSPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:15:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:1728 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbeITSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:15:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="92211952"
Received: from unknown (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2018 05:31:58 -0700
Message-ID: <5BA39461.8020907@intel.com>
Date:   Thu, 20 Sep 2018 20:36:49 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
CC:     "kan.liang@intel.com" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "like.xu@intel.com" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>
Subject: Re: [PATCH v3 0/5] Guest LBR Enabling
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com> <33183CC9F5247A488A2544077AF19020DB0F73EB@dggeml511-mbx.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB0F73EB@dggeml511-mbx.china.huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 07:34 PM, Gonglei (Arei) wrote:
>> -----Original Message-----
>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
>> Behalf Of Wei Wang
>> Sent: Thursday, September 20, 2018 6:06 PM
>> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org; pbonzini@redhat.com;
>> ak@linux.intel.com
>> Cc: kan.liang@intel.com; peterz@infradead.org; mingo@redhat.com;
>> rkrcmar@redhat.com; like.xu@intel.com; wei.w.wang@intel.com;
>> jannh@google.com; Gonglei (Arei) <arei.gonglei@huawei.com>
>> Subject: [PATCH v3 0/5] Guest LBR Enabling
>>
>> Last Branch Recording (LBR) is a performance monitor unit (PMU) feature
>> on Intel CPUs that captures branch related info. This patch series enables
>> this feature to KVM guests.
>>
>> Here is a conclusion of the fundamental methods that we use:
>> 1) the LBR feature is enabled per guest via QEMU setting of
>>     KVM_CAP_X86_GUEST_LBR;
> Did you send the QEMU parts for guest LBR support?
>

Not yet. Probably next week for the QEMU part.

Best,
Wei
