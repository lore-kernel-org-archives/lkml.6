Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeDIHd7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:33:59 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34949 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:33:57 -0400
X-Google-Smtp-Source: AIpwx49/RZeulky1+1j9MrWZryyjRpbguIEMPcjuzDeJP5NOwVsUcxetqXPIYpkU2itXfOPWyGixUg==
MIME-Version: 1.0
In-Reply-To: <20180406140344.9457-1-icenowy@aosc.io>
References: <20180406140344.9457-1-icenowy@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 9 Apr 2018 15:33:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v651vpy3jdFY56CQi4yBU1wh01ecPn9cO9fiXkfed35QDA@mail.gmail.com>
Message-ID: <CAGb2v651vpy3jdFY56CQi4yBU1wh01ecPn9cO9fiXkfed35QDA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3] ARM: sun8i: v40: enable USB host ports
 for Banana Pi M2 Berry
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 10:03 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M2 Berry has an on-board USB Hub that provides 4 USB Type-A
> ports, and it's connected to the USB1 port of the SoC.
>
> Enable it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Verified against public schematics.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
