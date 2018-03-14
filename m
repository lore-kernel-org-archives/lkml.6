Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeCNRTW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:19:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56832 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeCNRTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:19:20 -0400
Date: Wed, 14 Mar 2018 17:19:15 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/25] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Message-ID: <20180314171914.tdwtppsvjsgxiqlv@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Wed, Mar 14, 2018 at 05:58:10PM +0100, Ulf Hansson wrote:
> For ARM, the PSCI firmware interface may be managing the power to the CPUs.
> Depending on the SoC, CPUs may also be arranged in hierarchical manner, which
> could add another level of complexity from a CPU idle management point of view.
> 
> PSCI v1.0+ adds support for the so called OS initiated CPU suspend mode, which
> enables a more fine grained method, allowing Linux to get more control, in
> regards to being energy efficient. This is typically useful for these kind of
> complex battery driven platforms.

> The series is based on v4.16-rc5, but applies also as of today to Rafael's
> linux-pm.git next branch. The code has been tested on a QCOM 410c dragonboard
> and I except that test coverage should be increased by some more boards
> shortly (for ARM64 with PSCI OSI support - only a few DT changes are needed).

Do we have any numbers to show how this affects energy efficiency?

Are there any other platforms with OSI support?

Thanks,
Mark.
