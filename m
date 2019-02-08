Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344EC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B0520844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfBHOXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:23:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52120 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfBHOXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:23:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CEFA78;
        Fri,  8 Feb 2019 06:23:54 -0800 (PST)
Received: from en101 (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94AE83F557;
        Fri,  8 Feb 2019 06:23:50 -0800 (PST)
Date:   Fri, 8 Feb 2019 14:23:43 +0000
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv7 2/6] arm64: dts: qcom: msm8998: Add Coresight support
Message-ID: <20190208142343.GA9649@en101>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <bcff6cd655c565568caa2d5a9b20d95e619afb1e.1548981329.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcff6cd655c565568caa2d5a9b20d95e619afb1e.1548981329.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:23:10AM +0530, Sai Prakash Ranjan wrote:
> Enable coresight support by adding device nodes for the
> available source, sinks and channel blocks on MSM8998.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
> 
> This depends on MSM8998 rpm clocks and rpmcc node by Jeffrey Hugo
> and Marc Gonzalez [1][2][3].
> 
> [1] https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
> [2] https://lore.kernel.org/lkml/1548866144-30265-1-git-send-email-jhugo@codeaurora.org/
> [3] https://lore.kernel.org/lkml/6da00186-e7c9-c93d-a80a-65eda2516451@free.fr/
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 435 ++++++++++++++++++++++++++
>  1 file changed, 435 insertions(+)

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
