Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeCFWEg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:04:36 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:40222 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeCFWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:04:33 -0500
X-Google-Smtp-Source: AG47ELs0YQ/Xz4tlO1yDVm63x2GqJ+m1i2Qh89ZOnHqTyzo4r3YHQq4FK5kei5KSaWd7LqpzOrCytvFW/oTCLr+G97E=
MIME-Version: 1.0
In-Reply-To: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 6 Mar 2018 19:04:31 -0300
Message-ID: <CAOMZO5DAxDixb-mkTefd39bo6qeyNrdqd0ZxSmCUDYtKSdNrZg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 6:58 PM, Martin Kaiser <martin@kaiser.cx> wrote:
> According to the i.MX25 reference manuals, each SSI has four FIFOs. All
> of those FIFOs can store up to 15 entries.
>
> The fsl_ssi driver's internal default for the FIFO depth in 8. Set our
> non-default FIFO depth explicitly in the Device Tree.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
