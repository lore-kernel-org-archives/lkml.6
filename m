Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBSDnn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:43:43 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40495 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeBSDnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:43:41 -0500
X-Google-Smtp-Source: AH8x225gkKZOCcIx4tf6wWANc+IA0BTi5M8savNSkMB593O/Cn4o+VZhJtEWqt4hTF5OnB8ci7jpQg==
Date: Mon, 19 Feb 2018 09:13:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] dt-bindings: thermal: Remove
 "cooling-{min|max}-level" properties
Message-ID: <20180219034338.GI28462@vireshk-i7>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
 <20180218232906.jkpymin3a4qxjhnc@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218232906.jkpymin3a4qxjhnc@rob-hp-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-18, 17:29, Rob Herring wrote:
> On Fri, Feb 09, 2018 at 02:28:10PM +0530, Viresh Kumar wrote:
> > The "cooling-min-level" and "cooling-max-level" properties are not
> > parsed by any part of kernel currently and the max cooling state of a
> > CPU cooling device is found by referring to the cpufreq table instead.
> 
> What about non-CPU devices? A fan for example.

Even they aren't using these properties. The gpio-fan binding[1] for
example uses the "gpio-fan,speed-map" property instead to find the
number of states it supports.

-- 
viresh

[1] Documentation/devicetree/bindings/gpio/gpio-fan.txt
