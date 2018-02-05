Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeBEGCr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:02:47 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:50785 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeBEGCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:02:39 -0500
Subject: Re: [PATCH v6 24/41] ARM: dm644x: add new clock init using common
 clock framework
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-25-git-send-email-david@lechnology.com>
 <28508a72-2fc7-1dc2-8a2c-997139d70831@ti.com>
 <d8325090-e369-5a1a-b34a-8174123b01ff@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <bc304a78-662a-d57a-cda4-fe7507e7a6cf@ti.com>
Date: Mon, 5 Feb 2018 11:31:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <d8325090-e369-5a1a-b34a-8174123b01ff@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 February 2018 11:36 PM, David Lechner wrote:
> On 02/02/2018 08:39 AM, Sekhar Nori wrote:
>> On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
>>> This adds the new board-specific clock init in mach-davinci/dm644x.c
>>> using the new common clock framework drivers.
>>>
>>> The #ifdefs are needed to prevent compile errors until the entire
>>> ARCH_DAVINCI is converted.
>>>
>>> Also clean up the #includes since we are adding some here.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>> I did not notice this before, but the subject line for this and other
>> patches needs to be "ARM: davinci: "
> 
> so "davinci" == "dm644x" and not any other SoC?

No, I meant "ARM: davinci: dm644x: " instead of just "ARM: dm644x".

Thanks,
Sekhar
