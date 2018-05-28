Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425058AbeE1Mok (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:44:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38780 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937857AbeE1K5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:57:38 -0400
X-Google-Smtp-Source: AB8JxZpRrjZaHCZVJ9paOUHoM3QAARxFgqetThSF2zAky2X0A1/I0LUhzdaq+C+M6LN3cxtvyuRceA==
Date: Mon, 28 May 2018 16:27:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm: dts: sun: Add missing cooling device
 properties for CPUs
Message-ID: <20180528105734.bkplm7tfaqsurdrn@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <eded393f4b508a1f377f9af6859a3b82a6787e1c.1527244201.git.viresh.kumar@linaro.org>
 <20180528084446.g24fphqqac2hi3rr@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528084446.g24fphqqac2hi3rr@flea>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-05-18, 10:44, Maxime Ripard wrote:
> Hi,
> 
> On Fri, May 25, 2018 at 04:01:52PM +0530, Viresh Kumar wrote:
> > The cooling device properties, like "#cooling-cells" and
> > "dynamic-power-coefficient", should either be present for all the CPUs
> > of a cluster or none. If these are present only for a subset of CPUs of
> > a cluster then things will start falling apart as soon as the CPUs are
> > brought online in a different order. For example, this will happen
> > because the operating system looks for such properties in the CPU node
> > it is trying to bring up, so that it can register a cooling device.
> > 
> > Add such missing properties.
> > 
> > Fix other missing properties (clocks, OPP, clock latency) as well to
> > make it all work.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> The prefix should be sunxi and not sun, but it looks good to me
> otherwise.
> 
> Let me know what your preferred merge method is.

Please pick it up directly and send it as part of your pull request.
Do you want me to resend or can you fix the $subject ?

Thanks.

-- 
viresh
