Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeCOOMg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:12:36 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:39746 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeCOOMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:12:35 -0400
X-Google-Smtp-Source: AG47ELv0WDRuXxkobjShqomuMehq3rIDqOQoKsxzpebz2xi7gf1hTGea37DP0/zlanD0mXZp9TX+qC6kiZFJnfMH5IY=
MIME-Version: 1.0
In-Reply-To: <20180315135225.GK26859@dragon>
References: <20180122150748.1742-1-andrew.smirnov@gmail.com>
 <20180208064709.GB31910@dragon> <20180315030804.GI26859@dragon>
 <CAHQ1cqHdtN7xjmAcQvKDknnGKAP0pRgk6pcFrzOiSew9=Z9GQg@mail.gmail.com> <20180315135225.GK26859@dragon>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 15 Mar 2018 07:12:34 -0700
Message-ID: <CAHQ1cqGh0gmgCcFmc-sx7FzumnsObgzJTWm40ExuVo_o8EwCZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
To: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 6:52 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Mar 15, 2018 at 06:00:06AM -0700, Andrey Smirnov wrote:
>> I am slightly confused by your phrasing. Are you:
>>
>> a) saying that you dropped my patches in favor of your own that use
>> platform_device_add_data()
>>
>> or
>>
>> b) asking me to convert my patches to use platform_device_add_data()?
>>
>> Just trying to figure out if any action on my part is necessary.
>
> Sorry for the blur.  I'm asking you to repost your patches with using
> platform_device_add_data().  In other word, that's b).

OK, cool, will do.

Thanks,
Andrey Smirnov
