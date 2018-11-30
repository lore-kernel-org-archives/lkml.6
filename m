Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F8DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436A82145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436A82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeLACrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:47:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34566 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLACrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:47:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAUFbSvg059458;
        Fri, 30 Nov 2018 09:37:28 -0600
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAUFbSbb018182
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 09:37:28 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 30
 Nov 2018 09:37:28 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 30 Nov 2018 09:37:28 -0600
Received: from [172.22.119.221] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAUFbRjJ019353;
        Fri, 30 Nov 2018 09:37:27 -0600
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
To:     Rob Herring <robh+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Craig Tatlor <ctatlor97@gmail.com>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181127105642.uu56phxjfl7bjl2p@holly.lan> <20181130135927.GA27500@basecamp>
 <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e29497f4-2c8d-378e-0f9b-9a5bcee3fb1b@ti.com>
Date:   Fri, 30 Nov 2018 09:37:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob/Brian

On 11/30/2018 08:13 AM, Rob Herring wrote:
> +Dan M
> 
> On Fri, Nov 30, 2018 at 7:59 AM Brian Masney <masneyb@onstation.org> wrote:
>>
>> On Tue, Nov 27, 2018 at 10:56:42AM +0000, Daniel Thompson wrote:
>>> On Sat, Nov 24, 2018 at 09:17:02AM -0500, Brian Masney wrote:
>>>> Add a trivial binding for the Texas Instruments LM3630A Backlight Chip.
> 
> How does this chip relate to ones Dan has been working on?
> 

This is a standard 8-bit white LED driver.  It looks like Brian is just adding DT
support to load the driver.

I would expect that the bindings need to be updated to be able to register one string or
another using the led-sources property.  There are a couple of examples in the kernel and
a couple of them in patch form.

This driver and binding need to be updated to the latest spec, as you pointed out with child nodes.

And Jacek has some new proposed bindings for the LED class so we may want to adopt those standards here
as well.  This is what I am waiting on for agreement so I can update my patch set.

Dan

>>>
>>> It's quite unusual for a backlight device to have a trivial binding.
>>>
>>> The driver supports fairly extensive parametrization via struct
>>> lm3530a_platform_data. It is really the case that none of these
>>> properties should ever be set via DT?
>>
>> Hi Daniel,
>>
>> I initially assumed that we would let user space configure these values
>> once the system has booted, but you are right that these should be
>> available in device tree.
>>
>> The driver has two different LED banks that can be configured
>> independently.
> 
> That is usually represented with child nodes which makes this anything
> but trivial. Plus, given that we have bindings for LEDs/backlights, no
> LED/backlight controller is a trivial device.
> 
>> How do you feel about having a single property in
>> device tree populate the initial values for both banks? I propose that
>> we could use the property default-brightness-level for leda_init_brt
>> and ledb_init_brt in struct lm3630a_platform_data. The max-brightness
>> property can populate leda_max_brt and ledb_max_brt.
>>
>> I need to look at other bindings this weekend to see if there are any
>> standard properties that I can use for leda_ctrl/ledb_ctrl, pwm_ctrl,
>> and pwm_period.
>>
>> Brian
>>


-- 
------------------
Dan Murphy
