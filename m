Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC99C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C2820874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C2820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeFTJoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:44:38 -0400
Received: from foss.arm.com ([217.140.101.70]:34646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752870AbeFTJoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:44:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89ECE80D;
        Wed, 20 Jun 2018 02:44:33 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFEF03F589;
        Wed, 20 Jun 2018 02:44:30 -0700 (PDT)
Subject: Re: [PATCH 18/20] dts: sama5d2: Update coresight bindings for
 hardware ports
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, arm@kernel.org, linux-kernel@vger.kernel.org,
        matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-19-git-send-email-suzuki.poulose@arm.com>
 <20180619212417.GB3128@piout.net>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <abf65bac-0956-f1de-127e-38b0f41a6233@arm.com>
Date:   Wed, 20 Jun 2018 10:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619212417.GB3128@piout.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/18 22:24, Alexandre Belloni wrote:
> On 05/06/2018 22:43:29+0100, Suzuki K Poulose wrote:
>> Switch to the new coresight bindings for hardware ports
>>
>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm/boot/dts/sama5d2.dtsi | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
> Applied, thanks.
> 

Alexandre,

Please hold off applying this change, as we are yet to come to an
agreement on this. Sorry for the trouble. See [0]


[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582269.html

Kind regards
Suzuki
