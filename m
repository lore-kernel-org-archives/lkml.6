Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeERIwv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:52:51 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36776 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeERIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:52:44 -0400
X-Google-Smtp-Source: AB8JxZrAXM5aS1sKvjNqFnmZELuxByOr7oQYiNFuyqqr+VbJI+wRyXUeImxH21hXR47fwML+a3M1tw==
Subject: Re: [PATCH 01/28] venus: hfi_msgs: correct pointer increment
To: Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, vgarodia@codeaurora.org
References: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
 <20180424124436.26955-2-stanimir.varbanov@linaro.org>
 <CAAFQd5CYaeUNFMFrQAC2mofd80LKt6zxBRwAje4AoWbhGvGJ0A@mail.gmail.com>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ace94242-b4cc-c671-451e-de668273d2ef@linaro.org>
Date: Fri, 18 May 2018 11:52:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CYaeUNFMFrQAC2mofd80LKt6zxBRwAje4AoWbhGvGJ0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

Thanks for the review!

On 05/18/2018 11:33 AM, Tomasz Figa wrote:
> Hi Stanimir,
> 
> Thanks for the series. I'll be gradually reviewing subsequent patches. Stay
> tuned. :)
> 

Please consider that there is a v2 of this patchset. :)

> 
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> 

Thanks!

-- 
regards,
Stan
