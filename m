Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeDEGlm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 02:41:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37348 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeDEGlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 02:41:40 -0400
X-Google-Smtp-Source: AIpwx48E11SU+AXneMENi8LJswQsqL8MjqKRfufNNvFL28c6qA9sq5sSyIok1/D5ed+Rj/Ts0xn2foSdrLjBI+z2pqk=
MIME-Version: 1.0
In-Reply-To: <20180327053104.3812-1-jagan@amarulasolutions.com>
References: <20180327053104.3812-1-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 5 Apr 2018 12:11:39 +0530
Message-ID: <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] regulator: axp20x: add drivevbus support for axp803
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:01 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Like axp221, axp223, axp813 the axp803 is also supporting external
> regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>
> Add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes for v5:
> - Collect Chen-Yu reviewed-by tag
> Changes for v4:
> - rebase on master
> Changes for v3:
> - Update drivevbus in table of regulators

Can you pick these, has some dependency with drivevbus on other patches.

Jagan.
