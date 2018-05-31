Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbeEaGRW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:17:22 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:40432 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbeEaGRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:17:20 -0400
X-Google-Smtp-Source: ADUXVKK2obEakEdhdoh5PjLYkf7Li6WR8/v04PxumgYAbnS+OZFvD0UouSX6PIBBlB2TXNDg9wisHLQOxCNptcNM1d8=
MIME-Version: 1.0
In-Reply-To: <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-9-ulf.hansson@linaro.org> <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 May 2018 08:17:18 +0200
Message-ID: <CAPDyKFrV5fosZ1QZ4un+okzpeQDM3QSCBWJB1YZH4WNxKf_FVQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>> +/**
>> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>> + * @dev: Device to attach.
>
> Can you update the description of the above as well?

Yes, like below?

genpd_dev_pm_attach_by_id() - Associate a device with one of its PM domains.
@dev: The device used to lookup the PM domain.

Kind regards
Uffe
