Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeECS1O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:27:14 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:28048 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:27:09 -0400
Subject: Re: [ANNOUNCE] v4.14.29-rt25
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
 <b04275af-000d-7b29-3031-508c9a01cd91@ti.com>
 <20180420171116.w2hxytgzvp4jgpyl@linutronix.de>
 <764d0abc-7e88-a696-17a0-0bf807148d5b@ti.com>
 <20180423191023.qtinidsq4vj3lmha@linutronix.de>
 <8933b3b9-7f70-0f3f-a8b8-19d4369b35d4@ti.com>
 <20180503152417.sztoptu5fcbw2b5h@linutronix.de>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0096e540-7966-f6bf-522c-c6c18c13da95@ti.com>
Date: Thu, 3 May 2018 13:26:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503152417.sztoptu5fcbw2b5h@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/03/2018 10:24 AM, Sebastian Andrzej Siewior wrote:
> On 2018-05-01 10:04:13 [-0500], Grygorii Strashko wrote:
>> Hi Sebastian,
> Hi Grygorii,
> 
>> Sry, it took some time as i found some instability -
>> test "stress-ng --class os --all 0 -t 5m " not always finished :(
>> So, I've tried to rollback to v4.14.29-rt25 and use as TI RT kernel as
>> pure rt-devel. Still not sure if this is some sort of regression or not.
> 
> is this new? So v4.14.29-rt25 works and v4.14.29-rt25 with this does
> not? This patch just silences the warning so it should not break
> anything…

Yes. It seems not related.

-- 
regards,
-grygorii
