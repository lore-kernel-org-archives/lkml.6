Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032240AbeBNQOU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:14:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44650 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031982AbeBNQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:14:17 -0500
Subject: Re: [PATCH v1] irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180214154735.55233-1-andriy.shevchenko@linux.intel.com>
 <73440b22-0460-cfb2-1ba2-f9a29040e0e4@arm.com>
 <alpine.DEB.2.21.1802141707070.1519@nanos.tec.linutronix.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <9b328b27-9d85-231f-6694-e1681ad1f096@arm.com>
Date: Wed, 14 Feb 2018 16:14:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802141707070.1519@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 16:08, Thomas Gleixner wrote:
> On Wed, 14 Feb 2018, Marc Zyngier wrote:
> 
>> On 14/02/18 15:47, Andy Shevchenko wrote:
>>> ...instead of open coding file operations followed by custom ->open()
>>> callbacks per each attribute.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Too late... ;-)
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/irq/irqdomain.c?id=c5baa1be8f559d5f33c412d00cc1c86762a8bbbf
> 
> You're slighly off. The patch is against the CONFIG_GENERIC_IRQ_DEBUGFS
> infrastructure and that's still there :)

Gah, I missed that... Sorry about the noise, I'll read that more
carefully (/me grabs a brown paper bag...).

	M.
-- 
Jazz is not dead. It just smells funny...
