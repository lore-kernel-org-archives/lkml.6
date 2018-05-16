Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeEPVSa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbeEPVS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:18:28 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAJZ5v0gKvMFSyZy3K11d1P8+5ZBNk2ecFAuRTrQ_3obYJM8iTw@mail.gmail.com>
Cc: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>, Shaoyun.Liu@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
 <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
 <20362702.FCbsg9xPKv@aspire.rjw.lan>
 <9f31fc22-b97f-0241-30cd-798ee03b2f1d@amd.com>
 <152641886428.237094.9491189918943948420@swboyd.mtv.corp.google.com>
 <CAJZ5v0gKvMFSyZy3K11d1P8+5ZBNk2ecFAuRTrQ_3obYJM8iTw@mail.gmail.com>
Message-ID: <152650550674.210890.11671394176812686200@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
Date: Wed, 16 May 2018 14:18:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GLIa1A004992

Quoting Rafael J. Wysocki (2018-05-16 01:23:27)
> On Tue, May 15, 2018 at 11:14 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Agrawal, Akshu (2018-05-15 02:39:08)
> >>
> >>
> >> On 5/15/2018 3:02 PM, Rafael J. Wysocki wrote:
> >> > On Wednesday, May 9, 2018 11:59:00 AM CEST Akshu Agrawal wrote:
> >> >> Stoney SoC provides oscout clock. This clock can support 25Mhz and
> >> >> 48Mhz of frequency.
> >> >> The clock is available for general system use.
> >> >>
> >> >> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> >> >
> >> > I'm not sure if the Stephen Boyd's comments on one of the previous
> >> > versions of this patch have been addressed.  Have they?
> >> >
> >> > In any case, if I'm expected to take this, I need an ACK from Stephen on it.
> >> >
> >> > Thanks,
> >> > Rafael
> >> >
> >>
> >> All comments of Stephen Boyd and Daniel Kurtz have been addressed.
> >>
> >> Stephen, if you are Ok with this can you please ACK it.
> >>
> >
> > It could go via clk tree and meet up with the acpi patch in -next right?
> > I'm fine with it going through acpi path though so whichever way works.
> 
> It's better if it goes in as a series IMO and then if it goes via
> ACPI, the clock dependency will be clear from the git history.
> 
> So if you don't mind, I'll queue this series up for 4.18.
> 

Ok
