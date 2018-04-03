Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbeDCGpv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:45:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32909 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeDCGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:45:49 -0400
X-Google-Smtp-Source: AIpwx4+uOu/m8Y2F8NNC4uhoVL+eUAs2qK2t5yTK72ivOVMCsLqeQTwRgyoV5Vg8ZWndbU1sK1nN2w==
MIME-Version: 1.0
In-Reply-To: <20180403061836.3926-5-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com> <20180403061836.3926-5-mylene.josserand@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 3 Apr 2018 14:45:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v64kkm5qNNi-BD55nYUn9e=tfJZ8fKhJrs=mB=fMWrRBcA@mail.gmail.com>
Message-ID: <CAGb2v64kkm5qNNi-BD55nYUn9e=tfJZ8fKhJrs=mB=fMWrRBcA@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> As we found in sun9i-a80, CPUCFG is a collection of registers that are
> mapped to the SoC's signals from each individual processor core and
> associated peripherals.
>
> These registers are used for SMP bringup and CPU hotplugging.
>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
