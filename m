Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966434AbeBPM22 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:28:28 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38815 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966412AbeBPM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:28:26 -0500
X-Google-Smtp-Source: AH8x225ghbN1ooU8t1DPBKPoVCmpGiVSmwwyiUWkcSvOF4TIREXUyg0oth532yY75/0ZHD7aYGPcVYKwy188dF09aLw=
MIME-Version: 1.0
In-Reply-To: <1518701454-22697-2-git-send-email-tali.perry1@gmail.com>
References: <1518701454-22697-1-git-send-email-tali.perry1@gmail.com> <1518701454-22697-2-git-send-email-tali.perry1@gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 16 Feb 2018 13:27:44 +0100
Message-ID: <CAOFm3uHCkv893H_y-fJthNiW0=wO23ddCkZKBdfeiOOF0GAE_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] clk: npcm7xx: add clock controler. fixed clock at DT
To: Tali Perry <tali.perry1@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Rick Altherr <raltherr@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tali,

On Thu, Feb 15, 2018 at 2:30 PM, Tali Perry <tali.perry1@gmail.com> wrote:
> --- /dev/null
> +++ b/drivers/clk/clk-npcm7xx.c
> @@ -0,0 +1,759 @@
> +/*
> + * Nuvoton NPCM7xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allow only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2018 Nuvoton Technologies tali.perry@nuvoton.com
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + * Released under the GPLv2 only.
> + */

Thank you for using the SPDX tags! but this can be streamlined a bit per [1]

The correct way would come out as this: (note the tag placement and
comment style and the removal of the now redundant unstructured
notice)

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM7xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allow only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2018 Nuvoton Technologies tali.perry@nuvoton.com
> + */

And yes you may be surprised by the use of C++ style comment for
this... This has been discussed on list and is what Linus prefers.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
