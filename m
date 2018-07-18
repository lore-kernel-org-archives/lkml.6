Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B9CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A3E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A3E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGRQOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:14:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731025AbeGRQOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:14:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87EC268FDF4A5;
        Wed, 18 Jul 2018 23:36:13 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 23:36:10 +0800
Subject: Re: [PATCH 0/3] ARM: hisi: fix of_iomap errors
To:     Nicholas Mc Guire <hofrat@osadl.org>
References: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
CC:     Wang Long <long.wanglong@huawei.com>,
        Haifeng Yan <yanhaifeng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B4F5E65.4050503@hisilicon.com>
Date:   Wed, 18 Jul 2018 16:36:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

On 2018/7/12 10:28, Nicholas Mc Guire wrote:
> This patch set addresses two issues in arch/arm/mach-hisi/hotplug.c
> 
> 1) The hisi hotplug functions were using a few unchecked 
>    of_iomap() while at the same time the system relied on
>    those mappings. Checks for !NULL were inserted.
> 
> 2) Further some mandatory of_node_put() were missing and have
>    been inserted.
> 
> 
> .
> 

Thanks!
Applied all the 3 patches to the hisilicon SoC tree.

Best Regards,
Wei

