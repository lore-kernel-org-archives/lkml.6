Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbeE2LLH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:11:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45002 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933009AbeE2LLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:11:05 -0400
X-Google-Smtp-Source: ADUXVKIWtt4USt+zBigGTdU0uUxbR//bTQy3tj/bTS7OFjzK0eM8rNuLxQXni3ZE5e9UKojmitJEPut4Ajf9eRl7v7c=
MIME-Version: 1.0
In-Reply-To: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
References: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
From: Amit Kucheria <amit.kucheria@verdurent.com>
Date: Tue, 29 May 2018 14:11:02 +0300
Message-ID: <CAHLCerNAGNWdYbRTmStJcrAw7jj5nmowqvaNCtHA6LEnRpParw@mail.gmail.com>
Subject: Re: [PATCH v14 0/2] Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 3:07 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> [v14]
>  * Addressed comment from Sudeep about DT compatible
>  * Added MAINTAINERS entry
>
> [v13]
>  * Addressed comment from Sudeep about DT compatible check on init
>
> [v12]
>  * Addressed comments from Sudeep and Viresh about the single init
>
> [v11]
>  * Addressed comment from Russel about device_node reference
>  * Addressed comment from Sudeep about the late_initcall
>  * Transformed init into probe to take care of deferals
>
> [v10]
>  * Split the series into domains
>  * Addressed comments from Viresh and Sudeep about logical CPU numbering.
>
> The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
> The driver reads eFuse information and chooses the required OPP subset
> by passing the OPP supported-hw parameter.
>
> The series depends on the series from Viresh:
> https://patchwork.kernel.org/patch/10418139/
>
> The previous spin was here:
> https://patchwork.kernel.org/patch/10424949/
>
> Ilia Lin (2):
>   cpufreq: Add Kryo CPU scaling driver
>   dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu
>
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  drivers/cpufreq/Kconfig.arm                        |  10 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c                | 206 +++++++
>  6 files changed, 907 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
>
FWIW,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
