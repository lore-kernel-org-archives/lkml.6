Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeCWQ0o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:26:44 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40986 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeCWQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:26:43 -0400
X-Google-Smtp-Source: AG47ELt5DSshEDXtcqqVDrc2F3EyL1DuUIUSpLuwS5PY/MJRf5rbl5hn7v+Uwij7AvnHtw8GhqCPrqAXwO+NWGtPuT0=
MIME-Version: 1.0
In-Reply-To: <cover.1521753738.git.ivan.gorinov@intel.com>
References: <cover.1521753738.git.ivan.gorinov@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Mar 2018 18:26:42 +0200
Message-ID: <CAHp75VczQ9gxseTtBTxbnusorZNONKiCu4_c2X=xxARqLPWDSA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] x86/devicetree: Enable multiprocessing
To: Ivan Gorinov <ivan.gorinov@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 11:35 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> Current x86 implementation of Device Tree does not support multiprocessing,
> and the bindings documentation describes the "reg" property of "cpu" nodes
> as "CPU number" instead of hardware-assigned local APIC ID.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> v8:
>  * Fixed build error with CONFIG_X86_LOCAL_APIC=n reported by kbuild.
>
> v7:
>  * Change log update.
>
> v6:
>  * Calling of_property_read_u32() to get Local APIC ID from "reg".
>
>  * DT documentation changes: corrected CPU node example and changed
>    the "reg" property description.
>
> v5:
>  * Using the "reg" property to specify Local APIC ID.
>
> Ivan Gorinov (2):
>   of: Documentation: Specify local APIC ID in "reg"
>   x86/devicetree: Use CPU description from Device Tree
>
>  Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++-----
>  arch/x86/kernel/devicetree.c                     | 45 +++++++++++++++++-------
>  2 files changed, 61 insertions(+), 21 deletions(-)
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
