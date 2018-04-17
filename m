Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeDQDNk convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:13:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34341 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeDQDNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:13:36 -0400
X-Google-Smtp-Source: AIpwx49fSndvWwqYHk/FwDgqdL3Sud3qWi1wj7pOAVjdij7WE69EUe3s/zczA/EQJ39QeU8L3Pb+AQ==
MIME-Version: 1.0
In-Reply-To: <20180416215032.5023-4-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com> <20180416215032.5023-4-mylene.josserand@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 17 Apr 2018 11:13:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v67b_-RTF2HyNE5NoWTiHy9BDPR95sxvOYzGbz7=qP_ewA@mail.gmail.com>
Message-ID: <CAGb2v67b_-RTF2HyNE5NoWTiHy9BDPR95sxvOYzGbz7=qP_ewA@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] ARM: dts: sun8i: Add R_CPUCFG device node for
 the A83T dtsi
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 5:50 AM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> The R_CPUCFG is a collection of registers needed for SMP bringup
> on clusters and cluster's reset.
> For the moment, documentation about this register is found in
> Allwinner's code only.
>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
