Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09CDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8307D214C5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8307D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeGFRJW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:09:22 -0400
Received: from foss.arm.com ([217.140.101.70]:40462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933405AbeGFRJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:09:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E4C918A;
        Fri,  6 Jul 2018 10:09:20 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 582D53F2EA;
        Fri,  6 Jul 2018 10:09:19 -0700 (PDT)
Subject: Re: [REGRESSION] arm32 Cubietruck defconfig does not boot anymore
 since 4.18-rc1
To:     Will Deacon <will.deacon@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, maxime.ripard@bootlin.com
References: <1879608911.1296.1530896362007.JavaMail.zimbra@efficios.com>
 <20180706170400.GA4961@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <436511d7-34f7-e980-2a99-c2b216c6669b@arm.com>
Date:   Fri, 6 Jul 2018 18:09:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706170400.GA4961@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 18:04, Will Deacon wrote:
> Hi Mathieu,
> 
> On Fri, Jul 06, 2018 at 12:59:22PM -0400, Mathieu Desnoyers wrote:
>> The 4.18-rc3 arm32 kernel defconfig fails to boot on my Cubietruck.
>> This issue appeared with 4.18-rc1.
>>
>> It worked fine on 4.17.
>>
>> Any ideas ?
> 
> CC'ing linux-arm-kernel would be a good place to start :) [I've added it
> here, as well as Maxime and Marc].
> 
> With the right people on cc, I suspect this is a known issue and might
> even have a patch. (he says hopefully...)

I have had issues as well. With this patch[1] applied, my board works
well enough.

Thanks,

	M.

[1] https://lkml.org/lkml/2018/7/4/73
-- 
Jazz is not dead. It just smells funny...
