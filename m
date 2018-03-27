Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755154AbeC0RWL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:22:11 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:38794 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755122AbeC0RWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:22:08 -0400
X-Google-Smtp-Source: AIpwx4+S46s0w4goAg30E6nstl90KCmtR8ZcjVJwyXYcP9wM+ttOG1ffWSE702cdjuM8Z5Yh9h9erw==
Date: Tue, 27 Mar 2018 10:22:19 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 09/13] ARM: dts: ipq4019: Add
 qcom-ipq4019-ap.dk07.1-c1 board file
Message-ID: <20180327172219.GL1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-10-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-10-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C1";

Add compatible for the board.

> +

Regards,
Bjorn
