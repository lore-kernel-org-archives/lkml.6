Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeBPT1l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:27:41 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34799 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeBPT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:27:37 -0500
X-Google-Smtp-Source: AH8x2242PUXGEDD4yjVrkW5v54RGiPENbbSieDogVDfuUTu9XOiltA4IPl4n1R4LzKhFXnKBOo+5rgH9fXa1+xxH6bw=
MIME-Version: 1.0
In-Reply-To: <20180216060503.22006-2-rnayak@codeaurora.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org> <20180216060503.22006-2-rnayak@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 16 Feb 2018 11:27:35 -0800
X-Google-Sender-Auth: c47tDY3O_jMNWsVIwlOAyN2TSI4
Message-ID: <CAD=FV=Vu5CaXz2HK5gXqi4cVNE__vBcae0op0jn5JG__ix8bRA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: Document kryo385 cpu
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 15, 2018 at 10:05 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Document the compatible string for the Kryo385 cpus found in qualcomm
> SoCs.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)

FWIW since my review doesn't add much atop Rob's:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
