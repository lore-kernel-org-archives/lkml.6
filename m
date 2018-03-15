Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCOQY5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:24:57 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38676 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCOQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:24:55 -0400
X-Google-Smtp-Source: AG47ELtw4wsFJcYKz7SabOsq7ain1hzosa2JHy8LQb8ctEZNs6CqjrI2J8TvZf63KQn5kvhZtt/z8w==
Subject: Re: [RFC PATCH] clk: qcom: rpmcc: Add support to XO buffered clocks
To: Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: david.brown@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org
References: <20180315143724.13859-1-srinivas.kandagatla@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f2757455-c825-01d6-cf53-8b2504b9b2f8@linaro.org>
Date: Thu, 15 Mar 2018 16:24:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180315143724.13859-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/03/18 14:37, srinivas.kandagatla@linaro.org wrote:
>   
>   struct clk_rpm {
>   	const int rpm_clk_id;
> +	const int xo_offset;
> +	u32 xo_buffer_value;
>   	const bool active_only;
Just realized that this would not work when more than one xo are active, 
I will have a closer look and send an new version.

thanks,
srini
