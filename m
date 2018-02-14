Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162494AbeBNS7b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:59:31 -0500
Received: from muru.com ([72.249.23.125]:57142 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162425AbeBNS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:59:29 -0500
Date: Wed, 14 Feb 2018 10:59:24 -0800
From: Tony Lindgren <tony@atomide.com>
To: Keerthy <j-keerthy@ti.com>
Cc: Suman Anna <s-anna@ti.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.reichel@collabora.co.uk"
        <sebastian.reichel@collabora.co.uk>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Kristo, Tero" <t-kristo@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
Subject: Re: [PATCH v7 3/9] arm: omap: Move dmtimer.h out of plat-omap
Message-ID: <20180214185924.GR6364@atomide.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-4-git-send-email-j-keerthy@ti.com>
 <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
 <37f28584-20c2-51c1-e476-75ef81f03af6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f28584-20c2-51c1-e476-75ef81f03af6@ti.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180214 04:51]:
> On Tuesday 13 February 2018 07:36 AM, Suman Anna wrote:
> > These headers are actually not needed in the first-place since we no
> > longer create any non-DT timer devices. I have submitted a series to
> > cleanup the presence of this header file, as part of a larger hwmod data
> > cleanup series.
> 
> I will rebase my series on top of your clean up series. Thanks for clean
> ups.

I've now pushed Suman's series into omap-for-v4.17/soc and
merged it into my for-next. So please rebase your updated
patches against omap-for-v4.17/soc.

Thanks,

Tony
