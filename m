Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCNRkL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:40:11 -0400
Received: from foss.arm.com ([217.140.101.70]:57316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbeCNRkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:40:09 -0400
Date: Wed, 14 Mar 2018 17:40:04 +0000
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
Subject: Re: [PATCH v6 23/25] MAINTAINERS: Update files for PSCI
Message-ID: <20180314174003.zj34hqgxrldqqzqw@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-24-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521046715-30683-24-git-send-email-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:58:33PM +0100, Ulf Hansson wrote:
> Some new files have been for the PSCI firmware driver, let's make the
> expression more generic to cover them all.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4623caf..dda16cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11082,7 +11082,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> -F:	drivers/firmware/psci*.c
> +F:	drivers/firmware/psci*
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h

As mentioned in my another reply, I suspect it's better to give
ourselves a drivers/firmware/psci/ directory earlier in the series
(updating MAINTAINERS at the same time).

Otherwise, this looks fine to me.

Thanks,
Mark.
