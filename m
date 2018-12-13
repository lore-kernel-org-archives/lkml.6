Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1E6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C818E20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C818E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeLMJuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:50:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42476 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeLMJux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:50:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 78DE9207B8; Thu, 13 Dec 2018 10:50:50 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 43EB92037D;
        Thu, 13 Dec 2018 10:50:50 +0100 (CET)
Date:   Thu, 13 Dec 2018 10:50:50 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
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
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Message-ID: <20181213095050.GM19816@piout.net>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
 <20181212222937.GL19816@piout.net>
 <6f688bfe-2ebe-1934-0375-016ae859dcfb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f688bfe-2ebe-1934-0375-016ae859dcfb@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2018 10:30:16+0100, Enric Balletbo i Serra wrote:
> > However, you should probably indicate which tree do you expect that to
> > go through ;)
> > 
> 
> Well, these are sub-drivers for different subsystems but are related to the main
> ChromeOS EC. I expect all go through their specific subsystem and their
> maintainer. I.e the rtc driver go through your tree, the mfd go through Lee's
> tree, iio drivers through Jonathan's tree, etc. This is the reason I did not add
> the tree. Main purpose here as that Benson and I are aware when someone sends a
> change on one of the sub-drivers and we can review these patches.
> 

Sure, sorry I was not clear but I was asking about this particular
patch because as it is, you will get acks from all the maintainers but I
think they all think someone else will apply it ;)

> Thanks,
>  Enric
> 
> >> ---
> >>
> >> Changes in v2:
> >> - Fix typo in Benson email address.
> >>
> >>  MAINTAINERS | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index a24129b0b043..bbe7180e2851 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -3625,6 +3625,30 @@ S:	Maintained
> >>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
> >>  F:	drivers/platform/chrome/
> >>  
> >> +CHROMEOS EC SUBDRIVERS
> >> +M:	Benson Leung <bleung@chromium.org>
> >> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> +S:	Maintained
> >> +F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> >> +F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> >> +F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> >> +F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> >> +F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
> >> +F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> >> +F:	drivers/extcon/extcon-usbc-cros-ec.c
> >> +F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
> >> +F:	drivers/iio/accel/cros_ec*
> >> +F:	drivers/iio/common/cros_ec_sensors/
> >> +F:	drivers/iio/light/cros_ec*
> >> +F:	drivers/iio/pressure/cros_ec*
> >> +F:	drivers/input/keyboard/cros_ec*
> >> +F:	drivers/mfd/cros_ec*
> >> +F:	drivers/power/supply/cros_usbpd-charger.c
> >> +F:	drivers/pwm/pwm-cros-ec.c
> >> +F:	drivers/rtc/rtc-cros-ec.c
> >> +F:	include/linux/iio/common/cros_ec_sensors_core.h
> >> +F:	include/linux/mfd/cros_ec*
> >> +
> >>  CIRRUS LOGIC AUDIO CODEC DRIVERS
> >>  M:	Brian Austin <brian.austin@cirrus.com>
> >>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> >> -- 
> >> 2.19.2
> >>
> > 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
