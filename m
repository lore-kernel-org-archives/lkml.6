Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeCTBnX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:43:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34968 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeCTBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:43:21 -0400
X-Google-Smtp-Source: AG47ELttkDLSfpHeRgRn/bxGwpCtftf1j6we+i6pJ/r90mcV+hYcZu46OiQ1LXIfXCikjIVunrtxTg==
Date: Tue, 20 Mar 2018 09:43:18 +0800
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, arnd.bergmann@linaro.org,
        arm@kernel.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level"
 for gpio-fan node
Message-ID: <20180320014318.g7koh7ld3seucg4c@vireshk-mac-ubuntu>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
 <20180312043533.GU6842@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312043533.GU6842@vireshk-i7>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-18, 10:05, Viresh Kumar wrote:
> On 09-02-18, 14:28, Viresh Kumar wrote:
> > The "cooling-min-level" and "cooling-max-level" properties are not
> > parsed by any part of the kernel currently and the max cooling state of
> > gpio-fan cooling device is found by referring to the
> > "gpio-fan,speed-map" instead.
> > 
> > Remove the unused properties from the gpio-fan node.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> > index 08568ce24d06..727d16eb02d9 100644
> > --- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> > +++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> > @@ -78,8 +78,6 @@
> >  		gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
> >  			<&gpio0 12 GPIO_ACTIVE_HIGH>;
> >  		gpio-fan,speed-map = <0 0>, <3000 1>, <6000 2>;
> > -		cooling-min-level = <0>;
> > -		cooling-max-level = <2>;
> >  		#cooling-cells = <2>;
> >  	};
> >  
> 
> @Linus: Can you please pick this one for 4.17 ?

@Arnd/Olof: Can you please pick this one up as well ?

-- 
viresh
