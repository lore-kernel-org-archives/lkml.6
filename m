Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbeDTMLq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:11:46 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:51061 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754688AbeDTMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:11:44 -0400
X-Google-Smtp-Source: AIpwx4+rbjHrxRPcNFENiExvpR7axaOJRKkNHZKfSt6aCbObZcyMZhZDWFwFPNhSS208ClTWws3slA==
Subject: Re: [PATCH 0/6] soc: qcom: smem: bug fixes
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180410222542.29474-1-elder@linaro.org>
Message-ID: <e4cc56de-71d9-4904-ab09-92fa079c956a@linaro.org>
Date: Fri, 20 Apr 2018 07:11:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410222542.29474-1-elder@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 05:25 PM, Alex Elder wrote:
> This series contains mostly bug fixes to the Qualcomm shared memory
> ("smem") code.  Although the bugs are real, they have most likely
> never been observed.
> 
> 					-Alex

Ping?	-Alex

> 
> Alex Elder (6):
>   soc: qcom: smem: fix first cache entry calculation
>   soc: qcom: smem: return proper type for cached entry functions
>   soc: qcom: smem: byte swap values properly
>   soc: qcom: smem: fix off-by-one error in qcom_smem_alloc_private()
>   soc: qcom: smem: fix qcom_smem_set_global_partition()
>   soc: qcom: smem: check sooner in qcom_smem_set_global_partition()
> 
>  drivers/soc/qcom/smem.c | 50 +++++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
