Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC3JjQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:39:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51305 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeC3JjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:39:11 -0400
X-Google-Smtp-Source: AIpwx4+T0WkOdqXAhf94xgKUUPnRabi2PA5wsPfnAgjywrTpWzor+YnftoAx2OwwL1Z2Sy2UnzIFIQ==
MIME-Version: 1.0
In-Reply-To: <1513011400-4120-2-git-send-email-jagan@amarulasolutions.com>
References: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com> <1513011400-4120-2-git-send-email-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Mar 2018 17:38:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v66m6hKz9OTaBgp9SoyPSXLgqUQDt4=mH8V2XTEzm7OM0Q@mail.gmail.com>
Message-ID: <CAGb2v66m6hKz9OTaBgp9SoyPSXLgqUQDt4=mH8V2XTEzm7OM0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: allwinner: axp803: Add drivevbus regulator
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2017 at 12:56 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Add reg_drivevbus regualtor for boards which are using
> external regulator to drive the OTG VBus through N_VBUSEN
> PMIC pin.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
