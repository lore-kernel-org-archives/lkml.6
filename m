Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeFAXfi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 19:35:38 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39550 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeFAXfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:35:34 -0400
X-Google-Smtp-Source: ADUXVKIiGhONCFsH/yKQ7aMeU9gKfUtJcCVTMZVGs7teKbxMOsNlTbh/x4UL9r2z+dQPPHoTfdfUDA==
Subject: Re: [PATCH] of: platform: stop accessing invalid dev in
 of_platform_device_destroy
To: robh+dt@kernel.org, frowand.list@gmail.com
Cc: linux-arm-msm@vger.kernel.org, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com
References: <20180601225822.23439-1-srinivas.kandagatla@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3f925507-bd67-a73d-586e-0458038a5832@linaro.org>
Date: Sat, 2 Jun 2018 00:35:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180601225822.23439-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/18 23:58, Srinivas Kandagatla wrote:
>   
> -	of_node_clear_flag(dev->of_node, OF_POPULATED);
> -	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
This change seems to have a side effect during re-probing. I will dig in 
bit more to see how best it can be fixed.

thanks,
srini
