Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935273AbeD0OWH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:22:07 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34382 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934990AbeD0OVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:21:46 -0400
X-Google-Smtp-Source: AB8JxZoKh6+Kxd5YbCOubPvkpvnGgnWBdumbZNT7FydhEI6Ki/P2ikepvtXOMrgHonQu7CwK2Slz/w==
Date: Fri, 27 Apr 2018 09:21:44 -0500
From: Rob Herring <robh@kernel.org>
To: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        kyan@codeaurora.org, ckadabi@codeaurora.org, evgreen@chromium.org
Subject: Re: [PATCH v5 1/2] dt-bindings: Documentation for qcom, llcc
Message-ID: <20180427142144.tvy5xamuwz6jnxk5@rob-hp-laptop>
References: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
 <1524524972-12014-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524524972-12014-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 04:09:31PM -0700, Rishabh Bhatnagar wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

My comments on v4 still apply.

Rob
