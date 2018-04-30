Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeD3JDa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:03:30 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36552 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeD3JD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:03:26 -0400
X-Google-Smtp-Source: AB8JxZpUwTD40m7+HQkJTtLRkDZGMmkBJB3BLJyOCAwQBDbPHo8kC+cHhfn5VIyaOhaD3o/+/ko7/uXQszv/gZ8lSf4=
MIME-Version: 1.0
In-Reply-To: <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com> <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Apr 2018 11:03:25 +0200
Message-ID: <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 5:14 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 04/19/2018 09:05 AM, Wolfram Sang wrote:
>>
>> We should get drvdata from struct device directly. Going via
>> platform_device is an unneeded step back and forth.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>
>> Build tested only. buildbot is happy. Please apply individually.
>
>
> for gpio-omap.c:
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Hm I only see the responses not the actual patch, I guess I will find it
sooner or later.

Wolfram: if I don't find it, poke me with something sharp so I get to apply it.

Yours,
Linus Walleij
