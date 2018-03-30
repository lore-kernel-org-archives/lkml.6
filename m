Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC3JjE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:39:04 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39031 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeC3Ji7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:38:59 -0400
X-Google-Smtp-Source: AIpwx4+5kveVLrS8HVIFnyzA3Xq8AK2CPKVYACTGKoDvejWsQbG53xtJGTgFtV8nTHISqT4wRYphig==
MIME-Version: 1.0
In-Reply-To: <1513011400-4120-3-git-send-email-jagan@amarulasolutions.com>
References: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com> <1513011400-4120-3-git-send-email-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Mar 2018 17:38:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v673V4-jU2WLZA2rJ9+TAU8ehuNzXw+P+PHQeRu3nXC+AQ@mail.gmail.com>
Message-ID: <CAGb2v673V4-jU2WLZA2rJ9+TAU8ehuNzXw+P+PHQeRu3nXC+AQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: allwinner: a64: bananapi-m64: add usb otg
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
> Add usb otg support for bananapi-m64 board,
> - USB-ID connected with PH9
> - USB-DRVVBUS controlled by N_VBUSEN pin from PMIC
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Move the position of reg_drivevbus as per binding documentation.

The label dereferences should be ordered in alphabetical order of
the label names.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
