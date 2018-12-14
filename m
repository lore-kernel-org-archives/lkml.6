Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D770C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1956F206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbeLNRYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:24:22 -0500
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:60210 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728077AbeLNRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:24:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 85282100E86C5;
        Fri, 14 Dec 2018 17:24:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chess05_24edb2e791d60
X-Filterd-Recvd-Size: 2856
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Dec 2018 17:24:13 +0000 (UTC)
Message-ID: <461e2531e3979e89923b66966d4fb243a6113280.camel@perches.com>
Subject: Re: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
From:   Joe Perches <joe@perches.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 14 Dec 2018 09:24:12 -0800
In-Reply-To: <20181214114858.21231-1-enric.balletbo@collabora.com>
References: <20181214114858.21231-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 12:48 +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.

[]
> Changes in v3:
> - Use a cros[-_]ec pattern instead of list all the files.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3629,6 +3629,14 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:	drivers/platform/chrome/
>  
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:	Guenter Roeck <groeck@chromium.org>
> +S:	Maintained
> +N:	cros[-_]ec

For linux scripts/, it is unconventional to use a hyphen first
in a character class pattern so perhaps this is clearer using
two N: patterns

N:	cros_
N:	cros-


