Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C362FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E44208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E44208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeLNLtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:49:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:49:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 886C2263976
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
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
Subject: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC sub-drivers
Date:   Fri, 14 Dec 2018 12:48:58 +0100
Message-Id: <20181214114858.21231-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple ChromeOS EC sub-drivers spread in different
subsystems, as all of them are related to the Chrome stuff add
Benson and myself as a maintainers for all these sub-drivers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Benson Leung <bleung@chromium.org>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for iio parts.
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v3:
- Add collected acks
- Use a cros[-_]ec pattern instead of list all the files.
- Add Guenter as a reviewer.

Changes in v2:
- Fix typo in Benson email address.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7260191301b..437e036435d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3629,6 +3629,14 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 F:	drivers/platform/chrome/
 
+CHROMEOS EC SUBDRIVERS
+M:	Benson Leung <bleung@chromium.org>
+M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+R:	Guenter Roeck <groeck@chromium.org>
+S:	Maintained
+N:	cros[-_]ec
+F:	drivers/power/supply/cros_usbpd-charger.c
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.19.2

