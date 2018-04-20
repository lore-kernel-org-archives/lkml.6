Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeDTNdJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:33:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755108AbeDTNdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:06 -0400
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <mika.westerberg@linux.intel.com>, <lorenzo.pieralisi@arm.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-3-git-send-email-john.garry@huawei.com>
 <1524228606.21176.472.camel@linux.intel.com>
 <e838b3ef-5cf8-ac12-6b44-a1f8001f8b94@huawei.com>
 <1524230910.21176.474.camel@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <687812a4-6fe4-77df-8022-92938f8efaff@huawei.com>
Date: Fri, 20 Apr 2018 14:32:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1524230910.21176.474.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 14:28, Andy Shevchenko wrote:
> On Fri, 2018-04-20 at 14:09 +0100, John Garry wrote:
>> On 20/04/2018 13:50, Andy Shevchenko wrote:
>>> On Fri, 2018-04-20 at 18:07 +0800, John Garry wrote:
>
>>>> +			if (res->flags | IORESOURCE_IO)
>>>
>>> What does this mean?
>>
>> Here we check the resource flag for each resource for this PNP device
>> -
>> for IO resources we must translate the resource value from the bus
>> address to the logical PIO address.
>
> Please, re-read your code again.
>

Got it. But then again there is a helper for this, as Mika pointed out... :)

Cheers
