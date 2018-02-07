Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeBGEOe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:14:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeBGEOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:14:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AAFB601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180126221501.GD28313@codeaurora.org>
 <CAL_JsqJ1xjQ5ZP-KXeZQ0s=ib8GTfvfYjFqyy+Zcub-akCs7Bw@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <cf69e160-4f03-f13c-aa39-bd12ed3d9d15@codeaurora.org>
Date: Wed, 7 Feb 2018 09:44:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ1xjQ5ZP-KXeZQ0s=ib8GTfvfYjFqyy+Zcub-akCs7Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[]..

>>> +             };
>>> +
>>> +             gcc: clock-controller@100000 {
>>> +                     compatible = "qcom,gcc-sdm845";
>>> +                     reg = <0x100000 0x1f0000>;
>>> +                     #clock-cells = <1>;
>>> +                     #reset-cells = <1>;
>>> +             };
>>> +
>>> +             tlmm: pinctrl@03400000 {
>>
>> Drop leading zeroes please.
> 
> Build dtbs with W=2 and fix the warnings so reviewers don't have to
> waste their time on these issues.

Noted. Thanks Rob.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
