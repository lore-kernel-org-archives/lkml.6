Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934245AbeDXNZx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:25:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:53000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934081AbeDXNZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:25:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="48676165"
Message-ID: <1524576345.2597.31.camel@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc2
From: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 24 Apr 2018 21:25:45 +0800
In-Reply-To: <20180420161834.GA22776@localhost.localdomain>
References: <20180420161834.GA22776@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eduardo,

On 五, 2018-04-20 at 09:18 -0700, Eduardo Valentin wrote:
> Hello Linus,
> 
> Here are a couple of fixes on thermal subsystem.
> Please consider pulling from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> thermal fixes
> 
> to receive Thermal Management updates for v4.17-rc2 with top-most
> 
> e04907dbc25930b88ee2328fe692c776f63ddf2c:
> 
>   dt-bindings: thermal: Remove "cooling-{min|max}-level" properties
> (2018-04-18 07:04:28 -0700)
> 
> on top of commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
As this does not hit 4.17-rc2, and I have some thermal core fixes now,
would you mind rebase the patches on top of 4.17-rc2, and send the pull
request to me, including the exynos fixes, so that I can pull and queue
for next -rc?

thanks,
rui
> BR,
> 
> Eduardo Valentin
> 
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (1):
>       dt-bindings: thermal: remove no longer needed samsung thermal
> properties
> 
> Viresh Kumar (1):
>       dt-bindings: thermal: Remove "cooling-{min|max}-level"
> properties
> 
>  .../devicetree/bindings/thermal/exynos-thermal.txt | 23 +++++-------
> ----------
>  .../devicetree/bindings/thermal/thermal.txt        | 16 +-----------
> ---
>  2 files changed, 6 insertions(+), 33 deletions(-)
