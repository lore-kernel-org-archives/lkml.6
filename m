Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83466C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B9C25BC9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B9C25BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934877AbeFYPUZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:20:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52820 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeFYPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:20:22 -0400
Received: from localhost ([83.135.237.7]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LdZfa-1fyaY12L9m-00ioKF; Mon, 25 Jun 2018 17:19:27 +0200
Date:   Mon, 25 Jun 2018 17:19:26 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] iio: hx711: warning in dt binding example doc
Message-ID: <20180625151926.GA6403@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:YQA1kZXM1bvOr8eg79OAiOfQy2s++FUUJlg4TmjgHHE8BuaRFfg
 kxh8jNd8+oA21+DtiisGzjx/FUtis99ZCq7+f6gfP/65qVCjjIWLkLBzvH8LVgScDZKXITW
 ndTeWxdysRWMhfgwc8GcqHTgS2ntmArBdftU2vXYZRna/Pdhtw0EALniEK4TyA0f4qA88Y9
 n1oP1qEyiENLbUvCnqesA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+mfc/WGZll0=:+L2GqtFOV/WHqMMs7Obqci
 iQvOsLN6MNeffjX/Lx9Oy54D5cW6rznoUHGKx8uElnLHakqyaOBoQwpKvOO1akJOkzBUAGU9I
 aP2HNaNCbHx/JSp8wKRlYWbFYF/Z0WQs8OIsqnd6JdtKlRyHwrigY3+NQrwcUASYggNmjGuoi
 haz42rBKVTTIdpzu4bdXkVkPLLSxDydi2lZigmAf+oSQKtZYPaThkCukbJfXA4KtcAyu3y4lC
 5lz53VURWtsX1ZnuBK6lU/U9oOT9W0TOeZ+y1hELPo78GWOy83TLuQtb7DTQ0hxQnzwQZNZ2d
 CDH7LYbfxC0hrK1RyF3rub0JFZGXEEKaQF2r06OuaGhRyfOMGMblFnk/rTDNoi/gxFNlAPiya
 C/PsgqbACDcMYXVjp9y433bbk5IN5RRvUbs5itzvwvKRTfSWmcwGkg6tLPmOEjXf1vBGlTBf6
 0dk/ugQ9pF9UZA341DzMYa9GWhcpwGe7X3VsY3VQnsdX2cXaaDTn9c9WZzcLKDmYHmQve9c56
 V/v0dr2Q32v3G47s3WnNNbXXn57YnaLYn9O9qzxHws9Z7o2FpUB8KcR3qYHy+nve/j4HcAmbm
 nHkcbiXx82xZiwyh2008c5ZAHxHweVKLPCORnKLWIZBqmJog7s46rFKpY2fbVUAPlL/w9ttfB
 WGqex7qW6yZ5BmMxqyZkJwrStljqZWbd/wvzsQnVCfmMVWYst8NK81+dnVdeQIfI5PoQ=
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
index d0c066e3df69..8c9bcaa4d750 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -15,7 +15,7 @@ Optional properties:
 			is 50000 in the datasheet
 
 Example:
-weight@0 {
+weight {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
-- 
2.1.4
