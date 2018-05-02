Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEBMUy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:20:54 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34930 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeEBMUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:20:51 -0400
X-Google-Smtp-Source: AB8JxZpTkdAZ3c09c5azGPgb7YWbjfXSLF9xm8S4xUV5A7giOK89xLO0D4NpxWz0c+I+IgLsGhYCsO2rXsG0DFk4p98=
MIME-Version: 1.0
In-Reply-To: <20180426212744.28688-1-robh@kernel.org>
References: <20180426212744.28688-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 14:20:50 +0200
Message-ID: <CACRpkdZVT1wRaEmBAD1m-BMMZSEYxyU0jpAfMPmiT8H0TyMVDw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: move various timer bindings to timer/ directory
To: Rob Herring <robh@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 11:27 PM, Rob Herring <robh@kernel.org> wrote:

> Bindings are supposed to be organized by device class/function. Move
> bindings for various timers to timer/ binding directory.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you for bringing some order.

Yours,
Linus Walleij
