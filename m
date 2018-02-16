Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeBPTpP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:45:15 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36382 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeBPToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:44:46 -0500
X-Google-Smtp-Source: AH8x2263VR9HxefLu/B9yKMeZ2OliPonZBciYZOjoR+gmd5tEKBa2McI+m8MaiXtButNPu/qEiHwvg==
Date: Fri, 16 Feb 2018 17:44:41 -0200
From: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio:pressure:ms5611: Fix coding style in probe function
Message-ID: <20180216194441.nep5zbb5sjf53cj6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning and error:

iio/pressure/ms5611.h:66: ERROR: code indent should use tabs where possible
iio/pressure/ms5611.h:66: WARNING: please, no spaces at the start of a line
iio/pressure/ms5611.h:66: ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
  - Make the commit message more clearer.

 drivers/iio/pressure/ms5611.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index ccda63c5b3c3..ead9e9f85894 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -63,7 +63,7 @@ struct ms5611_state {
 };
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
-                 const char* name, int type);
+		 const char *name, int type);
 int ms5611_remove(struct iio_dev *indio_dev);
 
 #endif /* _MS5611_H */
-- 
2.16.1
