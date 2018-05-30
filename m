Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeE3PzP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753815AbeE3PzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:55:12 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <664089d4-b30d-99bb-2021-12128b2895ba@codeaurora.org>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-2-git-send-email-sricharan@codeaurora.org>
 <20180524173926.GC14924@minitux>
 <664089d4-b30d-99bb-2021-12128b2895ba@codeaurora.org>
Message-ID: <152769571081.144038.4314499217001219157@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 01/15] ARM: Add Krait L2 register accessor functions
Date: Wed, 30 May 2018 08:55:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UFtiSV031290

Quoting Sricharan R (2018-05-24 22:40:11)
> Hi Bjorn,
> 
> On 5/24/2018 11:09 PM, Bjorn Andersson wrote:
> > On Tue 06 Mar 06:38 PST 2018, Sricharan R wrote:
> > 
> >> From: Stephen Boyd <sboyd@codeaurora.org>
> >>
> >> Krait CPUs have a handful of L2 cache controller registers that
> >> live behind a cp15 based indirection register. First you program
> >> the indirection register (l2cpselr) to point the L2 'window'
> >> register (l2cpdr) at what you want to read/write.  Then you
> >> read/write the 'window' register to do what you want. The
> >> l2cpselr register is not banked per-cpu so we must lock around
> >> accesses to it to prevent other CPUs from re-pointing l2cpdr
> >> underneath us.
> >>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > This should have your signed-off-by here as well.
> > 
> 
>  ok.
> 
> > Apart from that:
> > 
> > Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> 

Will these patches come around again? I'll do a quick sweep on them
today but I expect them to be resent.
