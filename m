Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeBEGIC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:08:02 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46012 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeBEGHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:07:30 -0500
X-Google-Smtp-Source: AH8x226neDeqrZ1hBAWTJDg6dRcU4NRjwbu5fWf6py0bl7agXDMlg5f+VEYt5cOiT4GI2hHvETg1Mw==
Date: Mon, 5 Feb 2018 00:07:27 -0600
From: Rob Herring <robh@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH 01/15] firmware: qcom: scm: Add ipq4019 soc compatible
Message-ID: <20180205022530.xf64gqeijicewdla@rob-hp-laptop>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-2-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517202689-14212-2-git-send-email-sricharan@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 10:41:15AM +0530, Sricharan R wrote:
> Add the compatible for ipq4019.
> This does not need clocks to do scm calls.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
>  drivers/firmware/qcom_scm.c                             | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
