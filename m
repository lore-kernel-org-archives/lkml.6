Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBHKSJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:18:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:40975 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeBHKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:18:05 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: remove at32ap-cpufreq
Date: Thu, 08 Feb 2018 11:16:21 +0100
Message-ID: <1921177.y5JRJ3llXq@aspire.rjw.lan>
In-Reply-To: <20180119054441.GM3012@vireshk-i7>
References: <20180118200202.11883-1-clabbe.montjoie@gmail.com> <20180119054441.GM3012@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 19, 2018 6:44:41 AM CET Viresh Kumar wrote:
> On 18-01-18, 21:02, Corentin Labbe wrote:
> > Since AVR32 arch was removed, at32ap-cpufreq is useless.
> > Remove this driver.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/cpufreq/Kconfig          |  10 ---
> >  drivers/cpufreq/Makefile         |   1 -
> >  drivers/cpufreq/at32ap-cpufreq.c | 127 ---------------------------------------
> >  3 files changed, 138 deletions(-)
> >  delete mode 100644 drivers/cpufreq/at32ap-cpufreq.c
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
