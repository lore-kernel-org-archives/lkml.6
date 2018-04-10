Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeDJDkd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 23:40:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42422 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeDJDkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 23:40:31 -0400
X-Google-Smtp-Source: AIpwx494gRBMVJLPgjR7tDXOyw5LXCvnDqfXyRPEk4NrANTAp4pzA+x9yuSTxMdZOvcmwBaewTluGA==
Date: Tue, 10 Apr 2018 09:10:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: msm8996: Add rpmpd device node
Message-ID: <20180410034028.GD7671@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-6-rnayak@codeaurora.org>
 <152328979897.180276.15963925877442657158@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152328979897.180276.15963925877442657158@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-18, 09:03, Stephen Boyd wrote:
> We should go and
> update the platform populate code to always ignore operating-points-v2
> compatible nodes too.

Will do that.

-- 
viresh
