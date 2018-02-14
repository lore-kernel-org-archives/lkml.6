Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032099AbeBNQEh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:04:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44516 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032073AbeBNQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:04:34 -0500
Subject: Re: [PATCH v1] irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20180214154735.55233-1-andriy.shevchenko@linux.intel.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <73440b22-0460-cfb2-1ba2-f9a29040e0e4@arm.com>
Date: Wed, 14 Feb 2018 16:04:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214154735.55233-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 15:47, Andy Shevchenko wrote:
> ...instead of open coding file operations followed by custom ->open()
> callbacks per each attribute.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Too late... ;-)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/irq/irqdomain.c?id=c5baa1be8f559d5f33c412d00cc1c86762a8bbbf

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
