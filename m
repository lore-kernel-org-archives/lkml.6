Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeCGJfp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:35:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeCGJfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:35:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE8676016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v3 19/25] ASoC: qcom: q6afe: add support to
 MI2S ports
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org,
        spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-20-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <7d3c344c-ccb5-78b8-e184-3ab65bdef6ac@codeaurora.org>
Date: Wed, 7 Mar 2018 15:05:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213165837.1620-20-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2018 10:28 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   include/dt-bindings/sound/qcom,q6afe.h |  10 +++
>   sound/soc/qcom/qdsp6/q6afe.c           | 111 +++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h           |  10 +++
>   3 files changed, 131 insertions(+)
>
> diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
> index e9004ee39f72..3cd862262369 100644
> --- a/include/dt-bindings/sound/qcom,q6afe.h
> +++ b/include/dt-bindings/sound/qcom,q6afe.h
> @@ -16,6 +16,16 @@
>   #define SLIMBUS_4_TX    24
>   #define SLIMBUS_5_RX    25
>   #define SLIMBUS_5_TX    26
> +#define QUATERNARY_MI2S_RX	34
> +#define QUATERNARY_MI2S_TX	35
> +#define SECONDARY_MI2S_RX	36
> +#define SECONDARY_MI2S_TX	37
> +#define TERTIARY_MI2S_RX	38
> +#define TERTIARY_MI2S_TX	39
> +#define PRIMARY_MI2S_RX		40
> +#define PRIMARY_MI2S_TX		41
Can we assign ids to Primary, secondary, tertiary and quaternary MI2S 
ports in sequence starting with Primary.
> +#define SECONDARY_PCM_RX	42
> +#define SECONDARY_PCM_TX	43
Why only SECONDARY_PCM_RX ? This is not required for MI2S right?
>   #define SLIMBUS_6_RX    45
>   #define SLIMBUS_6_TX    46
>
[..]
