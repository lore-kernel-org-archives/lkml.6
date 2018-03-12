Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeCLEcP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:32:15 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:42954 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeCLEcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:32:13 -0400
X-Google-Smtp-Source: AG47ELtgY+Y6pvTyiyPBpPMz/fAh2uyqD8U87ZqTw0Va7kkisNVqvjh/uE0jWeMaE64X7H6evUKyQw==
Date: Mon, 12 Mar 2018 10:02:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
Message-ID: <20180312043209.GS6842@vireshk-i7>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-01-18, 15:22, Viresh Kumar wrote:
> This extends the sysfs interface for thermal cooling devices and exposes
> some pretty useful statistics. These statistics have proven to be quite
> useful specially while doing benchmarks related to the task scheduler,
> where we want to make sure that nothing has disrupted the test,
> specially the cooling device which may have put constraints on the CPUs.
> The information exposed here tells us to what extent the CPUs were
> constrained by the thermal framework.

@Eduardo/Zhang: Are you going to merge this for 4.17 ?

-- 
viresh
