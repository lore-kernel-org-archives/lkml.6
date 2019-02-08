Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972F1C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6BA20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfBHOT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:19:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52004 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbfBHOT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:19:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6D1A78;
        Fri,  8 Feb 2019 06:19:26 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3283F557;
        Fri,  8 Feb 2019 06:19:19 -0800 (PST)
Subject: Re: [PATCHv7 6/6] coresight: cpu-debug: Add support for Qualcomm Kryo
To:     saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        tingwei@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <624b472e-f662-581a-5fc3-45943c4143a9@arm.com>
Date:   Fri, 8 Feb 2019 14:19:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2019 00:53, Sai Prakash Ranjan wrote:
> Add support for coresight CPU debug module on Qualcomm
> Kryo CPUs. This patch adds the UCI entries for Kryo CPUs
> found on MSM8996 which shares the same PIDs as ETMs.
> 
> Without this, below error is observed on MSM8996:
> 
> [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
