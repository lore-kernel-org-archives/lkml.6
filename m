Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2261xZZ/8X+VkjpUdEeobQyZJWvOLv5o9+/A1j1ZfdBjHeD7jmytGXMRb140afXnv5cXctLI
ARC-Seal: i=1; a=rsa-sha256; t=1517855159; cv=none;
        d=google.com; s=arc-20160816;
        b=UblOMkd7FAQaQAq3bzioSVbeFcfCBfj/KUXRUtTKYKDQwpm7WICzIuW7Hpiu1892LB
         AWXvnM3mQ2ELhag9/NcLALrKLyplYKryqUVZ4H4Vh6oBk3DabM1v5iW3f5mP1WpeoJzV
         Kl8wOGrGaqchb5ClozcbOYgx61gSQou8of+I5ZuWVY6Rww1cu3bUEVDs3jA3m+N22VcT
         iX+LUTMCM/dhf1DtBlhMgPFd72h3HevgRy8zd0yWG1Fto0TQwugElFoOl/xA7BjTN6KC
         OGVTQtXw1bs8ah+w4gjRooxUnCbaR7RjFZLNxavt/2sZl+zqRuukqMWg26Y09bSfVRMt
         +3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ctMGjn1oSIv7ULQSGoLsmf559w/C1U6Q8amB18XZWY8=;
        b=F3eMxwHMhoXkTNAk5qHi+MMD8Zlq4B99OwEc9b7u8NTCOjzBpeUBtL3NCJGcfxiCLD
         gRmZA+2byowpsnR+SoN9zdU+NC+43OwafmKY9wPubL6fk5Xh98kouh1A8N4G9ru5KBH7
         Sj+fEdnhQXzjZycClwC2Y2nG5YFWzvn1FctCgNp/595LWJT8zG5f8YLLwyRHQd0JTLyM
         1YBazXZdUZTscxRmkVnGsq8X5bZwSHUWfAA8bLpiPUMdD7s1JJNDYFyEMmrB66if6YWY
         Foz/349fMkYjoH+B2nBEXd4TdKTKXKAI5eOMh3BC2UWanrKyT21i753l+0mPvOYBTKhN
         qqfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 19/60] iio: adc/accel: Fix up module licenses
Date: Mon,  5 Feb 2018 10:22:52 -0800
Message-Id: <20180205182214.719155121@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586349907258531?=
X-GMAIL-MSGID: =?utf-8?q?1591586491882280670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 9a0ebbc93547d88f422905c34dcceebe928f3e9e upstream.

The module license checker complains about these two so just fix
it up. They are both GPLv2, both written by me or using code
I extracted while refactoring from the GPLv2 drivers.

Cc: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/kxsd9-i2c.c      |    3 +++
 drivers/iio/adc/qcom-vadc-common.c |    4 ++++
 2 files changed, 7 insertions(+)

--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -63,3 +63,6 @@ static struct i2c_driver kxsd9_i2c_drive
 	.id_table	= kxsd9_i2c_id,
 };
 module_i2c_driver(kxsd9_i2c_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("KXSD9 accelerometer I2C interface");
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -5,6 +5,7 @@
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #include "qcom-vadc-common.h"
 
@@ -229,3 +230,6 @@ int qcom_vadc_decimation_from_dt(u32 val
 	return __ffs64(value / VADC_DECIMATION_MIN);
 }
 EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm ADC common functionality");
