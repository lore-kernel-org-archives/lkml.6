Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755144AbeEXFnj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:43:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37889 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754971AbeEXFnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:43:37 -0400
X-Google-Smtp-Source: AB8JxZo1qqDUeUxjGnnLgucuYOYRl1edRXZ/s4ZkyWvwmTskrMP5kUtY1wgYIuqWQsqH7dT72/UXDw==
Date: Thu, 24 May 2018 11:13:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Taniya Das <tdas@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Message-ID: <20180524054333.56vga66xrkfuqtkr@vireshk-i7>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
 <20180522193139.GA21623@rob-hp-laptop>
 <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
 <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
 <cba1616d-ad12-599b-4351-3c7240de852a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cba1616d-ad12-599b-4351-3c7240de852a@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-18, 10:48, Taniya Das wrote:
> Hello Rob, Viresh,
> 
> Thank you for the comments. If I understand correctly, the device tree nodes
> should look something like the below.
> 
> Though I am not sure if any vendor name could be associated in the cpu
> nodes.

Well Rob said Yes to that I think.

> Please suggest if my understanding is wrong.
> 
> cpu@0 {
> 	qcom,freq-domain = <&freq_domain_table0>;
> 	…
> };
> 
> same follows for cpu 1/2/3
> 
> cpu@400 {
> 	qcom,freq-domain = <&freq_domain_table1>;
> 	…
> };
> same follows for cpu 5/6/7
> 
> freq_domain_table0 : freq_table {
> 	reg = < >, < >, < > ;
> 	reg-names = "perf_base", "lut_base", "en_base";
> };
> 
> freq_domain_table1 : freq_table {
> 	reg = < >, < >, < > ;
> 	reg-names = "perf_base", "lut_base", "en_base";
> };

Mostly yes.

-- 
viresh
