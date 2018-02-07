Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeBGOwI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:52:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeBGOwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:52:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21B4960272
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] pinctrl: msm: Use dynamic GPIO numbering
To: Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180129005948.7714-1-bjorn.andersson@linaro.org>
 <CACRpkdb0OWQzeJZ7K1bXrdNPwu0GhygW1p04Xoyf9WjTg7+=BQ@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <f26a61ac-c8ba-e37a-4266-4e594f5b0bce@codeaurora.org>
Date: Wed, 7 Feb 2018 08:52:03 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdb0OWQzeJZ7K1bXrdNPwu0GhygW1p04Xoyf9WjTg7+=BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/18 7:52 AM, Linus Walleij wrote:
> Otherwise we need something that conserves base 0 for singular
> TLMM drivers and make it -1 for newer platforms with several
> instances.

     static int base = 0;

     chip->base = base;
     base = -1;

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
