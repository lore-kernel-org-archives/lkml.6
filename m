Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeEaDxs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:53:48 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35790 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932672AbeEaDxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:53:44 -0400
X-Google-Smtp-Source: ADUXVKKVa+hLtZ9xJx2QkJXNKR98XlMAP8SGRocXl+686I+z6zFyvIcRopdoBdoeDetZ8mWeBDjoPA==
Date: Wed, 30 May 2018 22:53:42 -0500
From: Rob Herring <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/9] PM / Domains: dt: Allow power-domain property to
 be a list of specifiers
Message-ID: <20180531035342.GA14184@rob-hp-laptop>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-6-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529100421.31022-6-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:04:17PM +0200, Ulf Hansson wrote:
> To be able to describe topologies where devices are partitioned across
> multiple power domains, let's extend the power-domain property to allow
> being a list of PM domain specifiers.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Fixed comments from Geert. Re-worded to "PM domain specifiers" and
> 	clarified DT example.
> 
> ---
>  .../bindings/power/power_domain.txt           | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
