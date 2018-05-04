Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeEDIpj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:45:39 -0400
Received: from foss.arm.com ([217.140.101.70]:51048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeEDIph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:45:37 -0400
Subject: Re: [PATCH v7 2/2] PCI: mediatek: Using chained IRQ to setup IRQ
 handle
To: honghui.zhang@mediatek.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com
Cc: hongkun.cao@mediatek.com, youlin.pei@mediatek.com,
        yong.wu@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com,
        xinping.qian@mediatek.com
References: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
 <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <3a2c9b1a-613b-0816-48a9-e2048ed494b4@arm.com>
Date: Fri, 4 May 2018 09:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 06:47, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Using irq_chip solution to setup IRQs in order to consist
> with IRQ framework.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Thanks for going the extra mile and fixing this driver.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
