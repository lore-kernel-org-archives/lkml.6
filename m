Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0175FC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29202175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfBDSVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:21:53 -0500
Received: from foss.arm.com ([217.140.101.70]:60628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfBDSVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:21:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF57EBD;
        Mon,  4 Feb 2019 10:21:52 -0800 (PST)
Received: from queper01-ThinkPad-T460s (unknown [10.37.10.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2429E3F71E;
        Mon,  4 Feb 2019 10:21:49 -0800 (PST)
Date:   Mon, 4 Feb 2019 18:21:48 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v4 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190204182145.wgl3a72s2cwargdk@queper01-ThinkPad-T460s>
References: <20190204110952.16025-1-quentin.perret@arm.com>
 <20190204110952.16025-2-quentin.perret@arm.com>
 <20190204180303.GD117604@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204180303.GD117604@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 Feb 2019 at 10:03:03 (-0800), Matthias Kaehlcke wrote:
> There is the option to remove the OPP check from the cpufreq drivers
> and instead return an error from dev_pm_opp_of_register_em(), but with
> the more complex error handling it might be more hassle than it's
> worth.

Agreed. And that would make the API a bit weird I guess, so I preferred
the simple solution.

> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks !
Quentin
