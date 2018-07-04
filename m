Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04914C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B467524462
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B467524462
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934759AbeGDMiE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:38:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964790AbeGDMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:38:00 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0M6heq-1gLtq80EEu-00wVfw; Wed, 04 Jul 2018 14:37:20 +0200
Date:   Wed, 4 Jul 2018 14:37:19 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] iio: hx711: warning in dt binding example doc
Message-ID: <20180704123719.GA30645@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:CaL56vYvTVJ6nXXjm9DJblZcQmLbkPgjyRoLIrfumejBlCos6So
 P1SJKeJ+MdI8H74eTo1pYVb386eFC8H3Kb07QuCGiVgc7h7abPddPeJuDS/OmVCPy1/XwkA
 CPsZCOa8JXLGz9TzXRTH9rss9thW0VmycWlgb/vbQd/R6lh8WrxUrz2Nss//rqmM0mlVBdS
 /XoL3vCafUn4KBSxP4W+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1iC73pqM5Qs=:NmrjFh5b8PJ28FR6iNI7hJ
 gG/lIjNU2b5oab6IJgcPWG/nTd6uUgHKwl9aDaz6sFONbW0Wur7CZksRqUhPY4/GWeouB6GDV
 K6iVAFTmhErPnfwxlB62WrYogdAn9ytW70scZiktY3iz7RHFAZayAl4bvo8gwnihnHVkvuTBP
 LWJYKsAKdjkwk+CpFUqWt2bhycpjkvu8558+3fikkZ59PYdZVKZH8SGOSTzIWFQxOqnFS8xTD
 QFMxFBxdBXTFj4g9zB74WJyO2LIP50okf4vc1RNnU2wlSvab8Vt6q+FOm25bJuMaDmgT0vXQm
 oJo6RreOxRQTO5QVykpMgAhx0f+1zqU76pRLgz+BTD9obf9HhCRz3NNnQu27mrcARm212pNEa
 GrG7UL/751K+DwkdT1OEAR/U8PmwblndwQWlfqHwqGITGFyo66U8ZEbEFDFN1U7KjKx9d9I/n
 DA6Yy7pmLBfMiK5cAyCtHgaU6lslUIm98Dcv8FQ3iXW3BEyel8WqZzBl9RF+5iEkcbUkWAwzw
 +lD9qyJvtIpjm6c2DXD+s1UzFMFoWlKW2+oAO2/dif5xUluqTb4+vEVOWcTpSQ58XZqZ6wJ2S
 RrtyZNEg6iCeOc2sCq13abS4c0drMtjrQT9KHvHVZuvGMltce9DIm199HeYcSpGmYNxFEC/95
 1OxhPytNGszqAtoH6sZeVwhpHRIi/NCYJz/2YavpV9c/yoG5MUk3p1EjE95XaotyUN/M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device tree compiler (dtc) gives a warning if a device node has "@" with a
following number as it's name but no reg property.

fix the example in the documentation of avia,hx711 to conform to dtc
behavior

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index 4bee51d536e1..b218e093b55a 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -18,7 +18,7 @@ Optional properties:
 			high time of 50 microseconds.
 
 Example:
-weight@0 {
+weight {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
-- 
2.1.4
