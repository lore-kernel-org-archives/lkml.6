Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeCVKJ5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:09:57 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:37704 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeCVKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:09:54 -0400
X-Google-Smtp-Source: AG47ELsZAeh7DN/OQllDlTi5ViZY55TwLb1URT0hmin/pXG74VIKbjvF7oHUBetNtHyAinK1jJCAAkUmzlJj50zdqjY=
MIME-Version: 1.0
In-Reply-To: <20180322100024.xy2ipqzgluj6fhs4@vireshk-mac-ubuntu>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <596dd0d16dcb31fd35d6a38835d1a3d56254b6ce.1513926033.git.viresh.kumar@linaro.org>
 <CAPDyKFontDwvpS97xBskNE-FLMo3HPDLthCEkviZv8rKdA8t=g@mail.gmail.com> <20180322100024.xy2ipqzgluj6fhs4@vireshk-mac-ubuntu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Mar 2018 11:09:53 +0100
Message-ID: <CAPDyKFokfr+RJzL5zNL-mvEwDBF5+ReJRmo98pQV+oGkaDSM8g@mail.gmail.com>
Subject: Re: [PATCH 4/7] PM / Domain: Add support to parse domain's OPP table
To: Viresh Kumar <viresh.kumar@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 March 2018 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-03-18, 10:31, Ulf Hansson wrote:
>> Nitpick, perhaps change this to:
>>
>> if (gpd->set_performance_state)
>>        dev_pm_opp_of_remove_table(&gpd->dev);
>
> I probably did that to save the 80 column thing. So crossing 80 columns in this
> case is fine ?

If that is needed, then okay!

Kind regards
Uffe
