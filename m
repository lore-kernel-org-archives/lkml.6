Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeEAJA0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:00:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40635 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEAJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:00:22 -0400
X-Google-Smtp-Source: AB8JxZr2hMI7AHVm5SNZvE1807PblW8SSSZpDSjROOdq8aZfcWhf0UXcCJCsqLt/VK/RugU4QWns7A==
Date: Tue, 1 May 2018 11:00:18 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Message-ID: <20180501090018.GF27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
 <20180430144450.GI11457@mai>
 <CGME20180430152416eucas1p10bde2c1501e7f5f4b284caca3b630ea3@eucas1p1.samsung.com>
 <5229331.iYYXeBBCxK@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5229331.iYYXeBBCxK@amdc3058>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:24:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday, April 30, 2018 04:44:50 PM Daniel Lezcano wrote:
> > On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > * Check for critical trip point existence in exynos_tmu_initialize()
> > >   so it is checked on all SoCs (except Exynos5433 for now).
> > 
> > Why "except Exynos5433" ?
> 
> I was a bit vague here - Exynos5433 DTS needs to be fixed first to define
> critical trip points.

Is it possible to fix the DT in the series, so we get rid of the "FIXME" ?

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
