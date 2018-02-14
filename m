Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031302AbeBNVX0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:23:26 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33670 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030977AbeBNVXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:23:24 -0500
X-Google-Smtp-Source: AH8x227EIfF9OnanK/eo2zEhD6uZ9AtzIS5lf/lF77ofX6k9aPP1XOJwf4GgKt4RuQeAwS1MwLgqGVyViRjm5zLj+EE=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW0SYdwNNWfzNttY8xdfnB-oLR4MvhWpO7Pks-WY76=3g@mail.gmail.com>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org> <CAMuHMdW0SYdwNNWfzNttY8xdfnB-oLR4MvhWpO7Pks-WY76=3g@mail.gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Wed, 14 Feb 2018 22:22:42 +0100
Message-ID: <CAOFm3uH08oBUiJSs7sOrThqXjLP0Tp1ur2mV-xvxHgoAVMNpUg@mail.gmail.com>
Subject: Re: [PATCH 05/15] ARM64: dts: Add R-Car Salvator-x M3-N support
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacopo,

On Wed, Feb 14, 2018 at 2:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.

This should be GPL-2.0

<snip>

>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>> @@ -0,0 +1,495 @@
>> +// SPDX-License-Identifier: GPL-2.

This should be GPL-2.0 too.
-- 
Cordially
Philippe Ombredanne
