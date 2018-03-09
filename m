Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeCIV36 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:29:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeCIV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:29:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57179602A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH 1/6] reset: qcom: AOSS (Always on subsystem) reset
 controller
To: Sibi S <sibis@codeaurora.org>, Rob Herring <robh@kernel.org>
Cc: bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
 <1520243613-30393-2-git-send-email-sibis@codeaurora.org>
 <20180307213514.4sv7ucxo25jpomz3@rob-hp-laptop>
 <519c6298-0619-d98e-6c45-c70936af93c3@codeaurora.org>
From: Trilok Soni <tsoni@codeaurora.org>
Message-ID: <4a45b7a5-5bc4-ed03-0cf4-c87c8b99fbb2@codeaurora.org>
Date: Fri, 9 Mar 2018 13:29:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <519c6298-0619-d98e-6c45-c70936af93c3@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sibi,

One cosmetic comment below.

On 3/9/2018 6:55 AM, Sibi S wrote:
> +
>>> +This binding describes a reset-controller found on AOSS (Always on 
>>> SubSysem)
>>> +for Qualcomm SDM845 SoCs.

S/SubSysem/Subsytem

---Trilok Soni
