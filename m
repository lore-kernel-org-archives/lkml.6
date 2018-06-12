Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39A28C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DD3208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DD3208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754345AbeFLJu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:50:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59744 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754287AbeFLJu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:50:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A4511435;
        Tue, 12 Jun 2018 02:50:27 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4713F59D;
        Tue, 12 Jun 2018 02:50:24 -0700 (PDT)
Subject: Re: [PATCH 10/20] dts: juno: Update coresight bindings for hw port
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <matt.sealey@arm.com>,
        John Horley <john.horley@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-11-git-send-email-suzuki.poulose@arm.com>
 <20180608214946.GI30587@xps15>
 <CANLsYkxNakRGCWT6O0JRKz+N1OTU3-XreC_FiB8Fiv+jEoPEbQ@mail.gmail.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <451386d1-b08a-5d90-336c-4708e35a32bf@arm.com>
Date:   Tue, 12 Jun 2018 10:50:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkxNakRGCWT6O0JRKz+N1OTU3-XreC_FiB8Fiv+jEoPEbQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 22:52, Mathieu Poirier wrote:
> On 8 June 2018 at 15:49, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>> On Tue, Jun 05, 2018 at 10:43:21PM +0100, Suzuki K Poulose wrote:
>>> Switch to updated coresight bindings for hw ports.
>>>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>> Changes since V1:
>>>    - Add support Juno for r1 & r2.
>>> ---
>>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Sudeep please hold on before applying this as there is more work to be
> done on this set.

Mathieu,

I will wait for Rob / Frank to have a say on the bindings before I post the
next update.

Cheers
Suzuki
