Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeCUIEx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:04:53 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:39235 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeCUIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:04:45 -0400
X-Google-Smtp-Source: AG47ELtvAFtzITFFq3JBEEb2ka0mUPW1mQXJ1ArCo3rmzjNFWDwyBBoTlPHu9ckycPtpInci85TEx0GF1fojNkV57BA=
MIME-Version: 1.0
In-Reply-To: <20180226130558.7634-8-rf@opensource.cirrus.com>
References: <20180226130558.7634-1-rf@opensource.cirrus.com> <20180226130558.7634-8-rf@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Mar 2018 09:04:44 +0100
Message-ID: <CACRpkdaRm84UZw1K5cOsp9wAt5tkMEtiLxz20Gg3a3QSO-+MYw@mail.gmail.com>
Subject: Re: [PATCH v8 7/9] pinctrl: madera: Add DT bindings for Cirrus Logic
 Madera codecs
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, patches@opensource.cirrus.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 2:05 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> This is the binding description of the pinctrl driver for Cirrus Logic
> Madera codecs. The binding uses the generic pinctrl binding so  the main
> purpose here is to describe the device-specific names for groups and
> functions.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Tell me if you want me to just merge this patch to get your patch stack
smaller.

Yours,
Linus Walleij
