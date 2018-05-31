Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeEaFWl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:22:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45792 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbeEaFWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:22:37 -0400
X-Google-Smtp-Source: ADUXVKLjGDHTdFtXpJzWZCu8UbRT4zyiTq9DqsGzDRmdne4y6+efFsw8zYsi5dfH9iWni70Yf+niTQ==
Date: Thu, 31 May 2018 10:52:34 +0530
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
Message-ID: <20180531052234.tp6pw45ftsf3g2el@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
 <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
 <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
 <CAJKOXPftrzwLMSDeTBBxG-nvpsriBuPEwQAViTcE3DYRYsnzmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPftrzwLMSDeTBBxG-nvpsriBuPEwQAViTcE3DYRYsnzmg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-18, 14:32, Krzysztof Kozlowski wrote:
> OK, I see the possibility although it is still far away from use
> cases. You cannot hotplug booting CPU (CPU0) on Exynos kernels. It
> never worked. Strictly speaking - offlining will work. But bringing it
> online will likely hang the system.

True and I used the following out of tree patch for a long time for my
dual A15 exynos to make hotplug work.

https://git.linaro.org/people/vireshk/backup/linux.git/commit/?h=bkp/exynos/hotplug&id=aab8a906a70b8f1fb15a4b7bd2ee27e6dcabf79d

-- 
viresh
