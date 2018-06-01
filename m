Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeFAR4f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:56:35 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34272 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeFAR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:56:32 -0400
X-Google-Smtp-Source: ADUXVKICCTrmCCTYkqSFgAitg8cfirG8Cn4A25PLqgE3FTb0xZcgpbDd1XFAjGAJLYf1L6skQhPb1w==
Subject: Re: [PATCH 2/3] clk: bcm: Update and add tingray clock entries
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>
References: <1527266717-8406-1-git-send-email-ray.jui@broadcom.com>
 <1527266717-8406-3-git-send-email-ray.jui@broadcom.com>
 <20180531162556.GA955@rob-hp-laptop>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <a354f3d1-051d-8b68-e6b3-ce7a739c10c9@broadcom.com>
Date: Fri, 1 Jun 2018 10:56:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531162556.GA955@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 5/31/2018 9:25 AM, Rob Herring wrote:
> On Fri, May 25, 2018 at 09:45:16AM -0700, Ray Jui wrote:
>> Update and add Stingray clock definitions and tables so they match the
>> binding document and the latest ASIC datasheet
>>
>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   drivers/clk/bcm/clk-sr.c           | 135 ++++++++++++++++++++++++++++++++-----
>>   include/dt-bindings/clock/bcm-sr.h |  24 +++++--
> 
> This goes in the 1st patch.

Please help to confirm. You want 1st patch and 2nd patch to be combined 
into a single patch?

Thanks.

> 
>>   2 files changed, 137 insertions(+), 22 deletions(-)
