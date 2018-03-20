Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCTR2f convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeCTR21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:28:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B71921736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180222061208.2031-2-rnayak@codeaurora.org>
Cc: devicetree@vger.kernel.org, dianders@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, marc.zyngier@arm.com,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org
References: <20180222061208.2031-1-rnayak@codeaurora.org>
 <20180222061208.2031-2-rnayak@codeaurora.org>
Message-ID: <152156690591.214794.3806846589522580946@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: Document kryo385 cpu
Date: Tue, 20 Mar 2018 10:28:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-02-21 22:12:05)
> Document the compatible string for the Kryo385 cpus found in qualcomm
> SoCs.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
