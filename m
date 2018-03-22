Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeCVLtf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:49:35 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40772 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeCVLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:49:32 -0400
X-Google-Smtp-Source: AG47ELtv8Ty9usQNOW0mEPARgs72eG4soH9xQiIDcTNvlGM5U4JCcxudAbX0PQNCduzKTa44aH3y9+sa4qr/A7QfIys=
MIME-Version: 1.0
In-Reply-To: <7aca5ef736b6bf761133f282e022dd819c76e9c6.1521667677.git.ivan.gorinov@intel.com>
References: <cover.1521667677.git.ivan.gorinov@intel.com> <7aca5ef736b6bf761133f282e022dd819c76e9c6.1521667677.git.ivan.gorinov@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Mar 2018 13:49:31 +0200
Message-ID: <CAHp75VfgFy9dAeqi41jwgDg9NMemVQVic8UzaWDEUen4LpKn4g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] x86/devicetree: Use CPU description from Device Tree
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

On Wed, Mar 21, 2018 at 11:35 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> Current x86 Device Tree implementation does not support multiprocessing.
> Use new DT bindings to describe the processors.

Neither changelog, nor the code doesn't reflect how you mitigate the
issue kbuild bot reported about.
Care to address?

> +       smp_found_config = 1;
>         dtb_setup_hpet();
>         dtb_apic_setup();

-- 
With Best Regards,
Andy Shevchenko
