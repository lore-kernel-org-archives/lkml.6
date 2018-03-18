Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbeCRMtv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:49:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36611 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbeCRMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:49:46 -0400
X-Google-Smtp-Source: AG47ELuyhX6kwM/XMEohxCQvvekbnZbKU+r1w88TXWYXhpZvrS1RMEONZWpa22LJbF7FU6PqPHfRUQ==
Date: Sun, 18 Mar 2018 07:49:43 -0500
From: Rob Herring <robh@kernel.org>
To: Sibi S <sibis@codeaurora.org>
Cc: bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 1/7] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
Message-ID: <20180318124943.4ixek2mnalfvqwbu@rob-hp-laptop>
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-2-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521019283-32212-2-git-send-email-sibis@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 02:51:17PM +0530, Sibi S wrote:
> Add SDM845 AOSS (always on subsystem) reset controller binding
> 
> Signed-off-by: Sibi S <sibis@codeaurora.org>

Still need a full name.

Otherwise, looks fine.

> ---
>  .../devicetree/bindings/reset/qcom,aoss-reset.txt  | 54 ++++++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-aoss.h       | 17 +++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
