Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754390AbeD3Oo6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:44:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54596 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbeD3Ooy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:44:54 -0400
X-Google-Smtp-Source: AB8JxZpExoN1/YdA4W1YXBalPfhywcmkyRcK6i9MLiumqOTMHJARWd45QbV0pTM758z9ngkZtbDotw==
Date: Mon, 30 Apr 2018 16:44:50 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Message-ID: <20180430144450.GI11457@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115206epcas1p2da6ae1d85708907dc99a97baf0791b4d@epcas1p2.samsung.com>
 <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> * Check for critical trip point existence in exynos_tmu_initialize()
>   so it is checked on all SoCs (except Exynos5433 for now).

Why "except Exynos5433" ?
 
> * Use dev_err() instead of pr_err().
> 
> * Fix dev_err() to reference "device tree" not "of-thermal.c".
> 
> * Remove no longer needed check from exynos4412_tmu_initialize().
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
