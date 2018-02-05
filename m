Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226+NL8SCePo4s5wQ86ZMTGKbQCWWiDCmI/ANQhmwRYfIf0F9V/9ut5h4WHn9LqGYgqe47o2
ARC-Seal: i=1; a=rsa-sha256; t=1517855024; cv=none;
        d=google.com; s=arc-20160816;
        b=uh8JyZXBXs2FV5CTiMqv98FHDtfg5SIqVmhBrYPi+NnhskS+L3MEoD0tdlKTQOQemB
         WIAmE6iazsg+yNSVVrWg4hRlIAdqX0GWehEMeSQ27gmtlH2Bf8rs2nUS6DjHWuyRw4QK
         EJufoAQ9GHnbye1lUgenMfQMqaf4m7Ld63LQTB+bswI5Vp6kKuFFWqAoK/XW4kH/z+F6
         ZLH+VPBU08Dz7z4YlEfL6mQaf5culVHSQ6j5JoayXUK4VpZzICtZGM8GmZSlsrfDIBvH
         nTvbw+a6Wy8pY0bUlV8ZCjKu7o4AkIj2marzHu69RpiAqnnAAUtfo+mT+bHBexKZyJq8
         kUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NIPMOZNZjv4wzovplAPDlIIMSmXbNLnsFsqH3nS3/0k=;
        b=EcNHmVFCsuSYFRCgygfMb2010FSvE1NRBhkjVWh0MSvXrRwoamV6B9xHo+/9KxP1Lf
         RouxOxcfP2JHNI0AxGxwxRrRCJP09B5aarbDQGvhg9Oe+FI0VoA1YYlXW+i6VXrhC8uu
         YXfWtY7HrfCgF0TwxK8B3q1kl2I0+J1owgq3AKpb7cN/LFJY7ZhqknYTIwSMdodx7CE2
         eBg3C2QpHRCPvDl41Vob9jQl1WR2z7u4MlDfbEN4dT1J5mdsDmZ3ovEWksA5qvlxu4x/
         0AD2pyd6RCqZLuuv9dGd3kL7bJgGmF/QHTfDHsdCMg0Yhp12RIjjwqtO+KCY6QwpLgJT
         eXfw==
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
Subject: [PATCH 4.14 23/64] iio: adc/accel: Fix up module licenses
Date: Mon,  5 Feb 2018 10:22:42 -0800
Message-Id: <20180205182139.510841768@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586349907258531?=
X-GMAIL-MSGID: =?utf-8?q?1591586349907258531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
