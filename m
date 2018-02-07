Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeBGEPf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:15:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeBGEPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:15:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB97B601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180206185440.GJ9465@builder>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <53642249-89c1-3fc0-8ad8-7a954b138bb2@codeaurora.org>
Date: Wed, 7 Feb 2018 09:45:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180206185440.GJ9465@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 12:24 AM, Bjorn Andersson wrote:
> On Thu 25 Jan 08:32 PST 2018, Rajendra Nayak wrote:
>> +		spmi_bus: qcom,spmi@c440000 {
> [..]
>> +		};
>> +
> 
> While we have the chance, please remove this empty line.

Will do. Thanks for the review.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
