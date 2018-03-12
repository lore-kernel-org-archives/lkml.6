Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeCLEcz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:32:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35061 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbeCLEcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:32:53 -0400
X-Google-Smtp-Source: AG47ELtG8D4I4LoTb2sGo6xdgx2D/zGCnEjnbeIR0XFuE9ZlIh+b6O8YKW8cdehxvg2vuWFz8K6S+g==
Date: Mon, 12 Mar 2018 10:02:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/10] ARM64: dts: meson: Remove
 "cooling-{min|max}-level" for CPU nodes
Message-ID: <20180312043250.GT6842@vireshk-i7>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
 <303e6c56-8076-e590-c778-81cb8c0181ed@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303e6c56-8076-e590-c778-81cb8c0181ed@baylibre.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-18, 10:03, Neil Armstrong wrote:
> On 09/02/2018 09:58, Viresh Kumar wrote:
> > The "cooling-min-level" and "cooling-max-level" properties are not
> > parsed by any part of the kernel currently and the max cooling state of
> > a CPU cooling device is found by referring to the cpufreq table instead.
> > 
> > Remove the unused properties from the CPU nodes.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> > index 1448c3dba08e..658215c9822c 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> > @@ -209,14 +209,10 @@
> >  };
> >  
> >  &cpu0 {
> > -	cooling-min-level = <0>;
> > -	cooling-max-level = <6>;
> >  	#cooling-cells = <2>;
> >  };
> >  
> >  &cpu4 {
> > -	cooling-min-level = <0>;
> > -	cooling-max-level = <4>;
> >  	#cooling-cells = <2>;
> >  };
> >  
> > 
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Is Kevin going to apply these for 4.17 ?

-- 
viresh
