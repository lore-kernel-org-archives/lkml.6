Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeC3Jje (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:39:34 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33134 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeC3Jj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:39:29 -0400
X-Google-Smtp-Source: AIpwx4+l5d5eQ4lfFVooR/n6hIfvg7wDkvf94zFo147Lw1g7NR8z31zU7/yYEBIHVFKa+kHzWORRlQ==
MIME-Version: 1.0
In-Reply-To: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com>
References: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Mar 2018 17:39:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v66xYHHXWkLdovXVsQNPfsJSgZReTUYp_UH=LOk9_MXMCw@mail.gmail.com>
Message-ID: <CAGb2v66xYHHXWkLdovXVsQNPfsJSgZReTUYp_UH=LOk9_MXMCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] regulator: axp20x: add drivevbus support for axp803
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
> Like axp221, axp223, axp813 the axp803 is also supporting external
> regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
>
> Add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
