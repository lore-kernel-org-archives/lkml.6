Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeDXM2y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:28:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51497 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeDXM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:28:50 -0400
X-Google-Smtp-Source: AIpwx4/ssu7GL7kYvfhqPYGCX7cmmKoA3P6dXSZy/tqJfsEIMsLGXeqB8w65vRVHLLWqzaU/K8KECg==
MIME-Version: 1.0
In-Reply-To: <20180423063239.3988-3-jagan@amarulasolutions.com>
References: <20180423063239.3988-1-jagan@amarulasolutions.com> <20180423063239.3988-3-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 24 Apr 2018 20:28:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v64oW_aFXQQrNy3out--MsC6yfoHi3w+zZWVyByuyghhBA@mail.gmail.com>
Message-ID: <CAGb2v64oW_aFXQQrNy3out--MsC6yfoHi3w+zZWVyByuyghhBA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: allwinner: a64: bananapi-m64: add usb otg
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
> Add usb otg support for bananapi-m64 board,
> - USB-ID connected with PH9
> - USB-DRVVBUS controlled by N_VBUSEN pin from PMIC
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied with subject prefix changed to "arm64: dts: allwinner: ...".
