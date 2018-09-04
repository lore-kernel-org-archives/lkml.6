Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B67AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F2520652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F2520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeIDTGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:06:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:38689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeIDTGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:06:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 07:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="259727039"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga005.fm.intel.com with ESMTP; 04 Sep 2018 07:41:13 -0700
Subject: Re: [PATCH 1/6] usb: xhci-mtk: resume USB3 roothub first
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
 <f144173b-6131-21cf-1ead-60d938ac289a@cogentembedded.com>
 <1535591392.32173.30.camel@mhfsdcap03>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <93e36b7b-f0d0-4f5e-69b7-4195c25628f4@linux.intel.com>
Date:   Tue, 4 Sep 2018 17:44:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1535591392.32173.30.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2018 04:09, Chunfeng Yun wrote:
> Hi,
> On Wed, 2018-08-29 at 12:13 +0300, Sergei Shtylyov wrote:
>> On 8/29/2018 5:55 AM, Chunfeng Yun wrote:
>>
>>> Give USB3 devices a better chance to enumerate at USB3 speeds if
>>> they are connected to a suspended host.
>>> Porting from "671ffdf xhci: resume USB 3 roothub first"
>>
>>      From commit 671ffdff5b13 ("xhci: resume USB 3 roothub first").
> 
> Ok, Thanks
> 

adding to queue (I'll fix that commit ID)

-Mathias

