Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCIJLo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:11:44 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43588 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbeCIJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:11:40 -0500
X-Google-Smtp-Source: AG47ELucN3G6KHo46k7ets/Ile7u26h+lP80r4kebBHmwBrld86KadDEoGRMbj2Od3pLKuqPpXh7u6Ip0VAcbdUbCJY=
MIME-Version: 1.0
In-Reply-To: <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com> <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 9 Mar 2018 14:41:39 +0530
X-Google-Sender-Auth: N4t7QKdN2jgK3OKk_wwRe3gw52I
Message-ID: <CAOh2x=kczewDo1wTR+46+M7SussWLQzMPZW2MgUnz3bmQq1Wkg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] cpufreq: tegra124-cpufreq: extend to support Tegra210
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 10:04 PM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> Tegra210 has a very similar CPU clocking scheme than Tegra124. So add
> support in this driver. Also allow for the case where the CPU voltage is
> controlled directly by the DFLL rather than by a separate regulator object.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

You forgot to Cc maintainers and pm-list from the cpufreq world :(
