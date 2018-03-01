Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033241AbeCAQph (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033027AbeCAQpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:45:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1C8217AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELsT64ruWKMc210jXgWYeWRiBzKFELvsChaAQlN4AoSsfYkJjhZhChb5hPUruiXMzCiq4n4lR3qGmw7atq7Z0/U=
MIME-Version: 1.0
In-Reply-To: <20180301163815.30595-2-ard.biesheuvel@linaro.org>
References: <20180301163815.30595-1-ard.biesheuvel@linaro.org> <20180301163815.30595-2-ard.biesheuvel@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 1 Mar 2018 10:44:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXaf0ROpNbdhn1+SQ+P6sF_6FqqAnbnjJ=9+EKzy3gyQ@mail.gmail.com>
Message-ID: <CAL_JsqLXaf0ROpNbdhn1+SQ+P6sF_6FqqAnbnjJ=9+EKzy3gyQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: add binding for Socionext
 SynQuacer I2C
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>,
        Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 10:38 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Add a binding for the I2C controller that can be found in the Socionext
> SynQuacer SoC.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
