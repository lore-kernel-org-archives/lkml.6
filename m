Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161834AbeCAU6d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:58:33 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34540 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161721AbeCAU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:58:27 -0500
X-Google-Smtp-Source: AG47ELvqynF4su5BZt8dizEio0uFyb8tiah+fDRdLro2fhIXPuSVCBmKFhJW9IoDirUNWuG2G0dk9UkUFTWwwqfBbw0=
MIME-Version: 1.0
In-Reply-To: <20180222152247.10554-1-niklas.cassel@axis.com>
References: <20180222152247.10554-1-niklas.cassel@axis.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 21:58:26 +0100
Message-ID: <CACRpkdbns2=v53+cypYu0RhrsWnFUsd-og6WeGS0shDXg55StA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: artpec6: add missing pin group uart5nocts
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jesper Nilsson <jespern@axis.com>, Lars Persson <larper@axis.com>,
        Niklas Cassel <niklass@axis.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@axis.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 4:22 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:

> Add missing pin group uart5nocts (all pins except cts), which has been
> supported by the artpec6 pinctrl driver since its initial submission.
>
> Fixes: 00df0582eab1 ("pinctrl: Add pincontrol driver for ARTPEC-6 SoC")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Patch applied.

Yours,
Linus Walleij
