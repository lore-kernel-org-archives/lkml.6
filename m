Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeFAFOj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 01:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFAFOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 01:14:36 -0400
Date: Fri, 1 Jun 2018 10:44:26 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
        kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 0/2] slimbus: Add QCOM SLIMBus NGD driver
Message-ID: <20180601051426.GL16230@vkoul-mobl>
References: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 12:15, Srinivas Kandagatla wrote:
> This patchset adds support to basic version of Qualcomm NGD SLIMBus
> controller driver found SoCs from B family.
> 
> This controller is light-weight SLIMBus controller driver responsible for
> communicating with slave HW directly over the bus using messaging
> interface, and communicating with master component residing on ADSP
> for bandwidth and data-channel management.
> 
> Tested this patchset on DB820c with WCD9335 codec.
> I have pushed my working branch to [1] incase someone want to try.
> 
> This patch has dependency on https://lkml.org/lkml/2018/5/17/251

Looks good to me know, FWIW:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
