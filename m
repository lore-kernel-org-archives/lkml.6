Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965031AbeBWTKL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:10:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57536 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754235AbeBWTKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:10:08 -0500
Date: Fri, 23 Feb 2018 20:09:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
Message-ID: <20180223190950.GJ4981@pd.tnic>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
> Borislav is seeing similar issues on larger AMD machines. The interrupt
> seems to come from BIOS/microcode during bringup of secondary CPUs and we
> have no idea why.

Paul, can you boot 4.14 and grep your dmesg for something like:

[    0.000000] spurious 8259A interrupt: IRQ7.

?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
