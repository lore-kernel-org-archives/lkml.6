Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeBRX00 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:26:26 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38283 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeBRX0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:26:24 -0500
X-Google-Smtp-Source: AH8x224TKBgmllINqjnIjQ1+Z+VD6O0PLPKeIUXF28P5+F4AU3rp+lj2DI0HvEDVCnyEtRh1EFyNPQ==
Date: Sun, 18 Feb 2018 17:26:23 -0600
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 03/10] ARM: dts: mt7623: Remove "cooling-{min|max}-level"
 for CPU nodes
Message-ID: <20180218232622.au3cjy7p47xabvv7@rob-hp-laptop>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <33d7494641d2f89c827e5e09d1143f125c33e784.1518166039.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d7494641d2f89c827e5e09d1143f125c33e784.1518166039.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 02:28:03PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 4 ----
>  arch/arm/boot/dts/mt7623.dtsi                                  | 2 --
>  2 files changed, 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
