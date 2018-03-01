Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033116AbeCAQ2b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:28:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032870AbeCAQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:28:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9CE7601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 1 Mar 2018 16:28:26 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        asathyak@codeaurora.org
Subject: Re: [PATCH v8 0/2] irqchip: qcom: add support for PDC interrupt
 controller
Message-ID: <20180301162826.GB19262@codeaurora.org>
References: <20180228172730.25022-1-ilina@codeaurora.org>
 <8768ac0b-0d1c-d415-7b51-b6785dcad05b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8768ac0b-0d1c-d415-7b51-b6785dcad05b@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01 2018 at 16:13 +0000, Marc Zyngier wrote:
>On 28/02/18 17:27, Lina Iyer wrote:
>> Changes since v7:
>> 	- fix whitespace alignment for multi-line statement
>> 	- add Rob H 'reviewed-by' for DT bindings
>> 	- rebase on top of 4.6-rc3
>>
>> On newer Qualcomm Techonologies Inc's SoCs like the SDM845, the GIC is in a
>> power domain that can be powered off when not needed. Interrupts that need to
>> be sensed even when the GIC is powered off, are routed through an interrupt
>> controller in an always-on domain called the Power Domain Controller a.k.a PDC.
>> This series adds support for the PDC's interrupt controller.
>>
>> Please consider reviewing these patches.
>>
>> RFC v1: https://patchwork.kernel.org/patch/10180857/
>> RFC v2: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1600634.html
>> v3: https://lkml.org/lkml/2018/2/6/595
>> v4: https://www.spinics.net/lists/linux-arm-msm/msg32906.html
>> v5: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1605500.html
>> v6: https://lkml.org/lkml/2018/2/9/545
>> v7: https://www.spinics.net/lists/kernel/msg2723942.html
>>
>> Lina Iyer (2):
>>   drivers: irqchip: pdc: Add PDC interrupt controller for QCOM SoCs
>>   dt-bindings/interrupt-controller: pdc: describe PDC device binding
>
>Queued for 4.17.
>
Thanks Marc.

-- Lina
