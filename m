Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeCIVhQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:37:16 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:41484 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeCIVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:37:13 -0500
X-Google-Smtp-Source: AG47ELvikui2gfshupfJOw2wOcWjPHdO9Yhr1jZxCOx779Jwpo4ocIPzAMutwBoDJSq635ZX9xgHsnJ2WzykjY6jxoA=
MIME-Version: 1.0
In-Reply-To: <20180309213327.GA2806@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org> <20180302164317.10554-2-ilina@codeaurora.org>
 <152036550693.218381.11708415467260101936@swboyd.mtv.corp.google.com> <20180309213327.GA2806@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
Date: Fri, 9 Mar 2018 13:37:12 -0800
Message-ID: <CAE-0n53SY8MgNpvDXXC=52Ddo9gvYBV3PZuL1fHBx8BZHbfd0w@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for
 QCOM SoCs
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 1:33 PM, Lina Iyer <ilina@codeaurora.org> wrote:
> Hi Stephen,
>
> I will address all the comments in the next spin of the patch. Here are
> some responses to the questions.
>
> On Tue, Mar 06 2018 at 12:45 -0700, Stephen Boyd wrote:
>>
>> Quoting Lina Iyer (2018-03-02 08:43:08)
>
> [...]
>>
>> +#include <linux/module.h>
>>
>> If the driver doesn't become tristate, this should become export.h
>> instead of module.h
>>
> MODULE_DEVICE_TABLE seems to need this.
>

If you don't have tristate then MODULE_DEVICE_TABLE isn't needed.
