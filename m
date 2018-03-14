Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCNRH6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:07:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeCNRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:07:56 -0400
Date: Wed, 14 Mar 2018 18:07:35 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Palmer Dabbelt <palmer@sifive.com>
cc: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/5] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <20180307235731.22627-4-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.1803141806580.2481@nanos.tec.linutronix.de>
References: <20180307235731.22627-1-palmer@sifive.com> <20180307235731.22627-4-palmer@sifive.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018, Palmer Dabbelt wrote:

> This converts the ARM port to use the recently added
> GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
> existhing MULTI_IRQ_HANDLER.  The only changes are:
> 
> * handle_arch_irq is now defined in a generic C file instead of an
>   arm-specific assembly file.
> * handle_arch_irq is not marked as __ro_after_init.

Why? What prevents the generic implementation from doing so?

Thanks,

	tglx
