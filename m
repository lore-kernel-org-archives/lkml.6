Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeBVPUv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:20:51 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36575 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeBVPUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:20:47 -0500
X-Google-Smtp-Source: AG47ELu5/9hIRAhUy/aLdjZIuoqT6vpY3TyLcylK0EJPOSAyCYWGhkc99m0zPLjEEgkqnENL27k51pRFfkUKAMo4Jx8=
MIME-Version: 1.0
In-Reply-To: <5c573c758e07ee9539045c1b062b9bab1ad1669c.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com> <5c573c758e07ee9539045c1b062b9bab1ad1669c.1514578085.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:20:46 +0100
Message-ID: <CACRpkdbRkyzb9aML1-TEENWfpSDtjayVB_eEm9V1JKrAfaOMVA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] pc104: Add EXPERT dependency for PC104 Kconfig option
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2017 at 9:14 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> PC/104 device driver Kconfig options previously had an implicit EXPERT
> dependency by way of an explicit ISA_BUS_API dependency. Now that these
> driver Kconfig options select ISA_BUS_API rather than depend on it, the
> PC104 Kconfig option should have an explicit EXPERT dependency.
>
> The PC/104 form factor and bus architecture are common in embedded
> and specialized systems, but uncommon in typical desktop setups. For
> this reason, it is best to mask these devices and configurations via the
> EXPERT Kconfig option because the majority of users will never need to
> concern themselves with PC/104.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied to the GPIO tree for v4.17.

I don't know what kind of definition of "expert" really applies here.

Who in their right mind think that novices are using the kernel
configuration interface. Isn't anyone doing kernel compiles
entitled to be called an expert...

Anyways I guess this has already been discussed.

Yours,
Linus Walleij
