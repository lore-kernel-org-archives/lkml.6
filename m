Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeBFNh5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:37:57 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33970 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeBFNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:37:51 -0500
X-Google-Smtp-Source: AH8x225k60gUfugLOZrpbIs8urg5Qbv3auHPabwT26jz46Sp2uxL8jFOPfy1YKRXnZrPA9SE1bAmQI3OkW2uFSFUvt8=
MIME-Version: 1.0
In-Reply-To: <20180111060004.9333-2-bjorn.andersson@linaro.org>
References: <20180111060004.9333-1-bjorn.andersson@linaro.org> <20180111060004.9333-2-bjorn.andersson@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 6 Feb 2018 14:37:49 +0100
Message-ID: <CACRpkdYvLnWxQcF3188PnrCmsmSqPQPicT7HvPknOe4Akt8uKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add sdm845 pinctrl driver
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

> From: Kyle Yan <kyan@codeaurora.org>
>
> This adds the pinctrl definitions for the TLMM of SDM845.
>
> Signed-off-by: Kyle Yan <kyan@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied for v4.17.

> Changes since v1:
> - Corrected the authorship of the patch
> - Updated pin list to v2 hardware

Does that mean the v1 hardware is some prototype, only existing inside
Qualcomm & associates, all of which needs to be trashed now?

I hope it doesn't mean "oh yeah we shipped a few
million phones with that but they need to have a different kernel
and will never work with upstream".

Yours,
Linus Walleij
