Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeFBGhb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeFBGh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:37:29 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180530150646.19030-4-digetx@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180530150646.19030-1-digetx@gmail.com>
 <20180530150646.19030-4-digetx@gmail.com>
Message-ID: <152792144851.225090.7409061495035612435@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 3/4] clk: tegra20: Turn EMC clock gate into divider
Date: Fri, 01 Jun 2018 23:37:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526bboU004092

Quoting Dmitry Osipenko (2018-05-30 08:06:45)
> Kernel should never gate the EMC clock as it causes immediate lockup, so
> removing clk-gate functionality doesn't affect anything. Turning EMC clk
> gate into divider allows to implement glitch-less EMC scaling, avoiding
> reparenting to a backup clock.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Looks ok to me, but I'm waiting for someone from Tegra side to ack it or
review it.
