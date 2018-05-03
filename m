Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeECANF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 20:13:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeECAND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 20:13:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 427D06037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=UDUKg58xe+3C5QUbFwFkO8d3c_tzxmfPDzdv1KXZ3W9g@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <db8970ea-05f4-e7c0-52fa-070c7a6b8d2e@codeaurora.org>
Date: Wed, 2 May 2018 17:13:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UDUKg58xe+3C5QUbFwFkO8d3c_tzxmfPDzdv1KXZ3W9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 09:37 AM, Doug Anderson wrote:
> On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
>> +- vdd_l26-supply
>> +- vdd_lvs1_lvs2-supply
>> +- vdd_lvs1_lvs2-supply
>> +       Usage:      optional (PM8998 only)
>> +       Value type: <phandle>
>> +       Definition: phandle of the parent supply regulator of one or more of the
>> +                   regulators for this PMIC.
> 
> One small additional nit here is that "vdd_lvs1_lvs2-supply" is listed twice.

I'll remove the duplicate.


> Also on the schematics (and in the PM8998 datasheet) I have this is
> "VIN_LVS_1_2".  It seems like you should be consistent here and call
> this "vin-lvs-1-2-supply".

I was trying to keep the naming consistent within device tree binding
documentation for LVS vs LDO and SMPS (e.g. 'vdd' vs 'vin' prefix).  I
suppose that I can change this to match the hardware documentation pin
name.  I can also change '_' to '-' in the supply names if that is preferred.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
