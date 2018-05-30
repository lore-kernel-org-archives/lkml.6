Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755062AbeE3EiM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:38:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42813 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbeE3EiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:38:09 -0400
X-Google-Smtp-Source: ADUXVKJ1L1k3+fDfEUB5LwYzAlO+bE2p4nkIQW8rhNlwUgZLr0+zmcMPUE3hcTPLzCExisIYT1G/+g==
Date: Wed, 30 May 2018 10:08:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] arm: dts: exynos: Add missing cooling device
 properties for CPUs
Message-ID: <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
 <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-18, 15:18, Krzysztof Kozlowski wrote:
> Thanks for the patch.
> 
> In case of Exynos, the booting CPU always has these information in DT
> and the booting CPU cannot be changed (chosen by firmware/hardware
> configuration).

But can the booting CPU be offlined ?

If yes, then this is how things are broken right now.

Build cpufreq driver as module, boot kernel, hotplug out CPU0, insert
cpufreq driver and that will try to find these properties in CPU1.

> Therefore there is no real risk of falling although
> for correctness of DT your change makes sense.
> 
> It is too late for this cycle for me so I'll pick it up after merge window.
> Alternatively, arm-soc guys can pick it up directly with my tag:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

No worries, you can pick it up later on.

-- 
viresh
