Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeFERIT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:08:19 -0400
Received: from foss.arm.com ([217.140.101.70]:58764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbeFERIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:08:17 -0400
Date: Tue, 5 Jun 2018 18:08:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ACPI / PPTT: fix build when CONFIG_ACPI_PPTT is
 not enabled
Message-ID: <20180605170812.d5ewm5crou3qnkuh@armageddon.cambridge.arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
 <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:35:03PM +0100, Sudeep Holla wrote:
> Though CONFIG_ACPI_PPTT is selected by platforms and nor user visible,
> it may be useful to support the build with CONFIG_ACPI_PPTT disabled.
> 
> This patch adds the missing dummy/boiler plate implementation to fix
> the build.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/acpi.h      | 15 +++++++++++++++
>  include/linux/cacheinfo.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)

I queued this patch for now, it's a good clean-up regardless of whether
we disable PPTT temporarily or not.

Thanks.

-- 
Catalin
