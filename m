Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeENHIn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:08:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53467 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbeENG64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 02:58:56 -0400
X-Google-Smtp-Source: AB8JxZpDloHEAq6TZVKBZXOQI8tg79Z8CLlZJd9sZ/In5U92tw7MqjF1B8wo2X2m5wSyuo5Mq+6J2Q==
Date: Mon, 14 May 2018 08:58:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/x86: Clean up the eboot code a bit
Message-ID: <20180514065852.GE16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-16-ard.biesheuvel@linaro.org>
 <20180514064323.GB16596@gmail.com>
 <CAKv+Gu-v-dw28pjo_8of_dNR7mEMK3ngDUksFYUTWwro14PFfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-v-dw28pjo_8of_dNR7mEMK3ngDUksFYUTWwro14PFfw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 14 May 2018 at 08:43, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > So I looked at arch/x86/boot/compressed/eboot.c to improve a printk message and
> > ended up with the cleanups below.
> >
> > Only build tested.
> >
> > Thanks,
> >
> >         Ingo
> >
> > =================>
> > Subject: efi/x86: Clean up the eboot code
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Mon May 14 08:33:40 CEST 2018
> >
> > Various small cleanups:
> >
> >  - Standardize printk messages:
> >
> >      'alloc' => 'allocate'
> >      'mem'   => 'memory'
> >
> >    also put variable names in printk messages between quotes.
> >
> >  - Align mass-assignments vertically for better readability
> >
> >  - Break multi-line function prototypes at the name where possible,
> >    not in the middle of the parameter list
> >
> >  - Use a newline before return statements consistently.
> >
> >  - Use curly braces in a balanced fashion.
> >
> >  - Remove stray newlines.
> >
> > No change in functionality.
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Matt Fleming <matt@codeblueprint.co.uk>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-efi@vger.kernel.org
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Thanks Ingo
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks - mind picking it up into your tree? I only did minimal testing and don't 
want to interfere with your patch flow either.

Thanks,

	Ingo
