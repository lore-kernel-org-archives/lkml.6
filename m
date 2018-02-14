Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031923AbeBNQIU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:08:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52903 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031287AbeBNQIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:08:19 -0500
Date: Wed, 14 Feb 2018 17:08:22 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro
In-Reply-To: <73440b22-0460-cfb2-1ba2-f9a29040e0e4@arm.com>
Message-ID: <alpine.DEB.2.21.1802141707070.1519@nanos.tec.linutronix.de>
References: <20180214154735.55233-1-andriy.shevchenko@linux.intel.com> <73440b22-0460-cfb2-1ba2-f9a29040e0e4@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Marc Zyngier wrote:

> On 14/02/18 15:47, Andy Shevchenko wrote:
> > ...instead of open coding file operations followed by custom ->open()
> > callbacks per each attribute.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Too late... ;-)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/irq/irqdomain.c?id=c5baa1be8f559d5f33c412d00cc1c86762a8bbbf

You're slighly off. The patch is against the CONFIG_GENERIC_IRQ_DEBUGFS
infrastructure and that's still there :)
