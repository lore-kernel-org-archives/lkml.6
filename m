Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4785AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0184B20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0184B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGTPjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:39:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:6887 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeGTPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:39:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 07:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,379,1526367600"; 
   d="scan'208";a="217657339"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2018 07:51:02 -0700
Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anurag Kumar Vulisha <anuragku@xilinx.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
 <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
 <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180612080256.GA17399@kroah.com>
 <MWHPR02MB2816AE6D9F6C065DADA78D7EA75F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180715080206.GA19377@kroah.com> <20180715081134.GA20758@kroah.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <541ba9a3-058e-028a-2a6c-a5d4334ddf96@intel.com>
Date:   Fri, 20 Jul 2018 17:53:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180715081134.GA20758@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2018 11:11, Greg Kroah-Hartman wrote:
> On Sun, Jul 15, 2018 at 10:02:06AM +0200, Greg Kroah-Hartman wrote:
>> On Sat, Jul 14, 2018 at 03:37:20PM +0000, Anurag Kumar Vulisha wrote:
>>> HI Greg,
>>>
>>> Ping!
>>> Thought of giving a friendly remainder about this patch.
>>
>> I am not the xhci maintainer, I need to wait from an ack from him before
>> I can take it.
> 
> And he's on vacation until later this week, so just relax.
> 

I added a couple minor comments.
I will be away for two more weeks, and I don't want to block this,
so if it is important to get this to 4.18 I won't object picking it as is.

-Mathias
