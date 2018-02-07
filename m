Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeBGM3s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:29:48 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36726 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbeBGM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:29:46 -0500
X-Google-Smtp-Source: AH8x225YmcRYyrSz+EG7pur1EHQvxfFlo08m+oO7GmZM+XNxjRSH8fbRNcwGPPzdFilM6ybXKwp54rbOZEpDth9XELI=
MIME-Version: 1.0
In-Reply-To: <20180122050411.32460-4-j.neuschaefer@gmx.net>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net> <20180122050411.32460-4-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 13:29:45 +0100
Message-ID: <CACRpkdZLiw=e-XiS9cbQuJGJ2tJVV86qKaLCy2yG==FSENhAHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] gpio: Add GPIO driver for Nintendo Wii
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w17CTrvb027494

On Mon, Jan 22, 2018 at 6:04 AM, Jonathan Neuschäfer
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
> ---
>
> v2:

All looks very good to me, Andy had some additional comments,
once addressed in v3 I will apply this.

You only need to resend this patch as I already applied the DT
bindings.

Yours,
Linus Walleij
