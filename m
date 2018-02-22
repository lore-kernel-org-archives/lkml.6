Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeBVLN2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:13:28 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:56225 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbeBVLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:13:25 -0500
X-Google-Smtp-Source: AH8x225p0xMRvkk4Pzwjijj9fS1K0iSo/A4NL0Ely5BagNdv87HHnETPAvPqvR6dDrQNIKV3LFsKSA==
Subject: Re: [alsa-devel] [PATCH v3 24/25] ASoC: qcom: apq8096: Add db820c
 machine driver
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org,
        spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
 <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d3727be9-b8d1-68f1-d862-c6f5e3a83fea@linaro.org>
Date: Thu, 22 Feb 2018 11:13:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 22/02/18 11:00, Rohit Kumar wrote:
>> +config SND_SOC_MSM8996
>> +    tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
>> +    depends on QCOM_APR
>> +    select SND_SOC_QDSP6V2
> should be select SND_SOC_QDSP6, V2 is not defined

I will fix this in next version.

--srini
