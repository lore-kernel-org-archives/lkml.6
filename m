Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeFBGpX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeFBGpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:45:21 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <8a352fd8787cefcb19c25ca1390301f874797b9c.1527674939.git.viresh.kumar@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
References: <8a352fd8787cefcb19c25ca1390301f874797b9c.1527674939.git.viresh.kumar@linaro.org>
Message-ID: <152792192058.225090.13082340679675758540@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] OPP: Allow same OPP table to be used for multiple genpd
Date: Fri, 01 Jun 2018 23:45:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526jVIt004131

Quoting Viresh Kumar (2018-05-30 03:09:02)
> The OPP binding says:
> 
>         Property: operating-points-v2
> 
>         ...
> 
>         This can contain more than one phandle for power domain
>         providers that provide multiple power domains. That is, one
>         phandle for each power domain. If only one phandle is available,
>         then the same OPP table will be used for all power domains
>         provided by the power domain provider.
> 
> But the OPP core isn't allowing the same OPP table to be used for
> multiple domains. Update dev_pm_opp_of_add_table_indexed() to allow
> that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
