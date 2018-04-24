Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeDXM2e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:28:34 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52512 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDXM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:28:31 -0400
X-Google-Smtp-Source: AIpwx4/Y9NuWuakYgJbM3Muhggh65mW+Tsn+me5ODktEMMpN8OhZoQhqNN9HhjIFCCIkRJT+MvdIgQ==
MIME-Version: 1.0
In-Reply-To: <20180423063239.3988-2-jagan@amarulasolutions.com>
References: <20180423063239.3988-1-jagan@amarulasolutions.com> <20180423063239.3988-2-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 24 Apr 2018 20:28:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v64g55zNevUaEPziKu9aG2CFGEkE=trUhwcJy2oV9Jdcag@mail.gmail.com>
Message-ID: <CAGb2v64g55zNevUaEPziKu9aG2CFGEkE=trUhwcJy2oV9Jdcag@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] arm64: allwinner: axp803: Add drivevbus regulator
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Mark Brown <broonie@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 2:32 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Add reg_drivevbus regualtor for boards which are using
> external regulator to drive the OTG VBus through N_VBUSEN
> PMIC pin.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied with subject prefix changed to "arm64: dts: allwinner: ...".
