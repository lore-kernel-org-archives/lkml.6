Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBFNeO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:34:14 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35053 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBFNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:34:08 -0500
X-Google-Smtp-Source: AH8x2244PkwqglekrFsqHKL/o27DRDbozqZd8eFaw2h2V1i4NnhThO3ShSLs81u9yOE8WXbN/40kUmcULMVvlY39Luc=
MIME-Version: 1.0
In-Reply-To: <20180111060004.9333-1-bjorn.andersson@linaro.org>
References: <20180111060004.9333-1-bjorn.andersson@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 6 Feb 2018 14:34:07 +0100
Message-ID: <CACRpkdb19tbiCVeqnW=Z-6ZawxUk6NoeKFGoD28ZXMnFCmL43Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: Add Qualcomm SDM845 TLMM binding
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2018 at 7:00 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> This adds the DeviceTree binding for the Qualcomm SDM845 TLMM block.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Added qspi related functions

Folded in the small fix requested by Rob and applied for v4.17 with his
review tag.

Yours,
Linus Walleij
