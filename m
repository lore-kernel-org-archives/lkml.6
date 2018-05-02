Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeEBQxI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:53:08 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39377 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEBQxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:53:04 -0400
X-Google-Smtp-Source: AB8JxZoaPh6mvxhnyY/FSC+GTXbkItxd+rnJHB46RXgRpuZzrjHHor+53cQ/mNqZeoB9dcM1QPKVpw==
MIME-Version: 1.0
In-Reply-To: <20180501224628.GA150745@dtor-ws>
References: <20180501224628.GA150745@dtor-ws>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 2 May 2018 09:53:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOFEQwfis9ziXcG1BTH2muWPTZh-fZX9xPU4KgyNeWCPA@mail.gmail.com>
Message-ID: <CA+ASDXOFEQwfis9ziXcG1BTH2muWPTZh-fZX9xPU4KgyNeWCPA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: use canonical compatible for touchpad/touchscreen
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 3:46 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> "atmel,atmel_mxt_tp" and "atmel,atmel_mxt_ts" are ChromeOS inventions,
> let's replace them with canonical compatible string "atmel,maxtouch".
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I guess the other IDs are in the driver just for non-DT usage? Anyway,
seems fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>
