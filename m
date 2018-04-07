Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeDGKnL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 06:43:11 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43986 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeDGKnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 06:43:10 -0400
X-Google-Smtp-Source: AIpwx48d2qgWfWYU6Sfhu7i3rudN2gyrXLqzUeO2DjC1WX+VrVNhqcy+FJHcHaBd0AUmmlrBafXJjA==
Subject: Re: [PATCH v3 2/2] drivers: soc: Add LLCC driver
To: rishabhb@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
 <1522176722-12691-3-git-send-email-rishabhb@codeaurora.org>
 <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
 <a44193e11069b4107985776fa323782b@codeaurora.org>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <f6671b63-8f61-7a6b-8e4a-93dbe06a2da0@linaro.org>
Date: Sat, 7 Apr 2018 13:43:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <a44193e11069b4107985776fa323782b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On  4.04.2018 20:30, rishabhb@codeaurora.org wrote:
> Hi Stanimir,
> We incorporated all your comments except the following:
> 1. Removing the driver that maintains the SCT (system cache table)
> per chipset. As responded earlier the data is expected to change
> from chipset to chipset and would clutter the main driver if we
> choose using compatible string. We think its good to keep the data
> separate from core driver.
> 2. Changing struct llcc_slice_desc to llcc_desc:
> The descriptor is specific to each slice and not the whole llcc.
> All the properties such as id and size are specific to each slice
> and not whole llcc.
> 
> please let me know if you are ok with the approach. Based on that
> I can send my next revision of changes.

Yes, please go ahead and send the next version.

regards,
Stan
