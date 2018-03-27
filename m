Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeC0Nsi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:48:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36092 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeC0Nsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:48:36 -0400
X-Google-Smtp-Source: AIpwx49ppnqokldvQXoxih5qEu3YAyd3IFpM3zP0+0T7OhVJ32SUZrfrvUmIrUvOdFfsArydbspWy57lFXu8CaoUAJE=
MIME-Version: 1.0
In-Reply-To: <787c9f115db06390549bfee366b7f70faf312286.1520218279.git.baolin.wang@linaro.org>
References: <787c9f115db06390549bfee366b7f70faf312286.1520218279.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:48:35 +0200
Message-ID: <CACRpkdaRXspA2JgfQ=Q1w5fEvmPjwtHwfaqTwei2FBg0tMPeHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: gpio: Add Spreadtrum EIC controller documentation
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 3:56 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the device tree bindings for the Spreadtrum EIC
> controller. The EIC can be seen as a special type of GPIO, which
> can only be used as input mode.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v2:
>  - Add reviewed tag from Rob.

Patch applied.

Yours,
Linus Walleij
