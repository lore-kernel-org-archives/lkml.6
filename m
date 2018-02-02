Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeBBQMX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:12:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:39118 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeBBQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:12:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="200871898"
Subject: Re: [PATCH arm/aspeed/ast2500 v5 1/2] ipmi: add a KCS IPMI BMC driver
To: minyard@acm.org, joel@jms.id.au, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@intel.com
References: <1517537771-21285-1-git-send-email-haiyue.wang@linux.intel.com>
 <ff4fde2b-6fca-8e60-9c25-7e91500597ff@acm.org>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <f2f5e416-e5be-4de5-a144-8976f017cea5@linux.intel.com>
Date: Sat, 3 Feb 2018 00:12:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ff4fde2b-6fca-8e60-9c25-7e91500597ff@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-02 21:52, Corey Minyard wrote:
> On 02/01/2018 08:16 PM, Haiyue Wang wrote:
>> ---
>> v4->v5
>> - Fix -Wdiscarded-qualifiers 'const' compile warning.
>> - Fix size_t printk compile error.
>>
>> v3->v4
>> - Change to accept WRITE_START any time.
>>
>> v2->v3
>>
>> - Update the KCS phase state machine.
>> - Fix the race condition of read/write.
>>
>> v1->v2
>>
>> - Divide the driver into two parts, one handles the BMC KCS IPMI 2.0 
>> state;
>>    the other handles the BMC KCS controller such as AST2500 IO 
>> accessing.
>> - Use the spin lock APIs to handle the device file operations and BMC 
>> chip
>>    IRQ inferface for accessing the same KCS BMC data structure.
>> - Enhanced the phases handling of the KCS BMC.
>> - Unified the IOCTL definition for IPMI BMC, it will be used by KCS 
>> and BT.
>>
>>
>> Provides a device driver for the KCS (Keyboard Controller Style)
>> IPMI interface which meets the requirement of the BMC (Baseboard
>> Management Controllers) side for handling the IPMI request from
>> host system software.
>
> Ok, this is in my queue, it will go into next once 4.16-rc1 comes out, 
> then into
> 4.16 if all goes well.
>
> Thanks, for your patience and work on this.
>
*Really appreciate your time on the code review, I really learned more, 
thank you.  :-)

-- Haiyue
*
> -corey 
