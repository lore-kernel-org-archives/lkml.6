Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756646AbeEJF62 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 01:58:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41729 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEJF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 01:58:26 -0400
X-Google-Smtp-Source: AB8JxZr/kvJ7sep7lYOaoyAV5lCzPp01ayiO6VGoOCh2vFnWfmYKfSsddSme8DOiJM3Pc9VQQXRu1+9Mqi1y6dFCgoE=
MIME-Version: 1.0
In-Reply-To: <20180509134543.GF14276@lunn.ch>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
 <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
 <20180409123910.GB31060@lunn.ch> <20180409.105039.310935818370762783.davem@davemloft.net>
 <CAFv23Q=QYastpgLxHiwr_PSdoeWfEjiNp6x2F9kM5EYhRee2hA@mail.gmail.com>
 <CAFv23QmkLiuFA6C4YFsO3hoTEE--2bT4H2uxaMqoY30G4_QJGw@mail.gmail.com>
 <CAFv23Qn1-5nHcFsk3egcL+OpKtujv4rkyXxa-Qht4eV4z6cbCA@mail.gmail.com> <20180509134543.GF14276@lunn.ch>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 10 May 2018 13:58:24 +0800
Message-ID: <CAFv23QkETCHYqpsp_1JR30A1F=x+xCCQQv2RM9VOg24qhQRMOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] alx: add disable_wol paramenter
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Miller <davem@davemloft.net>, James Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>, rakesh@tuxera.com,
        netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Emily Chien <emily.chien@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

We have some machines using Qualcomm Atheros Killer E2400 Gigabit
Ethernet Controller,
but none of them has the unintentional wake up issue.
We're willing to fix it if we encountered the issue, but before we can
do it, we need this feature is supported by the driver.

Taking the feature has been removed for 5 years into account, I doubt
if we still can reproduce this issue,
but again, to verify this issue we need to add back this feature first.
Set WoL disabled by default won't introduce any regression but give
users and developers a chance to fix it.

Best regards,
AceLan Kao.

2018-05-09 21:45 GMT+08:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, May 09, 2018 at 10:40:13AM +0800, AceLan Kao wrote:
>> Hi,
>>
>> I didn't get any response around one month.
>
> I didn't notice you posting an results of searching for the true
> problem? Please can you point me at an email archive.
>
>          Andrew
