Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D730FC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF24B20645
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfBXQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:24:13 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfBXQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:24:13 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmkfQ-1hOms80nOI-00jmih; Sun, 24 Feb 2019 17:23:38 +0100
Date:   Sun, 24 Feb 2019 17:23:33 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        jic23@kernel.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh+dt@kernel.org, robh@kernel.org,
        songqiang1304521@gmail.com, treding@nvidia.com
Subject: [PATCH 4/4] MAINTAINERS: add maintainer for maxbotix ultrasonic
 driver
Message-ID: <20190224162332.xhh6cgenejq66fsu@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:wPKCRrnP73qsfzC1FrBbUWkeyC7r/oVYKrYjbGSkOQZ6CbZWrIu
 nNlEPyrYNVFPXoTyLUR6M5sG1ushdzQKgPAncAlH/pB1GknFvNzB3JPKaPq6PAQ0KbTbjY3
 SYqPoKjgp2KJEDCs+u7rwwItQ7caqT4gtXjRD7BBmWZv5o8C6cgAvmLjyvPOhxShiWbNLax
 Ri7+ZykEucs1lRtLvnVKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2jskLwKkjyM=:dkHi3J6e9iBjQ4d5O2EA9w
 SO+xo8UmrvBpa44nK0BJWzH+CMwnAtqXkQN9RmArs6QhRGZuLzmGgENnYHZYTEIO2R2l3vj+t
 SxlFXCaQnXnVWjY9MqX9fi+qg4b6m8fx0R9/q+YnPJvnvQkXHMxzOPtUKid7fR43+K/trfaqs
 xYYaMr26Lv0rfn3VjMrPfXXJRSQ6l6qyPIUNEmjegsqsbzLFDvNcqF9hwwap1TwqCxs21NnMd
 us35LVtLI6WhPlcpf+QROaviUbBStf9zJNElcRaYEoL8CDpEA1aRFA5hnF1vAisRbMNnccF8t
 n1sOnlZwVL4YHQS/WBJTEr2DcjYwUeG9lv5RnvKL3hkTQy7qFPboMm0tHbwUmxDxlQxMML0WE
 Fy7zDdItO0dIHclpTZgTeGZiOdqaiHrGj+pxXCgB4dR5AIVfHPz3oomHCF8mN2e/NzXwajFxS
 LRcIlVp5KN4Y9J0HvzcvIsKkGQmFmB+gtrgsQoTVULGVd2HGxnXYP89oEqWIYBe3TRyWrkgWe
 0nvZGOJJ+3q9njTsGTvtKXXLW19IA6wwRpkGdNH6AAnhYAvVYwaxMEndTWfdhLnmLUVu3vIqw
 f20TSOOifLZHyhf+zQsrQ8Bray6fLbaaZJb9oV/q/NgfAH9YI9Evp1AxX6wTUMQ8qxFmUsIKd
 lA5leWYJhBhBu2TuBcNV/EJB5LwxJIVMw0hKMJnpncvwPXrnn2ltKIGHbr3CS0JvRR3dJQXRW
 fVeElhzUXFZqK5WHjg0frI+NmusRNYuKk0f23w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a maintainer for the newly created ultrasonic driver familiy of
maxbotix

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..bbf1860d4227 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9226,6 +9226,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXBOTIX ULTRASONIC RANGER IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb12x2.txt
+F:	drivers/iio/proximity/mb12x2.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.11.0
