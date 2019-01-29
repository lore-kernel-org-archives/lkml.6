Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E56DC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299F22148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfA2K3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:29:24 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:24510 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2K3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:29:24 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 754E613F8B5;
        Tue, 29 Jan 2019 11:28:36 +0100 (CET)
Subject: Re: [PATCHv5 0/7] Add coresight support for SDM845, MSM8998 and
 MSM8996
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
        DT <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <6994f4cc-e1fe-d418-1b6d-8b00bf9fc042@free.fr>
Date:   Tue, 29 Jan 2019 11:28:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2019 20:13, Sai Prakash Ranjan wrote:

> This patch series adds support for coresight on SDM845, MSM8998, and MSM8996.
> 
> Patch 2 adds device tree nodes for MSM8998 coresight components.
> 
> Patch 2 depends on MSM8998 rpm clocks and rpmcc nodes:
>  https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
>  https://lore.kernel.org/lkml/8f431bde-0e67-8088-5119-7a951d0ead52@free.fr/
> 
> This patch series has been tested on SDM845 MTP and MSM8996
> based Dragonboard 820c and MSM8998 MTP.
> 
> v5:
>  * Added coresight support for MSM8998.
>  * Added ETM PIDs for SDM845 and MSM8996 as suggested by Suzuki.
>  * Added UCI table for Coresight CPU debug module.

Great! Thanks :-)
