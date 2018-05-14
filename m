Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeENKfQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:35:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40398 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeENKfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:35:14 -0400
X-Google-Smtp-Source: AB8JxZrcBb9izauZSSr69tJRsDn4xYl103J2JvDVp1E7XT94p76R8UeqUmBN8q+EqkvxFBkNrRIBww==
Subject: Re: [PATCH 2/3] hwmon: (ibmpowernv): Add support to read 64 bit
 sensors
To: Michael Ellerman <mpe@ellerman.id.au>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, jdelvare@suse.com, stewart@linux.vnet.ibm.com
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180509172926.GA20996@roeck-us.net>
 <87y3gmpv8t.fsf@concordia.ellerman.id.au>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6bcd8e6b-2f95-2ddd-ed6e-50815e46948b@roeck-us.net>
Date: Mon, 14 May 2018 03:35:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87y3gmpv8t.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/2018 12:11 AM, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
>> On Mon, May 07, 2018 at 03:55:37PM +0530, Shilpasri G Bhat wrote:
>>> The firmware has supported for reading sensor values of size u32.
>>> This patch adds support to use newer firmware functions which allows
>>> to read the sensors of size u64.
>>>
>>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> I won't apply for the time being since it depends on patch 1/3 which is
>> outside hwmon.
> 
> Do you mind if I take the series via the powerpc tree?
> 

Fine with me.

Guenter
