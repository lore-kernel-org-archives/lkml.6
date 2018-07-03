Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628A9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0AE20837
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0AE20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeGCH6y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:58:54 -0400
Received: from foss.arm.com ([217.140.101.70]:44822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754536AbeGCH6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:58:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB7EA18A;
        Tue,  3 Jul 2018 00:58:51 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA8AF3F5A0;
        Tue,  3 Jul 2018 00:58:47 -0700 (PDT)
Subject: Re: [PATCH 16/20] dts: arm: omap: Update coresight bindings for
 hardware ports
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, arm@kernel.org, linux-kernel@vger.kernel.org,
        matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        linux-omap@vger.kernel.org,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-17-git-send-email-suzuki.poulose@arm.com>
 <20180703070951.GH112168@atomide.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <10a95b43-09d8-2e8e-fa44-a8c9227b3053@arm.com>
Date:   Tue, 3 Jul 2018 08:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703070951.GH112168@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Tony,

On 07/03/2018 08:09 AM, Tony Lindgren wrote:
> * Suzuki K Poulose <suzuki.poulose@arm.com> [180605 14:48]:
>> Switch to the new coresight bindings for hardware ports
> 
> So is this patch safe for me to pick separately for v4.19?

No. Please ignore this for now. The bindings are still under
discussion. Sorry for the inconvenience.

Suzuki
