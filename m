Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeBIJoZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:44:25 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:50252 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeBIJoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:44:22 -0500
X-Google-Smtp-Source: AH8x224zdx8YlqQB3xkFnajMfz18Lh9l938TRm58Y/auLgfioNTmKGS8ND8TrE3IM4+D8bNrn0Yvsw==
Date: Fri, 9 Feb 2018 15:14:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        daniel.thompson@linaro.org
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
Message-ID: <20180209094419.GN28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
 <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-18, 15:30, Daniel Lezcano wrote:
> Agree the cpufreq driver can be unloaded and this part needs some
> adjustments.

Also note that the cpufreq cooling device has two separate set of
callbacks, one for the power-specific callbacks. You haven't taken
care of them in the combo thing.

-- 
viresh
