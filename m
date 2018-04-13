Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeDMPTG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeDMPTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:19:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C4D2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx4874ekNTE4XNzy+HTuv7tcZzpiEM2YBwv9RmZTobevpw11G1nX2e0aM45bowmzmphtEBAq1R9Lx3gOIXwrYdAY=
MIME-Version: 1.0
In-Reply-To: <95fa67c09ef009675f6989662b657b6c8b9ac839.1523376423.git.hns@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com> <95fa67c09ef009675f6989662b657b6c8b9ac839.1523376423.git.hns@goldelico.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 13 Apr 2018 10:18:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJe+guBSWShfBYDf2Jbwa7ue=gU1jgrOVeiRJZj1f0J5A@mail.gmail.com>
Message-ID: <CAL_JsqJe+guBSWShfBYDf2Jbwa7ue=gU1jgrOVeiRJZj1f0J5A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] DTS: Bindings: pca953x: add example how to use
 interrupt-controller and gpio-controller
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:07 AM, H. Nikolaus Schaller
<hns@goldelico.com> wrote:
> It is not completely obvious that these are required and
> how to use them. So we provide a tested example.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/gpio/gpio-pca953x.txt      | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
