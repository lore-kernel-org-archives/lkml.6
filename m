Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbeE1HaE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:30:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbeE1H37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:29:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C06B7600E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
 <20180522193139.GA21623@rob-hp-laptop>
 <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
 <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
 <cba1616d-ad12-599b-4351-3c7240de852a@codeaurora.org>
 <20180524054333.56vga66xrkfuqtkr@vireshk-i7>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <ba22b1f2-3a9a-0e23-04ee-74e173c531c1@codeaurora.org>
Date: Mon, 28 May 2018 12:59:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524054333.56vga66xrkfuqtkr@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Could you please suggest if the below looks okay to be implemented?

On 5/24/2018 11:13 AM, Viresh Kumar wrote:
> On 24-05-18, 10:48, Taniya Das wrote:
>> Hello Rob, Viresh,
>>
>> Thank you for the comments. If I understand correctly, the device tree nodes
>> should look something like the below.
>>
>> Though I am not sure if any vendor name could be associated in the cpu
>> nodes.
> 
> Well Rob said Yes to that I think.
> 
>> Please suggest if my understanding is wrong.
>>
>> cpu@0 {
>> 	qcom,freq-domain = <&freq_domain_table0>;
>> 	…
>> };
>>
>> same follows for cpu 1/2/3
>>
>> cpu@400 {
>> 	qcom,freq-domain = <&freq_domain_table1>;
>> 	…
>> };
>> same follows for cpu 5/6/7
>>
>> freq_domain_table0 : freq_table {
>> 	reg = < >, < >, < > ;
>> 	reg-names = "perf_base", "lut_base", "en_base";
>> };
>>
>> freq_domain_table1 : freq_table {
>> 	reg = < >, < >, < > ;
>> 	reg-names = "perf_base", "lut_base", "en_base";
>> };
> 
> Mostly yes.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
