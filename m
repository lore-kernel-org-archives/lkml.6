Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7EAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E2220866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E2220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJPUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:20:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:15581 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPUUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:20:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 05:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="78413144"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2018 05:30:06 -0700
Subject: Re: [PATCH] xhci: remove the unused sw_lpm_support
To:     Zeng Tao <prime.zeng@hisilicon.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539689828-35940-1-git-send-email-prime.zeng@hisilicon.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <1545bbcc-ca1a-b1fe-7363-ad05cbc7245c@linux.intel.com>
Date:   Tue, 16 Oct 2018 15:33:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539689828-35940-1-git-send-email-prime.zeng@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 14:37, Zeng Tao wrote:
> It is introduced for the pre-0.96 xHC controllers, and the driver only
> support HW LPM for 1.0 and later controllers.It's not actually used now
> and is thought not to be used in the future any more, so just remove it.
> 
> Acked-by: Mathias Nyman <mathias.nyman@intel.com>

Please don't add my Acked-by to patches I haven't seen.

 From Documentation/process/submitting-patches.rst:
  
"Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
has at least reviewed the patch and has indicated acceptance."

> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>

Otherwise the patch looks good, I'll queue it, and remove the extra Acked-by

Thanks
-Mathias
