Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561AFC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D9123F9D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D9123F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFVJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:41:43 -0400
Received: from foss.arm.com ([217.140.101.70]:60662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbeFVJlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:41:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34AF11596;
        Fri, 22 Jun 2018 02:41:42 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4DD3F819;
        Fri, 22 Jun 2018 02:41:41 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Mawanda Henry <mawandahenrynaco@gmail.com>
Cc:     mawanda111@gmail.com, robin.murphy@arm.com, arnd@arndb.de,
        peterz@infradead.org, tglx@linutronix.de, marc.zyngier@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers/bus: arm-cci: use SPDX license information
References: <20180622080725.GA6576@sesnaco>
Date:   Fri, 22 Jun 2018 10:41:40 +0100
In-Reply-To: <20180622080725.GA6576@sesnaco> (Mawanda Henry's message of "Fri,
        22 Jun 2018 11:07:25 +0300")
Message-ID: <87muvn17l7.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mawanda Henry <mawandahenrynaco@gmail.com> writes:

> SPDX license helps developers and machines to know the license governing
> a particular file hence easing work
>
> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/bus/arm-cci.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index b8184a9..74a2e0a 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Please use GPL-2.0 as per the below text.

While you're updating this can you also update the MODULE_LICENSE() at
the end of the file to "GPL v2".

>  /*
>   * CCI cache coherent interconnect driver
>   *
>   * Copyright (C) 2013 ARM Ltd.
>   * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/arm-cci.h>
