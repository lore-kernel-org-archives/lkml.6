Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbeDCKhz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:37:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32914 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754994AbeDCKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:37:53 -0400
X-Google-Smtp-Source: AIpwx49ZTGoa6+D3u4qXxqPa18sZSrEaifKrshJRJejqMvpTotB378mv9JJIJXoT2O85a5yw/pme3yb58ZCrDqr7FiU=
MIME-Version: 1.0
In-Reply-To: <1679361.0Gr8UWkMAK@aspire.rjw.lan>
References: <1679361.0Gr8UWkMAK@aspire.rjw.lan>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 3 Apr 2018 16:07:52 +0530
X-Google-Sender-Auth: 4LYHe1oUWUuUnBSmUxjA7IX2KO0
Message-ID: <CAOh2x=m_QPyCJri9XyM9TYZe10F2mDs6P3uPgerGFM5AxsSo-A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Do not include debugfs.h
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 3:22 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The intel_pstate driver doesn't use debugfs any more, so drop
> linux/debugfs.h from the list of included headers in it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    1 -
>  1 file changed, 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
