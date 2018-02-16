Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeBPT1v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:27:51 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45491 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeBPT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:27:47 -0500
X-Google-Smtp-Source: AH8x2261RzECd4TlycXoRfs4JR8L3HFAwjeNAqC8JR49yT1uvT743Czg3y7sGZnY9VCHlzCig3b3KifyXAgjgKB/iR4=
MIME-Version: 1.0
In-Reply-To: <20180216060503.22006-3-rnayak@codeaurora.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org> <20180216060503.22006-3-rnayak@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 16 Feb 2018 11:27:45 -0800
X-Google-Sender-Auth: zC-P34KPfLnoceuibxQBPjCU_t0
Message-ID: <CAD=FV=X++6aBiV9Wag8nP9R5wJymPj5SVVgESUemKBoM==Ovrw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: qcom: Add SDM845 bindings
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
> Add a SoC string 'sdm845' for the qualcomm SDM845 SoC
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
