Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeEPMzE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:55:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38969 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbeEPMzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:55:02 -0400
X-Google-Smtp-Source: AB8JxZqUpscPo4dDehHSFXUuY8KlnRVb/wx44H1tIsueGvlibGaFyXnUGT+Ta8UQ5pOgESzAzEAOPABA7q/CODOTkbE=
MIME-Version: 1.0
In-Reply-To: <20180507022555.31645-1-chris.packham@alliedtelesis.co.nz>
References: <20180507022555.31645-1-chris.packham@alliedtelesis.co.nz>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 14:55:00 +0200
Message-ID: <CACRpkdbAaMrHJ8TjJTtNyVtoOSRAEf2Z8gRthFH0ze4RyybBag@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mvebu: use correct MPP sel value for dev pins
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 4:25 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> The "dev" function is selected with the value 0x4 not 0x01.
>
> Fixes: commit d7ae8f8dee7f ("pinctrl: mvebu: pinctrl driver for 98DX3236 SoC")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Patch applied.

Does it need to go into fixes? Stable?

Yours,
Linus Walleij
