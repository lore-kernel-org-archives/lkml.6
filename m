Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeBSLDt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:03:49 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:44925 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeBSLDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:03:47 -0500
X-Google-Smtp-Source: AH8x226LAihgLK6wLtZAeUpJObaft2/hFdmNstEt/Sj53IczpR6aAHw3fQ8rOl0gHABXGlA9GwlI9eGiPtB53XeysrY=
MIME-Version: 1.0
In-Reply-To: <1519037225-22872-1-git-send-email-LW@KARO-electronics.de>
References: <1519037225-22872-1-git-send-email-LW@KARO-electronics.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2018 08:03:46 -0300
Message-ID: <CAOMZO5B3=eL7dRYFzKcCUXDLRS9ZjjmpSZc6s=o0S1A1W4=zQA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6dl: remove 'lcdif' node
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
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
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1JB3rSO031345

On Mon, Feb 19, 2018 at 7:47 AM, Lothar Waßmann <LW@karo-electronics.de> wrote:
> According to the "i.MX 6Solo/6DualLite Applications Processor
> Reference Manual" Rev. 3, 09/2017 there is no LCDIF unit on the
> i.MX6DL.
>
> Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
