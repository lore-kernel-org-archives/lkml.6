Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF4CC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F057E20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F057E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeINCB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:01:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:29899 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeINCB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:01:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 13:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,370,1531810800"; 
   d="scan'208";a="74089951"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.146.110]) ([10.249.146.110])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2018 13:50:17 -0700
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     James Wang <jnwang@suse.com>, Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.de, bpetkov@suse.de, linux-kernel@vger.kernel.org
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <20180911093324.GB10436@kroah.com>
 <CAFgQCTtA0zFti3-X6r2E+60mWTWxzKoRehzE18Lg0M5D-MeM9w@mail.gmail.com>
 <14f8bb1c-ef13-1329-b144-d487949615e5@suse.com>
 <19d8cdd3-7f22-4066-e77f-8d17bf50bee7@intel.com>
 <90446c6c-e6ef-e55d-07f7-01f661fa2cd6@suse.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <f08dda15-1b2c-a564-4f2b-90736cc4b340@intel.com>
Date:   Thu, 13 Sep 2018 22:50:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <90446c6c-e6ef-e55d-07f7-01f661fa2cd6@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 5:21 PM, James Wang wrote:
>
> On 09/12/2018 11:56 AM, Rafael J. Wysocki wrote:
>> On 9/12/2018 11:10 AM, James Wang wrote:
>>> On 09/12/2018 02:41 PM, Pingfan Liu wrote:
>>>> Cc James, could you try to enable initcall_debug, and paste the
>>>> shutdown seq with 722e5f2b1eec ("driver core: Partially revert "driver
>>>> core: correct device's shutdown order"") and without it?
>>> OK. And I will scheudule some testing orders, ahah, I'm in a business
>>> trip.
>>> All operations will be a little bit delay, but I will make it done.
>>>
>>> James
>>>
>> Can you please open a Bugzilla entry at bugzilla.kernel.org for the
>> tracking of this issue and attach the results to that one for future
>> reference?
>>
> Hi sir,
> File a bug is no problem. but which product category should be used.

Please file it under "Drivers/Other" and let me know the number. Thanks!

