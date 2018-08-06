Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B31CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2FC2192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2FC2192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeHFKZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:25:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:40224 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeHFKZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:25:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 01:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,451,1526367600"; 
   d="scan'208";a="73037804"
Received: from jingqili-mobl1.ccr.corp.intel.com (HELO [10.239.192.223]) ([10.239.192.223])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2018 01:17:03 -0700
Subject: Re: [PATCH 0/3] KVM: x86: expose a few new features into VM.
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.w.wang@intel.com
References: <1531212883-63173-1-git-send-email-jingqi.liu@intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <ec45e69c-8c1f-b3f3-eab7-0734d0ce0800@intel.com>
Date:   Mon, 6 Aug 2018 16:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531212883-63173-1-git-send-email-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

Do you have any comments for the series ?
Thanks
Jingqi

On 7/10/2018 4:54 PM, Jingqi Liu wrote:
> A few new features including user wait (umwait, umonitor, tpause)
> and direct stores (movdiri and movdir64b) will be available in
> Intel Snow Ridge, and need to be exposed to guest VM.
>
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
>
> This series expose umonitor,umwait, tpause, movdiri and movdir64b
> features to guest VM.
>
> Jingqi Liu (3):
>    KVM: x86: expose UMWAIT/UMONITOR/TPAUSE CPU features into VM.
>    KVM: x86: expose MOVDIRI CPU feature into VM.
>    KVM: x86: expose MOVDIR64B CPU feature into VM.
>
>   arch/x86/kvm/cpuid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

