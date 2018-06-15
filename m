Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 55AB4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C005208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C005208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936229AbeFOJ6H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:58:07 -0400
Received: from foss.arm.com ([217.140.101.70]:40572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934900AbeFOJ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:58:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5471529;
        Fri, 15 Jun 2018 02:58:05 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962FB3F59D;
        Fri, 15 Jun 2018 02:58:02 -0700 (PDT)
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Matt Sealey <Matt.Sealey@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
 <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
 <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <5e013d65-9931-6b8d-ce7c-4333309d4ada@arm.com>
 <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <738c62ae-75ef-16e7-c966-ca6dd0e2bc98@arm.com>
Date:   Fri, 15 Jun 2018 10:58:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 14:59, Rob Herring wrote:
> On Thu, Jun 14, 2018 at 2:53 AM, Suzuki K Poulose
> <Suzuki.Poulose@arm.com> wrote:
>> On 13/06/18 22:07, Matt Sealey wrote:
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>
>>>>> So, if the suggestion is to use an existing property "unit", I am fine
>>>>> with it, if people agree to it.
>>>>
>>>>
>>>> If we're going to have something sharply different than ACPI I prefer
>>>> Rob's idea.
>>
>>
>> No, the above comment is about using "unit" ( if it is a standard property
>> for specifying something specific to hardware) instead of "coresight,hwid".
>> I would prefer to stick to the DT graph bindings, because :
> 
> "unit" is not a standard property and I don't like it either.
> 
>>
>> 1) The connections are bi-directional => Well, not necessarily
>> bi-directional
>> in terms of the data flow. But the connection information is critical. i.e,
>> we need information about both the end-points of a connection, which the DT
>> graph bindings solves.
>>
>> All we are missing is a way for specifying the "hardware port" number and
>> the
>> direction of flow. I don't see why do we need to create something new just
>> for
>> these two properties for something that exists today and works reasonably
>> well
>> for the usecase.

Rob,

> 
> If you have "in-ports" and "out-ports" nodes, then that gives you
> direction and you can use reg for the "hardware port".
> 
> in-ports {
>    port@0 {
>      reg = <0>;
>      endpoint {...};
>    };
>    port@1 {
>      reg = <1>;
>      endpoint {...};
>    };
> };
> out-ports {
>    port@0 {
>      reg = <0>;
>      endpoint {...};
>    };
> };
> 
> I'll need to check, but dtc may need an update to not warn about this.

Ok, that looks good.

> 
>>
>>>
>>> What are you trying to say about being sharply different than ACPI?
>>
>>
>> The proposed Coresight ACPI draft bindings are based on the ACPI Graph
>> bindings
>> (just like the DT graph bindings and is compatible with it, in terms of the
>> APIs.
>> i.e, fwnode_graph_* operations work for both ACPI and DT  alike).
>>
>> So, what Mathieu, in turn means is, if we depart from the DT Graph bindings,
>> which
>> I personally don't see any benefit in.
> 
> If DT bindings can be reused for ACPI, that's fine, but don't expect
> any DT bindings to be accepted simply because they match ACPI
> bindings.

The proposed bindings are not making it compatible with the ACPI. In fact,
the ACPI bindings do need something similar to give us an explicit hardware
port number, which needs to be worked out. The only common theme shared
between the proposed ACPI and current DT bindings are the Generic Graph
bindings for describing the connections, which allows sharing the parsing
code independent of the platform, using fwnode_ops.

Suzuki
