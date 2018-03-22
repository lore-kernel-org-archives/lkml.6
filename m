Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeCVKA3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:00:29 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:33942 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeCVKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:00:28 -0400
X-Google-Smtp-Source: AG47ELu0EDyT8gxwCtWA0yYd6eTvoXHdIdDrDnfAEx9Fu5qVAAcFLqIKLtu3moxhwUvkAaBXtY95WA==
Date: Thu, 22 Mar 2018 18:00:24 +0800
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] PM / Domain: Add support to parse domain's OPP table
Message-ID: <20180322100024.xy2ipqzgluj6fhs4@vireshk-mac-ubuntu>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
 <596dd0d16dcb31fd35d6a38835d1a3d56254b6ce.1513926033.git.viresh.kumar@linaro.org>
 <CAPDyKFontDwvpS97xBskNE-FLMo3HPDLthCEkviZv8rKdA8t=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFontDwvpS97xBskNE-FLMo3HPDLthCEkviZv8rKdA8t=g@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-18, 10:31, Ulf Hansson wrote:
> Nitpick, perhaps change this to:
> 
> if (gpd->set_performance_state)
>        dev_pm_opp_of_remove_table(&gpd->dev);

I probably did that to save the 80 column thing. So crossing 80 columns in this
case is fine ?

-- 
viresh
