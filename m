Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeEPIXk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:23:40 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40403 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbeEPIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:23:29 -0400
X-Google-Smtp-Source: AB8JxZpcoEoOsBwv/Rvvdnw/3UIFiSZEYi7+E+yeA91wRyxx5oyYJG/GJukg1GPwJTe5gcsu+euwH0vKgbjnS6dG1kk=
MIME-Version: 1.0
In-Reply-To: <152641886428.237094.9491189918943948420@swboyd.mtv.corp.google.com>
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
 <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com> <20362702.FCbsg9xPKv@aspire.rjw.lan>
 <9f31fc22-b97f-0241-30cd-798ee03b2f1d@amd.com> <152641886428.237094.9491189918943948420@swboyd.mtv.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 May 2018 10:23:27 +0200
X-Google-Sender-Auth: bv1gqvz5OtHWY_w7Igquwc820lQ
Message-ID: <CAJZ5v0gKvMFSyZy3K11d1P8+5ZBNk2ecFAuRTrQ_3obYJM8iTw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
To: Stephen Boyd <sboyd@kernel.org>
Cc: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>, Shaoyun.Liu@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:14 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Agrawal, Akshu (2018-05-15 02:39:08)
>>
>>
>> On 5/15/2018 3:02 PM, Rafael J. Wysocki wrote:
>> > On Wednesday, May 9, 2018 11:59:00 AM CEST Akshu Agrawal wrote:
>> >> Stoney SoC provides oscout clock. This clock can support 25Mhz and
>> >> 48Mhz of frequency.
>> >> The clock is available for general system use.
>> >>
>> >> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> >
>> > I'm not sure if the Stephen Boyd's comments on one of the previous
>> > versions of this patch have been addressed.  Have they?
>> >
>> > In any case, if I'm expected to take this, I need an ACK from Stephen on it.
>> >
>> > Thanks,
>> > Rafael
>> >
>>
>> All comments of Stephen Boyd and Daniel Kurtz have been addressed.
>>
>> Stephen, if you are Ok with this can you please ACK it.
>>
>
> It could go via clk tree and meet up with the acpi patch in -next right?
> I'm fine with it going through acpi path though so whichever way works.

It's better if it goes in as a series IMO and then if it goes via
ACPI, the clock dependency will be clear from the git history.

So if you don't mind, I'll queue this series up for 4.18.

Thanks,
Rafael
