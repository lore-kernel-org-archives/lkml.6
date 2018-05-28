Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeE1FGh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:06:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45842 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeE1FGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:06:34 -0400
X-Google-Smtp-Source: ADUXVKIx6ICLaUQ1bg/u8U09LIeO3NXCR5hdEMUw43dCRE3RuAdfW7XBRRkxLvkQ88ehqJQ43oc/y4IGfD7WxHUnTTc=
MIME-Version: 1.0
In-Reply-To: <20180520.231820.868530785962553925.davem@davemloft.net>
References: <20180514032839.32079-1-acelan.kao@canonical.com>
 <20180514.093504.1396660355199793729.davem@davemloft.net> <CAFv23Q=RGo5Tw4sL5GiYM69xeGUPReiBE290rnzCvOPezQinCg@mail.gmail.com>
 <20180520.231820.868530785962553925.davem@davemloft.net>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 28 May 2018 13:06:31 +0800
Message-ID: <CAFv23QnGJz8YUwzqmzHii=Obg8D9sb25Z4A+FFv2ze7HYXXG8g@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "alx: remove WoL support"
To: David Miller <davem@davemloft.net>
Cc: James Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>, rakesh@tuxera.com,
        netdev@vger.kernel.org, Emily Chien <emily.chien@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Stezenbach <js@sig21.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just inform you a news reported by a user who confirmed the wake up
issue can't be reproduce by the new kernel.
https://bugzilla.kernel.org/show_bug.cgi?id=61651#c126

<quote>
Guillaume de Jabrun 2018-05-27 15:12:54 UTC

I am using this patch for a long time. I was experiencing the "wake up
twice" bug, but with recent kernel version, I don't have this issue
anymore.
I can't tell which version actually fix the bug (I don't remember..).
</quote>

Best regards,
AceLan Kao.

2018-05-21 11:18 GMT+08:00 David Miller <davem@davemloft.net>:
> From: AceLan Kao <acelan.kao@canonical.com>
> Date: Mon, 21 May 2018 11:14:00 +0800
>
>> We are willing to fix the issue, but we don't have a machine to
>> reproduce it, and the WoL feature has been removed 5 years ago, it's
>> hard to find those buggy machines.
>
> Have you bothered to ask the person who did the revert?
>
>> WoL is a feature that is only used by a very small group of people,
>> and the wake up issue looks like only happens on some
>> platforms. Which means only small part of the group of people are
>> affected.
>
> One of those people was the wireless networking stack maintainer.
>
>> So, it's not a serious issue worth to remove it from alx driver.
>
> I disagree.
>
> You must fix the regression solved by the revert, before adding
> WoL support back to the driver.
>
> I'm not going to say this again.
>
> Thank you.
>
