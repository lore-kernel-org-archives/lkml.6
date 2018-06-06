Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVDfqjrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05C07605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932288AbeFFGoF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:44:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43863 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeFFGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:44:03 -0400
X-Google-Smtp-Source: ADUXVKLb6wqTwJhrNYPDefuFytyn/Daos6Kjf2mhP7hdS2yH6Ua+MvdnRYWxG6HGk+PZAGAIWtFzU7QxfI9LSxPHvX0=
MIME-Version: 1.0
In-Reply-To: <559de2f1-fdf6-7010-2e01-d20765551065@kernel.org>
References: <559de2f1-fdf6-7010-2e01-d20765551065@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Jun 2018 08:44:02 +0200
X-Google-Sender-Auth: 6uedceDtWl7xl_cfxCpNcc71gIE
Message-ID: <CAJZ5v0jB+=cC5gJTT538Rci1kGdWK4vUqSu2c_xPBGS=nTVjbg@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 4.18-rc1
To: Shuah Khan <shuah@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 12:03 AM, Shuah Khan <shuah@kernel.org> wrote:
> Hi Rafael,

Hi Shuah,

> If it isn't too late, please pull this update. A fix came in last
> week to refine the cpupower monitor command.
>
> This cpupower update for 4.18-rc1 consists of two minor fixes.
>
> diff is attached.

Pulled, thanks!

I'll queue it up for the second half of the merge window.

Cheers,
Rafael


> ----------------------------------------------------------------
>
> The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:
>
>   Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.18-rc1
>
> for you to fetch changes up to f9652d5cae04eb5e85303c087f5842d320499c65:
>
>   cpupower : Fix header name to read idle state name (2018-05-29 10:48:33 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-4.18-rc1
>
> This cpupower update for 4.18-rc1 consists of two minor fixes.
>
> ----------------------------------------------------------------
> Abhishek Goel (1):
>       cpupower : Fix header name to read idle state name
>
> Colin Ian King (1):
>       cpupower: fix spelling mistake: "logilename" -> "logfilename"
>
>  tools/power/cpupower/bench/parse.c                 |  2 +-
>  .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 15 ++++++++++
>  .../cpupower/utils/idle_monitor/cpupower-monitor.c | 35 ++++++++++++----------
>  .../cpupower/utils/idle_monitor/cpupower-monitor.h |  9 ++++++
>  4 files changed, 45 insertions(+), 16 deletions(-)
> ----------------------------------------------------------------
