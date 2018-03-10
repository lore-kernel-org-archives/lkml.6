Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbeCJN5r (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:57:47 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33923 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932863AbeCJN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:57:44 -0500
X-Google-Smtp-Source: AG47ELvZPizDvd+nrfTGC7dzeCLtZXnAGz7nLAhULxkaZFLtyEWUADz4XkXEZydbNom98vN4hmDd7EDYHhaZbwWYw8c=
MIME-Version: 1.0
In-Reply-To: <1520287361-12569-2-git-send-email-tharvey@gateworks.com>
References: <1520287361-12569-1-git-send-email-tharvey@gateworks.com> <1520287361-12569-2-git-send-email-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 10 Mar 2018 10:57:43 -0300
Message-ID: <CAOMZO5Cw+XW_G_euCL5itmuvfxDDnWWHqg2EjPTCVkuTzqXHug@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add Gateworks System Controller bindings
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Mon, Mar 5, 2018 at 7:02 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> +
> +                       hwmon@1 { /* A1: Input Voltage */
> +                               type = <1>;
> +                               reg = <0x02>;

Unit address (@1) does not match the 'reg' value.

If someone build this example with W=1 a warning will be shown.

Same problem happens in other places of this example.
