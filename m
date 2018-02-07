Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeBGKlg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:41:36 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:43836 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932101AbeBGKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:41:34 -0500
X-Google-Smtp-Source: AH8x226To0XxuwB/Frf4ZBb0BIzI6scNtZOEPdOayeoN6WKk6eUBmmlM40mxCEE21yjN4XY/LbYZfg==
Date: Wed, 7 Feb 2018 16:11:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
Message-ID: <20180207104131.GT28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <20180207091231.GQ28462@vireshk-i7>
 <54759b82-29e9-f376-bbe8-dcf683ed0cce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54759b82-29e9-f376-bbe8-dcf683ed0cce@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-18, 11:34, Daniel Lezcano wrote:
> Ok, I thought I tried the different combinations but I will double check.

You perhaps tried after the combo patch. Try after this one :)

-- 
viresh
