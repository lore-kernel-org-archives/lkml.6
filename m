Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeBZN6T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:58:19 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:36439 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeBZN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:58:13 -0500
X-Google-Smtp-Source: AG47ELvc0kr1AX7l0/KYV38Yqmnp0p94RRbjId1SNZwsWvZBC7iYfkbR+RMsYAHgaoPxMli4OMv8IMaXJG0g0TlPMMI=
MIME-Version: 1.0
In-Reply-To: <20180226130558.7634-4-rf@opensource.cirrus.com>
References: <20180226130558.7634-1-rf@opensource.cirrus.com> <20180226130558.7634-4-rf@opensource.cirrus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Feb 2018 10:58:12 -0300
Message-ID: <CAOMZO5DEiwUBsMWfR-a6UgEkEeXvWqXPFAf0pPcwpeJY540xGg@mail.gmail.com>
Subject: Re: [PATCH v8 3/9] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:05 AM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> --- /dev/null
> +++ b/drivers/mfd/madera-core.c
> @@ -0,0 +1,602 @@
> +// SPDX-License-Identifier: GPL-2.0

As you use SPDX line here....

> +/*
> + * Core MFD support for Cirrus Logic Madera codecs
> + *
> + * Copyright (C) 2015-2018 Cirrus Logic
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2.

You can remove this paragraph.

Same applies to the other places of this series.
