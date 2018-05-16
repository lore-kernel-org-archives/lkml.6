Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeEPMCS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:02:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55233 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeEPMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:02:17 -0400
X-Google-Smtp-Source: AB8JxZpP4sdZ5IJMKp2ifrCiLSUTUSCFdh8W0DBogTH5KjzI9CjvlIlKx1Q6nAduyWoPgzBiFaFg83Gx32w9OTqE7Tc=
MIME-Version: 1.0
In-Reply-To: <1525135334-28506-3-git-send-email-matheus@castello.eng.br>
References: <1525030092-3643-3-git-send-email-matheus@castello.eng.br>
 <1525135334-28506-1-git-send-email-matheus@castello.eng.br> <1525135334-28506-3-git-send-email-matheus@castello.eng.br>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 14:02:15 +0200
Message-ID: <CACRpkdaz01EPL2JBzuXW=qmi68u3oPwGHZcXyZsQAExgxkxD2A@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] pinctrl: bcm2835: Add support for output-low
 output-high properties
To: Matheus Castello <matheus@castello.eng.br>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 2:42 AM, Matheus Castello
<matheus@castello.eng.br> wrote:

> Properties to set initial value of pin output buffer.
> This can be useful for configure hardware in overlay files, and in early
> boot for checking it states in QA sanity tests.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Reviewed-by: Eric Anholt <eric@anholt.net>

Patch applied with Stefan's ACK.

Yours,
Linus Walleij
