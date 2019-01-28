Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D152171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfA1NCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:02:16 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57789 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1NCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:02:16 -0500
X-Originating-IP: 91.192.165.7
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 017991C0008;
        Mon, 28 Jan 2019 13:02:12 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/3] dt-bindings: iio/adc: Add bindings for Ingenic JZ47xx SoCs ADC.
Date:   Mon, 28 Jan 2019 14:02:40 +0100
Message-Id: <20190128130241.5027-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128130241.5027-1-contact@artur-rojek.eu>
References: <20190128130241.5027-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the ADC controller on JZ47xx SoCs,
used by the ingenic-adc driver.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 include/dt-bindings/iio/adc/ingenic,adc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 include/dt-bindings/iio/adc/ingenic,adc.h

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
new file mode 100644
index 000000000000..82706b2706ac
--- /dev/null
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_IIO_ADC_INGENIC_ADC_H
+#define _DT_BINDINGS_IIO_ADC_INGENIC_ADC_H
+
+/* ADC channel idx. */
+#define INGENIC_ADC_AUX		0
+#define INGENIC_ADC_BATTERY	1
+
+#endif
-- 
2.20.1

