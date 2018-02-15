Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166889AbeBOSqJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:46:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162591AbeBOSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:46:06 -0500
To: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: CONFIG_IRQ_TIMINGS?
Message-ID: <8ae9d59b-7499-87cd-702f-c722b9a77939@infradead.org>
Date: Thu, 15 Feb 2018 10:46:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is this a dead kconfig symbol?  I don't see any Kconfig file that
sets/enables it.

./kernel/irq/Makefile:4:obj-$(CONFIG_IRQ_TIMINGS) += timings.o
./kernel/irq/internals.h:#ifdef CONFIG_IRQ_TIMINGS
./kernel/irq/internals.h:#endif /* CONFIG_IRQ_TIMINGS */
./include/linux/interrupt.h:#ifdef CONFIG_IRQ_TIMINGS

thanks,
-- 
~Randy
