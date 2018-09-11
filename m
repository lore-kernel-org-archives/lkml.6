Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC588C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB220880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeILCWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:22:02 -0400
Received: from foss.arm.com ([217.140.101.70]:49472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeILCWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:22:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9813318A;
        Tue, 11 Sep 2018 14:20:51 -0700 (PDT)
Received: from [10.37.8.72] (unknown [10.37.8.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29223F575;
        Tue, 11 Sep 2018 14:20:45 -0700 (PDT)
Subject: Re: [PATCH 00/11] dts: Update coresight device tree bindings
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, lipengcheng8@huawei.com,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        orsonzhai@gmail.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Wei Xu <xuwei5@hisilicon.com>, zhang.lyra@gmail.com
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <8bfdaa9a-eaa5-5223-80fa-c0a315e904bb@arm.com>
Date:   Tue, 11 Sep 2018 22:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 11:17 AM, Suzuki K Poulose wrote:
> Coresight DT bindings have been updated to obey the DTS rules
> for label/address matching for graph nodes. The changes are in
> coresight/next tree scheduled for v4.20. This series updates the
> in kernel dts to match the new bindings along with updating a couple
> of new examples (e.,g CATU) in the Documentation (which were missed
> as they were still in flight when we created the series).
> 
> Please note that this should not be pulled for v4.19, which I assume
> is a safe assumption. But please do pull it for v4.20.
> The dt updates for the Juno boards were sent earlier with the original
> DT update series and has been queued for v4.20.
> 
> Applies on coresight/next (which is based on v4.19) and should apply
> cleanly on v4.19-rc3.
> 

All,

There are some additional warnings triggered by this series, as reported
by Sudeep [0]. I intend to fix the warnings and send and updated version
soon. So kindly ignore this thread. Apologies.

[0] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-September/601121.html

Suzuki
