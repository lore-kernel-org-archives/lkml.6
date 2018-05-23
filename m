Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeEWLqg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:46:36 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33816 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeEWLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:46:33 -0400
X-Google-Smtp-Source: AB8JxZo6c/i93GBnwVoazQWGRvY4rPinpa/E3hGkLZJS/PX8X7Gt0piyDWmKv8JgnbNPCvbv/ni5O9a1k1d2uzeTuC8=
MIME-Version: 1.0
In-Reply-To: <7c9ab1d702eb62755993321865d260fa54b90358.1526533188.git.hns@goldelico.com>
References: <cover.1526533188.git.hns@goldelico.com> <7c9ab1d702eb62755993321865d260fa54b90358.1526533188.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 13:46:31 +0200
Message-ID: <CACRpkdZoB3-EafVadGvC41AXG1i1xLkdX6g6eQEHMAyf59xHVw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] gpio: pca953x: set the PCA_PCAL flag also when
 matching by DT
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

On Thu, May 17, 2018 at 6:59 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:

> The of_device_table is missing the PCA_PCAL flag so the
> pcal6524 would be operated in tca6424 compatibility mode which
> does not handle the new interrupt mask registers.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch applied.

Yours,
Linus Walleij
