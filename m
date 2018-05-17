Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEQJjb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:39:31 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44524 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeEQJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:39:29 -0400
X-Google-Smtp-Source: AB8JxZreQI04VqXXqs43WVaa8k61bIbcuw3wNjsbFlowJqOs8l47iwXwKcbBMmANY2QQ8D0FE+xq9AsTzPa/6MerKxc=
MIME-Version: 1.0
In-Reply-To: <1526549401-25666-1-git-send-email-tdas@codeaurora.org>
References: <1526549401-25666-1-git-send-email-tdas@codeaurora.org>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Thu, 17 May 2018 12:39:27 +0300
Message-ID: <CAP245DXgeXvJsw7Q0MU1T97=NYuFywYgNGEQ+vek+obgHpcJsQ@mail.gmail.com>
Subject: Re: [v0 0/2] Add support for QCOM cpufreq FW driver
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 12:29 PM, Taniya Das <tdas@codeaurora.org> wrote:
> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
> for hanging the frequency of CPUs. The driver implements the cpufreq driver

s/hanging/changing :-)

> interface for this firmware.
>
> Taniya Das (2):
>   dt-bindings: clock: Introduce QCOM CPUFREQ FW bindings
>   cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
>
>  .../bindings/cpufreq/cpufreq-qcom-fw.txt           |  68 +++++
>  drivers/cpufreq/Kconfig.arm                        |   9 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/qcom-cpufreq-fw.c                  | 318 +++++++++++++++++++++
>  4 files changed, 396 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
>
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>
