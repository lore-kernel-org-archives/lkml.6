Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeDIPRU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:17:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDIPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:17:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A50696081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 9 Apr 2018 09:17:14 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] PM / OPP: Add dev_pm_opp_get_of_node()
Message-ID: <20180409151714.GB5491@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-2-rnayak@codeaurora.org>
 <152310602935.180276.13934458024242240384@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152310602935.180276.13934458024242240384@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 06:00:29AM -0700, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-03-15 21:08:18)
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > This adds a new helper to let the power domain drivers to access
> > opp->np, so that they can read platform specific properties from the
> > node.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> 
> Are there two versions of this patch floating around?

The other one was mine, but it is identical to this.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
