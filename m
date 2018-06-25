Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE85C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913DB24752
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913DB24752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964821AbeFYPT3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:19:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33024 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbeFYPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:19:27 -0400
Received: from localhost ([83.135.237.7]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0Mcixh-1forWY3yxV-00HvEw; Mon, 25 Jun 2018 17:18:48 +0200
Date:   Mon, 25 Jun 2018 17:18:45 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] iio: hx711: add maintainer for driver
Message-ID: <20180625151845.GA6392@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:44OyeNRATuXFvApqdvA2WdmsxrAcda7zf2lb7Q+kAUmoPd8rHvX
 YpKAjWsmuA+4ScM6oVSyYVZB9qwJOCCaNkfQYoTbtldoQiVbXRQdjfn1LK+7HIWa9yBYDYw
 uNWRt2wkAEoc58H/nP9u4R7OOqm//LbKOpHnfT0nOTggg2DLO2Mp4NSFVrrZ5oIioZ9j+d9
 nX05aXUA+/F/yerViwFLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rWnOjBp7k4E=:6o+39gRlOwQBU8KEzwNuXY
 oO8GoNSxIk2ZCJqLokscQzLB9K+GdoR+CS+/7YNIAISgtoxhynmpsMimIJS5Ul8jB3RPabWM8
 r1318xFTmA1OUSH94c33nkXw67sZiPYedl2XJHpHeL7oWEsatF3Oq03WaRsCy8voLKVTwevqc
 L/DTult9YPlUT7AD++zzJI7zE1oG1PftkPuQqP5vGKEW1kb+wM7rr/INCvoDJ+/DHFiKbCZar
 oKMlrXqL3U3fnuoF95QRMzVbQPabqne5hyBNA+IcCAc/Qpa8QKk9xd7l/2ifilorikiJnpwSa
 7iK4DmPiGWixFkETsuY//FJ6CVWIRki1rBmaqLR1j6UcqB1z3pu8huklvvuAKc0V53eqApLRA
 aZvyH3vKaiq/EpVZHQiG0pPmOs1DhB+GfuOdu6jmmCxUc2OAQSvmuvspnlM672cGaS1R9UrKr
 681CSK1qDbv7LdSpeCmQ+YZl6VtN/xaKCr0Jzd1VldHvqOTAMZQe2pjXcpSGVKKZ4kUSL6Qam
 W/FTjK1+1J7TZQQ9tC6z5Ymdvod5nP4rbYAKc7y7/ZfmyrhfmytJ3UTGMe/z/KC0Xvmij0NV1
 uCUou6gpPOs/YwcXW3/l9B97bYyePPjOkAyTp2j7M0XVStvqMjxeZC0akfiNvKjkmy6dXBAVi
 CvYGSP451YudSeNwsIxhDegNxni/Mj0jUBi+9/cnaLYzG28nAEHujcGUAgydvYyf4fNM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a maintainer for driver hx711

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b65225d443a..cfb8a08777ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2535,6 +2535,13 @@ S:	Maintained
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
 
+AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+F:	drivers/iio/adc/hx711.c
+
 AX.25 NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-- 
2.1.4
