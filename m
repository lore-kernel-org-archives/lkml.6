Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEBLtZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:49:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38569 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeEBLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:49:19 -0400
X-Google-Smtp-Source: AB8JxZpDnW31I/x/TH4GyBbcyvYs2dfscd5ZqTdjloKR8emAzkCO9Rb1okJKFq4kxhcbniXwKNO6nP3xW/E2gmSvd1s=
MIME-Version: 1.0
In-Reply-To: <20180501030047.305-1-manivannan.sadhasivam@linaro.org>
References: <20180501030047.305-1-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 13:49:18 +0200
Message-ID: <CACRpkdbvMSJf5C8cymsRnQts9AX3VrDbSszL0ak6=JcYP7q1NA@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: actions: Fix Kconfig dependency and help text
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 5:00 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> 1. Fix Kconfig dependency for Actions Semi S900 pinctrl driver which
> generates below warning in x86:
>
> WARNING: unmet direct dependencies detected for PINCTRL_OWL
>   Depends on [n]: PINCTRL [=y] && (ARCH_ACTIONS || COMPILE_TEST [=n]) && OF [=n]
>   Selected by [y]:
>   - PINCTRL_S900 [=y] && PINCTRL [=y]
>
> 2. Add help text for OWL pinctrl driver
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied with Randy's tags.

Yours,
Linus Walleij
