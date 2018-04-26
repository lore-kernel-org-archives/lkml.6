Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755890AbeDZMZW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:25:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53289 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754723AbeDZMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:25:18 -0400
X-Google-Smtp-Source: AIpwx49RDsuVF015FHB3sv1fhlC1c3qFX5ngD7CeYPs3d9eV+2O3DE3aEx82vqOfbWWtxPd0EU6egG/hArjMkWYPLKk=
MIME-Version: 1.0
In-Reply-To: <1523422726-7910-4-git-send-email-matheus@castello.eng.br>
References: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br>
 <1523422726-7910-1-git-send-email-matheus@castello.eng.br> <1523422726-7910-4-git-send-email-matheus@castello.eng.br>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 14:25:16 +0200
Message-ID: <CACRpkdaH6kgbM+3UHVJ_JfKZ367XXRhSjXhvsZ-8b0Ovbkpmew@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] pinctrl: bcm2835: Add support for output-low
 output-high properties
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

> Properties to set initial value of pin output buffer.
> This can be useful for configure hardware in overlay files, and in early boot
> for checking it states in QA sanity tests.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>

Will apply this when I apply 2/3.

You only need to resend patch 2+3.

Yours,
Linus Walleij
