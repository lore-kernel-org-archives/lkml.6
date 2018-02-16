Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032860AbeBPNvb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:51:31 -0500
Received: from foss.arm.com ([217.140.101.70]:39834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032300AbeBPNv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:51:29 -0500
Subject: Re: [PATCH v1] irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20180214154735.55233-1-andriy.shevchenko@linux.intel.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <b68d7f56-ec01-b787-5ef8-83df62ebe921@arm.com>
Date: Fri, 16 Feb 2018 13:51:27 +0000
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
> ---
>  kernel/irq/irqdomain.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Applied, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
