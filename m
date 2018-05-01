Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756404AbeEASfq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:35:46 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36763 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756278AbeEASfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:35:45 -0400
X-Google-Smtp-Source: AB8JxZr6BaCbB+qfriKPd8MHB8Uoudz7tkofp9f0JbnvzGI7RcbrT1IGjATYrsiToPAbRsVIaSpoQWDZ5/j1UiRNJ7s=
MIME-Version: 1.0
In-Reply-To: <e6f74f86-a427-4165-cbc0-27fe129dab8e@linaro.org>
References: <20180501052952.26765-1-andrew.smirnov@gmail.com>
 <20180501052952.26765-3-andrew.smirnov@gmail.com> <e6f74f86-a427-4165-cbc0-27fe129dab8e@linaro.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 1 May 2018 11:35:43 -0700
Message-ID: <CAHQ1cqGmiRvE+sUdpOcFQ=oGjA79sVQGc+noQBv7SP_0rKggvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nvmem: Add RAVE SP EEPROM driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 8:33 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 01/05/18 06:29, Andrey Smirnov wrote:
>>
>> +// SPDX-License-Identifier: GPL-2.0+
>
> ...
>>
>> +MODULE_LICENSE("GPL");
>
> I think this should be
> MODULE_LICENSE("GPL v2");

With that change the two statements would contradict each other. "GPL"
means "GNU Public License v2 or later", whereas "GPL v2" means "GNU
Public License v2" as per
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/module.h#n175

Thanks,
Andrey Smirnov
