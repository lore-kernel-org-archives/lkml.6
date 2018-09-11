Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE342086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE342086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeIKWXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:23:51 -0400
Received: from foss.arm.com ([217.140.101.70]:47112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeIKWXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:23:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AAA2ED1;
        Tue, 11 Sep 2018 10:23:33 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8543F703;
        Tue, 11 Sep 2018 10:23:23 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 11/11] dts: tc2: Update coresight bindings for hardware
 ports
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
 <20180911170113.GA27663@e107155-lin>
 <fbde78a0-6487-7bdb-d02b-4fbf556f536e@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <9cf11b0c-b5c0-b39d-8c57-ad7aea5c6212@arm.com>
Date:   Tue, 11 Sep 2018 18:23:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fbde78a0-6487-7bdb-d02b-4fbf556f536e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/18 18:15, Suzuki K Poulose wrote:
> On 09/11/2018 06:01 PM, Sudeep Holla wrote:
>> On Tue, Sep 11, 2018 at 11:17:12AM +0100, Suzuki K Poulose wrote:
>>> Switch to the new coresight bindings
>>>
>>
>> I still see the below warnings:
>>
>> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
>>     /replicator/in-ports: graph node has single child node 'port@0',
>>     #address-cells/#size-cells are not necessary
>> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
>>     /funnel@20040000/out-ports: graph node has single child node
>> 'port@0',
>>     #address-cells/#size-cells are not necessary
>>
>> I need the below patch to fix them, let me know if it looks OK, I can
>> amend and apply.
> 
> Thanks for reporting. I purposefully added the "address-cells" and
> followed the format everywhere in the series thinking that, that is
> indeed the formal way of doing it, rather than having implicit port
> numbers. I can send an updated series fixing it everywhere.
> 
No need to post the update for TC2 unless it's different from what I
have proposed.

-- 
Regards,
Sudeep
