Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeECPoP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:44:15 -0400
Received: from vern.gendns.com ([206.190.152.46]:35805 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECPoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:44:12 -0400
Subject: Re: [PATCH v9 07/27] ARM: davinci: dm355: add new clock init using
 common clock framework
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-8-david@lechnology.com>
 <d9633747-0c50-2934-d3b2-ba745f021077@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <18b7b217-7ccb-d2dd-8f2c-ba3ba0e5d893@lechnology.com>
Date: Thu, 3 May 2018 10:44:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d9633747-0c50-2934-d3b2-ba745f021077@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 10:34 AM, Sekhar Nori wrote:
> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>> This adds the new board-specific clock init in mach-davinci/dm355.c
>> using the new common clock framework drivers.
>>
>> The #ifdefs are needed to prevent compile errors until the entire
>> ARCH_DAVINCI is converted.
>>
>> Also clean up the #includes since we are adding some here.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> I am having trouble booting DM355 EVM with the series applied.
> Still to debug what is going wrong.

Can you dump the PLL registers using /sys/kernel/debug/clk/... ?
