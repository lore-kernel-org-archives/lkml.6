Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbeEaDcr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:32:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38731 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeEaDcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:32:45 -0400
X-Google-Smtp-Source: ADUXVKK+aHESTFL3ML6yJUTaGzWR7mMl7N8E9CKvs1YJGKElWZ5+ZXTaZCbTQCmvipFP/1H/r7YzQQ==
Date: Wed, 30 May 2018 22:32:42 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, kramasub@codeaurora.org,
        sdharia@quicinc.com, girishm@quicinc.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt
 bindings
Message-ID: <20180531033242.GA24141@rob-hp-laptop>
References: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
 <20180525111547.18556-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525111547.18556-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 12:15:46PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm SLIMBus NGD controller.
> SLIMBus NGD controller is a light-weight driver responsible for
> communicating with SLIMBus slaves directly over the bus using messaging
> interface and communicating with master component residing on ADSP for
> bandwidth and data-channel management
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

Reviewed-by: Rob Herring <robh@kernel.org>
