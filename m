Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD433C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6545B24CD3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6545B24CD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeFWS4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:56:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeFWS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:56:00 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MC1MO-1fO2GV2KG0-008uxb; Sat, 23 Jun 2018 20:55:19 +0200
Date:   Sat, 23 Jun 2018 20:55:18 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: hx711: add maintainer for driver
Message-ID: <20180623185518.GA17864@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:aRTgn5culHtBt5LI5cHN09YahGfPE6YqWI43v50XgFny5szsF4i
 DX9KTcULX0xJgTjnP2ZGw7wN1xlyQp/JOkupKF9zMlP4HBkx9vE2Cep9alJ9uSjAvIQElQf
 ngZDN/FsigNNLvgmmyxFPBLwavCPco5x845yXUEqgd7ykfK/PXvn2DG9KDXVWCGvdGXQztZ
 Ut7EbXQPWyPjRG99ZTFMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j6U/HNEapBU=:LBONSppgKyWhI1VyYPEAGS
 Q8YxL2R07GHSZqGHxSuvY4FG0HmwYox3GBsPie1VTBxDn74YG21mxiIFaCgAy1kdYJ57TPtbd
 kg0pOc+tdxLJU2/VGyZLek6/U9eTBi7yQu42fyJxG5l4iHkKa8MoYbea6buHcwOWm5MTrLd+o
 yZV1CXjgkbiPV+F8J5SodcrpqwNN1Uiaa0mxHKr9HKHUu3J8VGAvK1UWYQWF/57VBEe1yeEDc
 ogHeD1iFXOdsOpaKgg5cr3Z25DiCyM+u0RsNBF/jnfsMharplLjaRLzphqVYndHOJq8abQNy2
 hpnRL6QeN/Dtk2jgd3LzjLpgJ8pzlHsx2tJUp4YzaK+EiXqZ3+ZfuxgXV6SiX9FSGSNvLEeqi
 dpizZIfJD5frdl8bvREu2J2j1Pq/4e55QP/5NV1ZP8VphJQQoH9j4GSf78xG5vvy8RENr1B5f
 KSbwEq08hw8nJQaJ/lmQ6DAuubM7dIlTXpojkdiHPAwZ07Kngex3DPQqyCvDJClYfZCZ6XLzg
 nJuPZlK4jPMw45Edkg7kqCaOfArKhRN1B+EszEgk7WHWJWeKys40Uz4bbMmpKdWKYtt7O3jr4
 BwWJcAb32Lqg34O7xcFoC7L9tf9joTv8Q7pqXm2qQ0A0RgCZzh4Sc03NWsj+XN8OZOIl4E7lW
 9602j93g+y7eCPa2lqpbJQEALAcyR23zOteP9ZOKf0bGxvxor71gxFa4fquwQYDUanAs=
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
