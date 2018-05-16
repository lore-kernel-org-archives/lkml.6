Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeEPLzU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:55:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51146 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeEPLzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:55:16 -0400
X-Google-Smtp-Source: AB8JxZpjgjQLF7XC9HSbqzDgtbZb5rwUXrflYmoP1suN/jNDjO3V+dUXC1aC4VFVj62EGyZZkjDj/MyOSQFjmFPgMQE=
MIME-Version: 1.0
In-Reply-To: <de4bade4236415f62088d68cd5fcd6fb7b67e020.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <de4bade4236415f62088d68cd5fcd6fb7b67e020.1524933096.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 13:55:15 +0200
Message-ID: <CACRpkdbShT-1Nbwg40yCRPbDq2v6Br2eerTX9Zx_=nXT9xcVjw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] DTS: Bindings: pca953x add an optional vcc-supply property
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Alexandre Courbot <gnurou@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 6:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Hardware can have a switchable Vcc supply, so let's add it to
> the bindings (the current Linux driver code already supports it).
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij
