Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbeCSONH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:13:07 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:40442 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754923AbeCSONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:13:02 -0400
X-Google-Smtp-Source: AG47ELtA7AlpzwkpQYdHrAiZW/UuUJ8Ew7ritygcPM3v+vwpiNmegemMbAKkAOuNpQcBJprnML80oDzCpR8l9M+k3OU=
MIME-Version: 1.0
In-Reply-To: <20180319135326.24357-1-mporter@konsulko.com>
References: <20180319135326.24357-1-mporter@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Mar 2018 11:13:01 -0300
Message-ID: <CAOMZO5Dq3hWXKNBwqM7zFW-FjwBGLAsUJnSaUNPXO5kg=iaaGA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: hummingboard2: convert onboard audio to simple-audio-card
To: Matt Porter <mporter@konsulko.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:53 AM, Matt Porter <mporter@konsulko.com> wrote:
> The HB2 onboard audio currently makes use of the imx-audio-sgtl5000
> binding. This binding does not support auxiliary audio devices such
> as external amplifiers. The simple-audio-card binding does support
> this property which allows systems incorporating the HB2 to easily
> add an auxiliary device that's attached to the HB2 audio jack with
> an overlay. Convert HB2 to use simple-audio-card for the onboard
> audio to allow for this additional flexibility.
>
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
