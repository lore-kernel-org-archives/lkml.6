Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeBZPxd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:53:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:51429 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752127AbeBZPx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:53:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="207145283"
Subject: Re: [PATCH ipmi/kcs_bmc v6] ipmi: kcs_bmc: coding-style fixes and use
 new poll type
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1519660094-9748-1-git-send-email-haiyue.wang@linux.intel.com>
 <3e0822bc-1cb5-f110-c2f2-3ffe7c3c8d3a@acm.org>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <c529abf6-e761-f975-e4df-f3afac53d467@linux.intel.com>
Date: Mon, 26 Feb 2018 23:53:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3e0822bc-1cb5-f110-c2f2-3ffe7c3c8d3a@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-02-26 23:50, Corey Minyard wrote:
> On 02/26/2018 09:48 AM, Haiyue Wang wrote:
>> Many for coding-style fixes, and update the poll API with the new
>> type '__poll_t', this is new commit from linux-4.16-rc1.
>>
>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>
> Sorry for the delay, I was on jury duty last week.  But it looks like 
> you got
> some useful changes in.
>
> I'm hoping you are done with this patch :-).  I've included in my 
> tree, but
> I can replace if necessary.
>
> Thanks,
>
Thanks for your time, my mistake, this one should be last one. :-)

BR,
Haiyue

> -corey
>
>> ---
>> v5 -> v6:
>>   - Add the missed change to EPOLLIN.
