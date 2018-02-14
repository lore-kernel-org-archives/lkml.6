Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032276AbeBNQPG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:15:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032249AbeBNQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:15:03 -0500
Subject: Re: [PATCH v13 1/9] LIB: Introduce a generic PIO mapping method
To: dann frazier <dann.frazier@canonical.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-2-git-send-email-john.garry@huawei.com>
 <20180213230551.GA24986@xps13.dannf>
CC: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <arnd@arndb.de>, <mark.rutland@arm.com>, <olof@lixom.net>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>, <joe@perches.com>,
        <benh@kernel.crashing.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>, <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <b16db30e-67d3-0469-d8c7-029665702378@huawei.com>
Date: Wed, 14 Feb 2018 16:13:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180213230551.GA24986@xps13.dannf>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2018 23:05, dann frazier wrote:
>>  	bool
>> >
>> > +config INDIRECT_PIO
>> > +	bool "Access I/O in non-MMIO mode"
>> > +	depends on ARM64
>> > +	help
>> > +	  On some platforms where no separate I/O space exists, there are I/O
>> > +	  hosts which can not be accessed in MMIO mode. Using the logical PIO
>> > +	  mechanism, the host-local I/O resource can be mapped into system
>> > +	  logic PIO space shared with MMIO hosts, such as PCI/PCIE, then the
>> > +	  system can access the I/O devices with the mapped logic PIO through
>> > +	  I/O accessors.
>> > +	  This way has a relatively little I/O performance cost. Please make
> grammar nit - s/a relatively/relatively/
>

Fine, thanks

John

>   -dann
>
>> > +	  sure your devices really need this configure item enabled.
>> > +
