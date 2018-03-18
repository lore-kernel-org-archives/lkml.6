Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754586AbeCRMwr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:52:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41332 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeCRMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:31 -0400
X-Google-Smtp-Source: AG47ELvaIKZs47anbRs14uL962geChq9VZLKg8whZ/Ftx1a6GuLUqqQEfqiTGfqehZWUK4il+IAcHw==
Date: Sun, 18 Mar 2018 07:52:27 -0500
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: bhelgaas@google.com, svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcie: qcom: Add support to enable pcie refclk
Message-ID: <20180318031703.xt6fscof7ibslgrq@rob-hp-laptop>
References: <20180315144133.14031-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315144133.14031-1-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:41:33PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to enable 100MHz pcie refclk,
> On some boards like DB600c this clock is not enabled by default.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt |  1 +
>  drivers/pci/dwc/pcie-qcom.c                         | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
