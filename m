Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965703AbeEXJC3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:02:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46575 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965520AbeEXJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:02:26 -0400
X-Google-Smtp-Source: AB8JxZpbkROamLWizvD+IcQgx1/7VPl1aELvEAuKctATG8ujjAmjX3yB/w4CV5ZtMg4+cG1dtFxbkA==
Date: Thu, 24 May 2018 14:32:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/2] Kryo CPU scaling driver
Message-ID: <20180524090223.qwyugcxde4wznzno@vireshk-i7>
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-18, 11:57, Ilia Lin wrote:
> [v12]
>  * Addressed comments from Sudeep and Viresh about the single init
> 
> [v11]
>  * Addressed comment from Russel about device_node reference
>  * Addressed comment from Sudeep about the late_initcall
>  * Transformed init into probe to take care of deferals
> 
> [v10]
>  * Split the series into domains
>  * Addressed comments from Viresh and Sudeep about logical CPU numbering.
> 
> The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
> The driver reads eFuse information and chooses the required OPP subset
> by passing the OPP supported-hw parameter.
> 
> The series depends on the series from Viresh:
> https://patchwork.kernel.org/patch/10418139/
> 
> The previous spin was here:
> https://patchwork.kernel.org/patch/10421143/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
