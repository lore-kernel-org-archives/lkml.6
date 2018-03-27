Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeC0XsY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:48:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeC0XsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:48:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67610606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 2/2] dt-bindings: regulator: add QCOM RPMh regulator
 bindings
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
 <20180321024311.GW2186@sirena.org.uk>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <63851bce-65c2-76a2-8b75-bc268a998457@codeaurora.org>
Date: Tue, 27 Mar 2018 16:48:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180321024311.GW2186@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 03/20/2018 07:43 PM, Mark Brown wrote:
> On Fri, Mar 16, 2018 at 06:09:11PM -0700, David Collins wrote:
>> Introduce bindings for RPMh regulator devices found on some
>> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

Looking through the DT binding patches sent to devicetree@vger.kernel.org,
it seemed like the preferred style is:
[PATCH] dt-bindings: subsystem: ...

I can change the subject line for this patch to be:
"[PATCH 2/2] regulator: dt-bindings: add QCOM RPMh regulator bindings"
if you prefer.


>> +=========================================
>> +Second Level Nodes - Regulators
>> +=========================================
>> +
>> +- regulator-name
> 
> This document appears to be reproducing the standard regulator bindings;
> there is no need to do that, just reference them.

Sure, I'll remove this.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
