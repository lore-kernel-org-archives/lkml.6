Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755611AbeDZMVZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:21:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35580 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754958AbeDZMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:21:22 -0400
X-Google-Smtp-Source: AIpwx488MxYWh3BzZXN375pwCgBZtIeMuu+qhCjqFZqAIA3AFcJQERBt01/vO9VkRA5n6zsQ0lUNHbjGxREvV0W0osE=
MIME-Version: 1.0
In-Reply-To: <1523422726-7910-2-git-send-email-matheus@castello.eng.br>
References: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br>
 <1523422726-7910-1-git-send-email-matheus@castello.eng.br> <1523422726-7910-2-git-send-email-matheus@castello.eng.br>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 14:21:20 +0200
Message-ID: <CACRpkdZTA495jAOo4zPb6_Tp1Ng9f3M2LtA+ENgZigVE4ChaOQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: pinctrl: bcm2835-gpio: Add generic
 pinctrl support
To: Matheus Castello <matheus@castello.eng.br>
Cc: Rob Herring <robh@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 6:58 AM, Matheus Castello
<matheus@castello.eng.br> wrote:

> Added generic pin configuration and multiplexing support,
> and should be preferred than brcm legacy one.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>

Patch applied with Eric's and Rob's ACKs.

Yours,
Linus Walleij
