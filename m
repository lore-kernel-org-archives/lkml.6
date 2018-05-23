Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeEWFsw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:48:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41731 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEWFst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:48:49 -0400
X-Google-Smtp-Source: AB8JxZrKFPZTImZEDKzcq8UP0UTKWK7cHaAFpDMKdxhXLd0chL2PkEVKbzqZzatp6igGDdb2/1MO1g==
Date: Wed, 23 May 2018 11:18:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Message-ID: <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
 <20180522193139.GA21623@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522193139.GA21623@rob-hp-laptop>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 14:31, Rob Herring wrote:
> On Sat, May 19, 2018 at 11:04:50PM +0530, Taniya Das wrote:
> > +		freq-domain-0 {
> > +			compatible = "cpufreq";
> > +			reg = <0x17d43920 0x4>,
> > +			     <0x17d43110 0x500>,
> > +			     <0x17d41000 0x4>;
> > +			reg-names = "perf_base", "lut_base", "en_base";
> > +			qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3>;

I was thinking, can't we add platform specific properties in the CPU
nodes ? If yes, then we can point the phandle of fw node from the CPUs
and this awkward list can go away.

-- 
viresh
