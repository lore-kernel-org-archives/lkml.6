Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeEBIY2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:24:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36188 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeEBIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:24:24 -0400
X-Google-Smtp-Source: AB8JxZqgcdkaqaujNeaRT/kPY2IfwKVyrFCHt1aDIVnXOafu+w/yUmgkgW/JCLNAzGVbQ4y+zuvE3A==
Subject: Re: [PATCH v3 2/2] nvmem: Add RAVE SP EEPROM driver
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
References: <20180501052952.26765-1-andrew.smirnov@gmail.com>
 <20180501052952.26765-3-andrew.smirnov@gmail.com>
 <e6f74f86-a427-4165-cbc0-27fe129dab8e@linaro.org>
 <CAHQ1cqGmiRvE+sUdpOcFQ=oGjA79sVQGc+noQBv7SP_0rKggvw@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2733c63f-f7c6-cdbc-e725-03126d8a7ed5@linaro.org>
Date: Wed, 2 May 2018 09:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqGmiRvE+sUdpOcFQ=oGjA79sVQGc+noQBv7SP_0rKggvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/05/18 19:35, Andrey Smirnov wrote:
> On Tue, May 1, 2018 at 8:33 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>> On 01/05/18 06:29, Andrey Smirnov wrote:
>>>
>>> +// SPDX-License-Identifier: GPL-2.0+
>>
>> ...
>>>
>>> +MODULE_LICENSE("GPL");
>>
>> I think this should be
>> MODULE_LICENSE("GPL v2");
> 
> With that change the two statements would contradict each other. "GPL"
> means "GNU Public License v2 or later", whereas "GPL v2" means "GNU
> Public License v2" as per
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/module.h#n175
> 
Yep, You are correct, I missed the +.
I will send these patches to Greg during rc4-rc5 time.

thanks,
srini
