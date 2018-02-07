Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbeBGLkO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:40:14 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35436 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeBGLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:40:12 -0500
X-Google-Smtp-Source: AH8x225ycYzPOTTnBXKLtekF6RXM/jfK4iml3lcv74LQUG+d3nbxGDxrdZpBqXlqwWxO6y+7w/3ZPw==
Subject: Re: [alsa-devel] [RESEND PATCH v2 11/15] ASoC: qcom: qdsp6: Add
 support to q6afe dai driver
To: Rohit Kumar <rohitkr@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>, sboyd@codeaurora.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
 <33dbc1d9-ec33-b779-9258-4d1b13e17aaa@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <55b292b3-7826-2757-bf79-1128baaa3f07@linaro.org>
Date: Wed, 7 Feb 2018 11:40:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <33dbc1d9-ec33-b779-9258-4d1b13e17aaa@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/18 11:34, Rohit Kumar wrote:
>> +
>> +module_platform_driver(q6afe_dai_driver);
> MODULE_LICENSE missing.

Thanks Rohit, I have included this in v3.
