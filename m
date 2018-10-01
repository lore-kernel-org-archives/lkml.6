Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E7EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7942084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7942084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeJARZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:25:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46862 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbeJARZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:25:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E29118A;
        Mon,  1 Oct 2018 03:47:56 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 589A53F5B3;
        Mon,  1 Oct 2018 03:47:53 -0700 (PDT)
Subject: Re: [RFC v2 3/7] irqchip/rtl8186: Add RTL8186 interrupt controller
 driver
To:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-4-yasha.che3@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a0c812a0-3237-1cdc-049f-0ebe4c0ceccb@arm.com>
Date:   Mon, 1 Oct 2018 11:47:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001102952.7913-4-yasha.che3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/18 11:29, Yasha Cherikovsky wrote:
> The Realtek RTL8186 SoC is a MIPS based SoC
> used in some home routers [1][2].
> 
> This adds a driver to handle the interrupt controller
> on this SoC.
> 
> [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
> [2] https://wikidevi.com/wiki/Realtek_RTL8186
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/irqchip/Kconfig       |   5 ++
>   drivers/irqchip/Makefile      |   1 +
>   drivers/irqchip/irq-rtl8186.c | 107 ++++++++++++++++++++++++++++++++++
>   3 files changed, 113 insertions(+)
>   create mode 100644 drivers/irqchip/irq-rtl8186.c

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Please let me know how you want this to be merged once the rest of the 
series has been reviewed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
