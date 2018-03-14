Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeCNQpv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeCNQpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:45:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985BE20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Sricharan R <sricharan@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <ab5ad9c2-2016-47ca-b748-833ff6e75f70@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robh@kernel.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1519638811-17269-1-git-send-email-sricharan@codeaurora.org>
 <1519638811-17269-15-git-send-email-sricharan@codeaurora.org>
 <20180226100425.GO26947@vireshk-i7>
 <ab5ad9c2-2016-47ca-b748-833ff6e75f70@codeaurora.org>
Message-ID: <152104594491.179530.16525167791258003396@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 14/15] cpufreq: Add module to register cpufreq on Krait CPUs
Date: Wed, 14 Mar 2018 09:45:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sricharan R (2018-02-26 02:15:59)
> Hi Viresh,
> 
> On 2/26/2018 3:34 PM, Viresh Kumar wrote:
> > On 26-02-18, 15:23, Sricharan R wrote:
> >> From: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > Is this email id still valid ?
> > 
> 
>  Yes. codeaurora id should exist.
> 

Yes it exists and I am checking it.
