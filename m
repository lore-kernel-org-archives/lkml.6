Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031231AbeEZHIg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 03:08:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031156AbeEZHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 03:08:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D6366032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: Remove DEBUG define from Qualcomm DWC3 glue
 driver
To: Douglas Anderson <dianders@chromium.org>, balbi@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180525220748.15117-1-dianders@chromium.org>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <a8cbbd34-0e44-30f5-7eed-f5bbe7a7218b@codeaurora.org>
Date: Sat, 26 May 2018 12:38:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525220748.15117-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 5/26/2018 3:37 AM, Douglas Anderson wrote:
> It appears that a "#define DEBUG" was left in on the recent patch
> landed for the Qualcomm DWC3 glue driver.  Let's remove it.
>
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/usb/dwc3/dwc3-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 8abb6f31389d..b0e67ab2f98c 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -3,7 +3,6 @@
>   *
>   * Inspired by dwc3-of-simple.c
>   */
> -#define DEBUG

:(.. Sorry about that.. Thanks for fixing it.

>  
>  #include <linux/io.h>
>  #include <linux/of.h>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
