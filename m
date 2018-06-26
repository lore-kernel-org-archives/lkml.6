Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E4BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C4826546
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C4826546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeFZG3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:29:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:10214 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751109AbeFZG3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:29:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 23:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="70031015"
Received: from haiyuewa-mobl1.ccr.corp.intel.com (HELO [10.67.68.36]) ([10.67.68.36])
  by orsmga002.jf.intel.com with ESMTP; 25 Jun 2018 23:29:42 -0700
Subject: Re: [PATCH v2] ipmi: kcs_bmc: fix IRQ exception if the channel is not
 open
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     luis.a.silva@dell.com, avi.fishman@nuvoton.com,
        openbmc@lists.ozlabs.org
References: <1529761873-323254-1-git-send-email-haiyue.wang@linux.intel.com>
 <3d5b2b55-381b-562a-9c02-52a8bdfc1a0d@acm.org>
From:   "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <86f77082-c77c-c86a-b884-cb699973bede@linux.intel.com>
Date:   Tue, 26 Jun 2018 14:29:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3d5b2b55-381b-562a-9c02-52a8bdfc1a0d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-26 03:34, Corey Minyard wrote:
>> return 0 to low level IRQ handler to indicate that the IRQ is handled.
>
> I've looked at this some more, and I think it's ok, especially with 
> the better description.
>
> I'm going to submit this for the current release after it sits in next 
> for a bit.
>
Got it, thanks, Corey.

BR,
Haiyue
> Thanks,
>
> -corey
>
>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> ---
>> v1 -> v2:
>>    - Change the commit message to be more understandable.
>> --- 

