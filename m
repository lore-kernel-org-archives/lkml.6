Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeEUGFe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 02:05:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41105 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeEUGFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 02:05:32 -0400
X-Google-Smtp-Source: AB8JxZpZxKaPqGyDn81bAf4fY0pbw0Mgwry4YV2eKz1aw22jgZTwA5Av7RZ90sDFtGz0KwVw/B24Jg==
Date: Mon, 21 May 2018 11:35:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org
Subject: Re: [PATCH v2 0/2] Add support for QCOM cpufreq FW driver
Message-ID: <20180521060529.kyjkglucbydr6b3f@vireshk-i7>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-18, 23:04, Taniya Das wrote:
>  [v2]
>    * Address comments given in v0 series.

That's not how you do it. You need to explain every change in enough
detail here so that the reviewers don't need to go to their previous
emails to see what changed.

>  [v1]
>     * Fixed compilation reported by Amit K.
> 
> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this firmware.
> 
> Taniya Das (2):
>   dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
>   cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
> 
>  .../bindings/cpufreq/cpufreq-qcom-fw.txt           |  68 +++++
>  drivers/cpufreq/Kconfig.arm                        |   9 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/qcom-cpufreq-fw.c                  | 317 +++++++++++++++++++++
>  4 files changed, 395 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
> 
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.

-- 
viresh
