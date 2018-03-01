Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032804AbeCAQN4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:13:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41316 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032580AbeCAQNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:13:54 -0500
Subject: Re: [PATCH v8 0/2] irqchip: qcom: add support for PDC interrupt
 controller
To: Lina Iyer <ilina@codeaurora.org>, tglx@linutronix.de,
        jason@lakedaemon.net
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
References: <20180228172730.25022-1-ilina@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <8768ac0b-0d1c-d415-7b51-b6785dcad05b@arm.com>
Date: Thu, 1 Mar 2018 16:13:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228172730.25022-1-ilina@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/18 17:27, Lina Iyer wrote:
> Changes since v7:
> 	- fix whitespace alignment for multi-line statement
> 	- add Rob H 'reviewed-by' for DT bindings
> 	- rebase on top of 4.6-rc3
> 
> On newer Qualcomm Techonologies Inc's SoCs like the SDM845, the GIC is in a
> power domain that can be powered off when not needed. Interrupts that need to
> be sensed even when the GIC is powered off, are routed through an interrupt
> controller in an always-on domain called the Power Domain Controller a.k.a PDC.
> This series adds support for the PDC's interrupt controller.
> 
> Please consider reviewing these patches.
> 
> RFC v1: https://patchwork.kernel.org/patch/10180857/
> RFC v2: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1600634.html
> v3: https://lkml.org/lkml/2018/2/6/595
> v4: https://www.spinics.net/lists/linux-arm-msm/msg32906.html
> v5: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1605500.html
> v6: https://lkml.org/lkml/2018/2/9/545
> v7: https://www.spinics.net/lists/kernel/msg2723942.html
> 
> Lina Iyer (2):
>   drivers: irqchip: pdc: Add PDC interrupt controller for QCOM SoCs
>   dt-bindings/interrupt-controller: pdc: describe PDC device binding

Queued for 4.17.

	M.
-- 
Jazz is not dead. It just smells funny...
