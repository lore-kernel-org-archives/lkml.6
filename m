Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbeBVM5L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:57:11 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:44528 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753750AbeBVM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:57:08 -0500
X-Google-Smtp-Source: AG47ELtTlVgrz8ce5zdau7VcZrNF/zDKKg9/BGEH96pGsHYrGXUCLPrmBC/8LojqNyPf0eLuJuKUCL4yWHc6jbnyfyM=
MIME-Version: 1.0
In-Reply-To: <20180209120732.17863-3-j.neuschaefer@gmx.net>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net> <20180209120732.17863-3-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 13:57:07 +0100
Message-ID: <CACRpkdZKLm2owgVu7-f80dOdQDzQKCbO2Vvh3QHfOpEzndMxxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MCvGWb017185

On Fri, Feb 9, 2018 at 1:07 PM, Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:

> The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> that supports a configurable number of pins (up to 32), interrupts, and
> some special mechanisms to share the controller between the system's
> security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> not supported.
>
> This patch adds a basic driver for this GPIO controller. Interrupt
> support will come in a later patch.
>
> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Cc: Albert Herranz <albert_herranz@yahoo.es>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> <---
>
> v3:
> - Do some style cleanups, as suggest by Andy Shevchenko

Patch applied to the GPIO tree for v4.17 with all the review tags.

I just folded the changelog into the commit message, for new
drivers it is sometimes useful to keep these around in
git actually.

If any further changes are needed we can just patch on top
of this.

It's a very pretty driver, good work!

Yours,
Linus Walleij
