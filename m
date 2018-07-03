Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E47EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3775E24B21
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3775E24B21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeGCMva (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:51:30 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeGCMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:51:29 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MZbAH-1fqV8p1EwH-00LGAy; Tue, 03 Jul 2018 14:50:42 +0200
Date:   Tue, 3 Jul 2018 14:50:40 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] iio: hx711: warning in dt binding example doc
Message-ID: <20180703125040.GA18226@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:zT83wd8svWj9WF23QiiaQE6nvrEcSk51iNC8ll2E9Ks/R2d1CJ+
 LmeUkblVM8qTkRXEQdxVVVNy1xAwGV2/rE72qMCWtTwzXImyhqyx72mURdFHmbVjlHhstty
 eIgVWPxgpzkIK5J+CAN/Kpda66LgI5ErifdxC6jtnDR84crfI4BKy7HX+oErgzviJw/Bbb2
 hLgUY00B9/KFxrK2Izgyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PD2rUBiVu7c=:awPhXpMopR4JVQKTh+IYQm
 9HEs+kNxeDl+UPsKORnlkL/JkqP9s2JHRONvylhPmezVqonUbZzo4/VIl3i/xqesFOuHnQWRm
 aGKp1Y65T00yEFc6k3Mj8CxJH68ynr4rf9t0oOqEKAOv6w2lZKK+sK9iHeKgazJq+NY4MslxF
 V2Zfox0tbHRm3xXxYKPp+jrBHEOsprZo/y5KHmFKYkC5HH4nXa17kcJC9WEIYTMsAu9m1nQLT
 bAJ4DOd6j7NSGlPzdYoY5VTaESKRRFPlhGZ9u6JsZfxq8H2P55V4vS4NUQsHDWiLmcMdyi6xn
 bSjlj653sQ8Cv4/mSZZddPV1WcB5QItL/qBbLlS8WuJpe9x3pDKr58kr8i9S7mnZWRstIpPDW
 PX4izA6uDOOQbFyI/q/YpWxRIlJ4FiV71zGB655uY+YM6U+mLbBMHhmnTESokUO2RFl+WzTi1
 rz+3Lh3p+d0SEP+nzbUlPkt7si9ma9X7sfUxUdrdnkiB4n0B2NKMCt6sKxlVPO8Vh8os41B3e
 DAaBc6iuxAUwA+lfNBoN4xLs7ml6J3VO86L5Gfa4Po2ulH7M0X4ZK4WXoafkQQZ1v4mpPp6s0
 ackK3utvvr5PatOmkZ+PqIfGGLIT+uBKA+JwdnYRWSDMY9KcT2JmdLY4/5PC9PprT3+wi5Bk2
 vJ4nhWyb9xvX270+dy8uBbYBZD2CwObEIUmwOHL3gO/+XPI23Cw6nj5DZ3bmS/9Odjws=
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
index 669d213e2964..73676eef8f08 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -15,7 +15,7 @@ Optional properties:
 				time which is 50000 in the datasheet
 
 Example:
-weight@0 {
+weight {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
-- 
2.1.4
