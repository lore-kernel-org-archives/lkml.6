Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeBGKUu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:20:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41229 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753376AbeBGKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:20:48 -0500
X-Google-Smtp-Source: AH8x224ut/fjtddzKoo8wwdFxtzevAarNNj/sjYChOBnqmeMt7tJWbAOqRQRqXVsGCMHOhmw5iDjcg==
Date: Wed, 7 Feb 2018 15:50:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20180207102045.GR28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
 <20180207090448.GP28462@vireshk-i7>
 <4d66ce4f-c8eb-092a-04b5-a705793a1796@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d66ce4f-c8eb-092a-04b5-a705793a1796@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-18, 11:15, Daniel Lezcano wrote:
> Do you mean s/CPU_THERMAL/CPU_FREQ_THERMAL/ in include/linux/cpu_cooling.h ?

Yes, but also in the .c file (which you have done in 5/8 anyway).

-- 
viresh
