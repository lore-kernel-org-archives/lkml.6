Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBCAB6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:01:58 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:41398 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBCABw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:01:52 -0500
X-Google-Smtp-Source: AH8x2253Rarj01JTaZsR7+TbpUCxWGvh+CANQQ5e2wS44HRWBEWyTAFmPivLqtDj4Lla6PUk+O+SzUSJGFiuCFO/LZs=
MIME-Version: 1.0
In-Reply-To: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Feb 2018 22:01:51 -0200
Message-ID: <CAOMZO5AKkutCx5y8z8XUniaynsUda1dwrZRa=vgWTCqOJu=tgA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: imx: Pass empty memory size on board dts
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
> In preparation for removing 'reg = <0 0>;' from the dtsi SoC files, pass
> 'reg = <0 0 >;' to the dts/dtsi board files that do not pass the memory
> size.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
