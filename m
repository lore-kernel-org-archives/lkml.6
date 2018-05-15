Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeEOVO1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752354AbeEOVOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:14:25 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9f31fc22-b97f-0241-30cd-798ee03b2f1d@amd.com>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, christian.koenig@amd.com, airlied@redhat.com,
        Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
 <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
 <20362702.FCbsg9xPKv@aspire.rjw.lan>
 <9f31fc22-b97f-0241-30cd-798ee03b2f1d@amd.com>
Message-ID: <152641886428.237094.9491189918943948420@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
Date: Tue, 15 May 2018 14:14:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLEW1f025324

Quoting Agrawal, Akshu (2018-05-15 02:39:08)
> 
> 
> On 5/15/2018 3:02 PM, Rafael J. Wysocki wrote:
> > On Wednesday, May 9, 2018 11:59:00 AM CEST Akshu Agrawal wrote:
> >> Stoney SoC provides oscout clock. This clock can support 25Mhz and
> >> 48Mhz of frequency.
> >> The clock is available for general system use.
> >>
> >> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> > 
> > I'm not sure if the Stephen Boyd's comments on one of the previous
> > versions of this patch have been addressed.  Have they?
> > 
> > In any case, if I'm expected to take this, I need an ACK from Stephen on it.
> > 
> > Thanks,
> > Rafael
> > 
> 
> All comments of Stephen Boyd and Daniel Kurtz have been addressed.
> 
> Stephen, if you are Ok with this can you please ACK it.
> 

It could go via clk tree and meet up with the acpi patch in -next right?
I'm fine with it going through acpi path though so whichever way works.
