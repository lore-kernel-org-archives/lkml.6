Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeBCAC3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:02:29 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42289 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBCACX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:02:23 -0500
X-Google-Smtp-Source: AH8x227OIa+/Cpqe/L8nnavhjtuNj5WhYEOiPPQGF2UnFmpPI7/5IUkwV4C+gPlaKReZYSP0DByr58wsuXSysXjjkWo=
MIME-Version: 1.0
In-Reply-To: <1516800134-5018-2-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com> <1516800134-5018-2-git-send-email-marcofrk@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Feb 2018 22:02:22 -0200
Message-ID: <CAOMZO5DtiRgkYkkjv4hmt-1QFD3Ys0rzjcUFGxBXPYM-trOoAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: imx: Remove empty memory size nodes
To: Marco Franchi <marcofrk@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Marco Franchi <marco.franchi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 11:22 AM, Marco Franchi <marcofrk@gmail.com> wrote:
> Remove the empty reg property from the SoC dtsi files in order to avoid
> duplicate memory nodes when the correct size is passed in board dts files.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
