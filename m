Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8243CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BDC20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BDC20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeINOMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:12:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58480 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbeINOMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:12:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07AED18A;
        Fri, 14 Sep 2018 01:58:32 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EA3B3F703;
        Fri, 14 Sep 2018 01:58:30 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] arm: dts: ste-dbx5x0: Update coresight bindings
 for hardware port
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mathieu poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-12-suzuki.poulose@arm.com>
 <CACRpkdanfg5s6_cAHdr3Sgc1NodNk+ECK8w0DoLvMvw9dxuWwA@mail.gmail.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <3e037edf-022b-84c0-93c4-cc0543b4c1eb@arm.com>
Date:   Fri, 14 Sep 2018 09:58:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdanfg5s6_cAHdr3Sgc1NodNk+ECK8w0DoLvMvw9dxuWwA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 14/09/18 09:43, Linus Walleij wrote:
> On Wed, Sep 12, 2018 at 3:54 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
>> Switch to the new coresight bindings
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 

Thanks.

> I guess you will merge this with the rest of the patches so I do
> not need to queue it?

We haven't figured out that yet. I guess it would be ideal if we
could merge this via arm-soc ? To avoid possible conflict with
other changes to the dts in the series. Sudeep has queued the
TC2 and Juno changes. So, if you could queue it, that is fine
with us.

Suzuki
