Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbeBBSHV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:07:21 -0500
Received: from vern.gendns.com ([206.190.152.46]:48583 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753347AbeBBSGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:06:11 -0500
Subject: Re: [PATCH v6 24/41] ARM: dm644x: add new clock init using common
 clock framework
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-25-git-send-email-david@lechnology.com>
 <28508a72-2fc7-1dc2-8a2c-997139d70831@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <d8325090-e369-5a1a-b34a-8174123b01ff@lechnology.com>
Date: Fri, 2 Feb 2018 12:06:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <28508a72-2fc7-1dc2-8a2c-997139d70831@ti.com>
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

On 02/02/2018 08:39 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
>> This adds the new board-specific clock init in mach-davinci/dm644x.c
>> using the new common clock framework drivers.
>>
>> The #ifdefs are needed to prevent compile errors until the entire
>> ARCH_DAVINCI is converted.
>>
>> Also clean up the #includes since we are adding some here.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> I did not notice this before, but the subject line for this and other
> patches needs to be "ARM: davinci: "

so "davinci" == "dm644x" and not any other SoC?

> 
> Apart from that:
> 
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> 
> Thanks,
> Sekhar
> 
