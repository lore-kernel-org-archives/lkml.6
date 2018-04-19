Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDSNpq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:45:46 -0400
Received: from bert.emutex.com ([91.103.1.109]:53636 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeDSNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:45:39 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, Javier Arteaga <javier@emutex.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: adc128s052: allow driver to be matched using ACPI
Date: Thu, 19 Apr 2018 14:20:35 +0100
Message-Id: <20180419132036.27493-2-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419132036.27493-1-javier@emutex.com>
References: <20180419132036.27493-1-javier@emutex.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  From: Dan O'Donovan <dan@emutex.com> Allow driver to be matched
    by compatible string in ACPI device properties. Signed-off-by: Dan O'Donovan
    <dan@emutex.com> --- drivers/iio/adc/ti-adc128s052.c | 2 +- 1 file changed,
    1 insertion(+), 1 deletion(-) [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan O'Donovan <dan@emutex.com>

Allow driver to be matched by compatible string in
ACPI device properties.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/iio/adc/ti-adc128s052.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 7cf39b3e2416..56ec04d1c68f 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -202,7 +202,7 @@ MODULE_DEVICE_TABLE(spi, adc128_id);
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
-		.of_match_table = of_match_ptr(adc128_of_match),
+		.of_match_table = adc128_of_match,
 	},
 	.probe = adc128_probe,
 	.remove = adc128_remove,
-- 
2.17.0
