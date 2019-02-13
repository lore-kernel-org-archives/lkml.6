Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E06EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A71222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391543AbfBMPQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:16:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:42538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390416AbfBMPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:16:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 07:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="274763003"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 07:16:50 -0800
Subject: Re: [PATCH 1/6] dt-bindings: usb: xhci-tegra: Add Tegra186 support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20190125113013.11447-1-thierry.reding@gmail.com>
 <20190207111432.GC18518@ulmo>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <a9df20d3-ef03-1895-ba54-4f96d36d081e@linux.intel.com>
Date:   Wed, 13 Feb 2019 17:21:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190207111432.GC18518@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2019 13:14, Thierry Reding wrote:
> On Fri, Jan 25, 2019 at 12:30:08PM +0100, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Extend the bindings to cover the set of features found in Tegra186.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>   .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Hi Greg, Mathias,
> 
> do you have any comments on this series or is it good to go into v5.1?
> 

xhci parts look good to me, (patches 2/6 and 3/6)
Sorry about the delay.

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
