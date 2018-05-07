Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeEGSrk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:47:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37163 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeEGSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:47:37 -0400
X-Google-Smtp-Source: AB8JxZrY3rb5m+yUI7CLJSp5rvZMWgUfbX3NchLk8YlRLTxA5+OhEPAAS2t67MLUvI123wmbHdkMsg==
Date: Mon, 7 May 2018 11:49:00 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, swboyd@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-soc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Sort nodes in the soc by
 address
Message-ID: <20180507184900.GH2259@tuxbook-pro>
References: <20180504220356.261711-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504220356.261711-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 May 15:03 PDT 2018, Douglas Anderson wrote:

> This is pure-churn and should be a no-op.  I'm doing it in the hopes
> of reducing merge conflicts.  When things are sorted in a sane way
> (and by base address seems sane) then it's less likely that future
> patches will cause merge conflicts.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Nice, I like it.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
