Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033286AbeBOOfl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:35:41 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:37894 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033263AbeBOOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:35:39 -0500
X-Google-Smtp-Source: AH8x227MAd89M0l12wkKPyq9yhxGovt9hrIfiTOmeUNHQ+Wrwnqkxlzf4kiG+PgkyUxccokfaB2ktd+G/Cct4nLPTeE=
MIME-Version: 1.0
In-Reply-To: <20180215131533.GL8219@piout.net>
References: <20180214005536.22739-1-david.daney@cavium.com>
 <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com> <20180215131533.GL8219@piout.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 15 Feb 2018 16:35:38 +0200
Message-ID: <CAHp75VcnR2U3DgSCv5Lpj=UBQnzX7YCbvbxzv__cZmW_+VcidQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: isl12026: Add driver.
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 3:15 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 15/02/2018 at 14:45:11 +0200, Andy Shevchenko wrote:
>> On Wed, Feb 14, 2018 at 2:55 AM, David Daney <david.daney@cavium.com> wrote:

>> > +#ifdef CONFIG_OF
>>
>> Remove this ugly #ifdef. Your driver OF only one.
>>
>
> Well, it is DT only because you asked for that on v1.

Yes, and I asked to remove these #ifdef:s there as well.

-- 
With Best Regards,
Andy Shevchenko
