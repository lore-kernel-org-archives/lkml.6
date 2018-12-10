Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF52C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA882082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA882082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeLJVlo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:41:44 -0500
Received: from mout.perfora.net ([74.208.4.196]:45169 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbeLJVln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:41:43 -0500
Received: from [10.185.195.207] ([178.197.229.26]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LkRO1-1h33680TbX-00cS83;
 Mon, 10 Dec 2018 22:41:31 +0100
Date:   Mon, 10 Dec 2018 22:41:24 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181128092404.GF17419@ulmo>
References: <20181101015230.27310-1-marcel@ziswiler.com> <20181101015230.27310-3-marcel@ziswiler.com> <20181101084152.GS7636@tbergstrom-lnx.Nvidia.com> <20181128092404.GF17419@ulmo>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v1 2/3] clk: tegra: ignore unused vfir clock shared with uartb
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
From:   Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <929FC681-E2DE-42FA-803A-AEDBD9779523@ziswiler.com>
X-Provags-ID: V03:K1:F1lgV2Kan2hAx36regNTdHl76cuonDjifIzlJlZZ9y0d+PoN2+w
 A3PQz7mMaCo1AVPSTaLQY3hEMPdDO8Gudj6NsMLQGQkJHIV5XMs7vW1BMBpJKnXlyLLaFay
 zECU5f2+ardWY9cowPYwgB57rGj9oYlCI/+ens546J4ZXU6uiJqubx8NkL0+fGPirl7WDsg
 WwLB4Rl7dUSEEBcEeLGmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xo0u5yJSHwM=:fLdmI7bNH7q/f1fjwhgHa9
 ARuhngCOinsdfWj46wqqYzAAJhrpW0mm4R5yt6dMEHfyFsgxeib7fAI7A28gX0tU5mnTAMC7z
 /X/of72e6/jMwfZpwch841b0Hf68FscG8JEGeaUq2SNQT1+bXga/aZicPTpDyCsIQHavgHETy
 0nb0Vi6zubCrMUroRyhthyw2HUImfjXaMGzG8jWiglGMpd2hz3f2oXdYo9WnAGNTUDg6f16Zy
 JAAh9MXvHp7XKnl1BDsnem04FK0Gvyi/tCCenRwta6ZSZbf+7geAUxhkb1yLBqpayPWMjK9qV
 T0kXVtXtaf7zMUlYGjzPivExTIfJ1amdSDdoWwKpNQ1oDYzjkjhhwITDC7MLz7zqvQaG1Febe
 QdV5b6WQDrPWVsHDVxVyVLdo26TN5BqEndHtffqMJPMfY4FTKU1Y7yYwFGXrtLrC7z1XMIsya
 Hgh2JghMHssnO/bf6MYYFoCgZsure4LuqHMivr06KUE9g6R1fkI2hG8nnK7VET0iwEJgLyqkC
 m7IMiFcVr5FWDqd/wu90SIJdnJxJvdOVys30ILHfRtTZ5Q2SZ8jv+YwhkVbf9008TctI3duUH
 JfvRanpJ4wJpUZoJVrHlD3UxG96rbgTaiWCfEaBICYGez7VrVoDniS4eabo8v9XVFZlSIuvhg
 UDaEXfluniAD+SGsFtWVdPN81KeBL1873pL/R0v+Q2jJBk4K3Skbgu+pGmjzU5EiR/0Ee2Nnr
 XtiVV8uSEyzxRj0BzQUMQeOpoTU6EqZpZB3OdQZyeDvc+3XsKJAiUymi6kA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 28, 2018 10:24:04 AM GMT+01:00, Thierry Reding <thierry.reding@gmail.com> wrote:
>On Thu, Nov 01, 2018 at 10:41:52AM +0200, Peter De Schrijver wrote:
>> On Thu, Nov 01, 2018 at 02:52:29AM +0100, Marcel Ziswiler wrote:
>> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> > 
>> > As UARTB and VFIR share their clock enable bit it is rather unwise
>for
>> > the kernel to turn off the VFIR one should that be unused (and
>> > potentially vice versa but so far there anyway is no VFIR driver).
>> > 
>> > Without this patch trying to use UARTB with the regular 8250 driver
>> > will freeze as soon as ttyS1 is accessed after boot. Luckily, using
>the
>> > high-speed Tegra serial driver won't exhibit the issue as clocks
>are
>> > dynamically enabled/disabled on every access.
>> > 
>> > This has been reproduced both on Apalis T30 as well as Apalis TK1
>but
>> > may be an issue on all Tegra UARTB's which share the clock enable
>with
>> > VFIR.
>> > 
>> 
>> Ah.. the correct fix for this is to initialize the enable_refcnt
>based on the
>> hw state. This is done in 9619dba8325fce098bbc9ee2911d1b0150fec0c9
>for
>> periph gate clocks, but obviously also applies to normal periph
>clocks.
>
>Hi Marcel,
>
>were you going to send a new version with the alternative fix as
>suggested by Peter?

Yes, sorry. Let me look at that now.

>Thierry
