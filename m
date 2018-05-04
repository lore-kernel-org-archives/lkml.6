Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEDGtG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:49:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEDGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:49:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9023360249
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc: "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>, "'Rob Herring'" <robh@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Liam Girdwood'" <lgirdwood@gmail.com>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Andy Gross'" <andy.gross@linaro.org>,
        "'David Brown'" <david.brown@linaro.org>,
        "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Will Deacon'" <will.deacon@arm.com>,
        "'Linux Clock List'" <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "'open list:ARM/QUALCOMM SUPPORT'" <linux-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Nayak, Rajendra'" <rnayak@codeaurora.org>,
        "'Amit Kucheria'" <amit.kucheria@linaro.org>,
        "'Nicolas Dechesne'" <nicolas.dechesne@linaro.org>,
        <celster@codeaurora.org>, <tfinkel@codeaurora.org>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org> <1522358807-10413-9-git-send-email-ilialin@codeaurora.org> <20180402091617.GA3572@vireshk-i7> <CAKohpo=cw+2Leuwa6XjEYh4kVYK093A5eckUmPBDutgqeqpvog@mail.gmail.com>
In-Reply-To: <CAKohpo=cw+2Leuwa6XjEYh4kVYK093A5eckUmPBDutgqeqpvog@mail.gmail.com>
Subject: RE: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the msm8996
Date: Fri, 4 May 2018 09:48:46 +0300
Message-ID: <003001d3e373$f94db540$ebe91fc0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLEuuwO8n7diDON4clexiIwmxRQwALUSX3IAc2TstQAp9MWXKITI/gA
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w446nBBk031298

Kryo has single clock per cluster. I define here a shared OPP table per cluster.

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Friday, May 4, 2018 09:04
> To: Ilia Lin <ilialin@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Rob Herring <robh@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Liam
> Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Andy Gross <andy.gross@linaro.org>; David Brown
> <david.brown@linaro.org>; Catalin Marinas <catalin.marinas@arm.com>; Will
> Deacon <will.deacon@arm.com>; Linux Clock List <linux-
> clk@vger.kernel.org>; devicetree@vger.kernel.org; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-pm@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; open list:ARM/QUALCOMM SUPPORT <linux-
> soc@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; Nayak,
> Rajendra <rnayak@codeaurora.org>; Amit Kucheria
> <amit.kucheria@linaro.org>; Nicolas Dechesne
> <nicolas.dechesne@linaro.org>; celster@codeaurora.org;
> tfinkel@codeaurora.org
> Subject: Re: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the
> msm8996
> 
> On 2 April 2018 at 14:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> >> +     cluster0_opp: opp_table0 {
> >> +             compatible = "operating-points-v2";
> >> +             opp-shared;
> >
> > Is Kryo like krait where CPUs do DVFS independently ? If yes, then
> > opp-shared thing should be dropped.
> 
> Have you ever replied to this question ? Sorry, but I am not able to find it in
> my inbox :(
