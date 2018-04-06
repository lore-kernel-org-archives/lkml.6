Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeDFXQp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:16:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39848 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeDFXQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:16:43 -0400
X-Google-Smtp-Source: AIpwx4/5NCAZhwrp9Mr/EQX/lvOWHM2396z+sKGOMGYDTW905V5ODEY9k9v+Yu4+4VeE83BONL067A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180406151356.7818-3-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180406151356.7818-1-ilina@codeaurora.org>
 <20180406151356.7818-3-ilina@codeaurora.org>
Message-ID: <152305660223.94378.422604779280814924@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 [RESEND] 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Date: Fri, 06 Apr 2018 16:16:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36NGoiB008739

Quoting Lina Iyer (2018-04-06 08:13:56)
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB provides information on shared resources like clocks,
> regulators etc., probed at boot by the remote subsytem and made
> available in shared memory.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> +       reserved-memory {
> +               [...]
> +               qcom,cmd-db@85fe0000 {

Nitpick: This may want to be called 'memory@85fe0000' because we prefer
generic node names.
