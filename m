Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeDLJBy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:01:54 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:40575 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeDLJBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:01:52 -0400
X-Google-Smtp-Source: AIpwx49S4XJSTebugol8fHLB83qJ8szO9dD42IaDRDU2ivCkoJwRAXw6OUaM1QQMdG2zEFlTVL61vUuq9PYUQBp0q+k=
MIME-Version: 1.0
In-Reply-To: <20180404172258.7678-5-manivannan.sadhasivam@linaro.org>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org> <20180404172258.7678-5-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Apr 2018 11:01:51 +0200
Message-ID: <CACRpkdY1uO5qqyzCxO1NejhWyf7Z5U430EgjvDG5ujGKzjt=yw@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 7:22 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add gpio nodes for Actions Semi S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Renamed from "gpio nodes" to "gpio bindings" and applied
for v4.18 with Rob's ACK.

Yours,
Linus Walleij
