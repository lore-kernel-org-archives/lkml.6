Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031560AbeBPNis (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:38:48 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40463 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031458AbeBPNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:38:46 -0500
X-Google-Smtp-Source: AH8x225iHrHw5FIJ4NBR0xXNq9ufRMCxqmOcH85I3WToVQ5fpeO6D0+XeaF3AcHVrUBL6swkS4tq7A==
Date: Fri, 16 Feb 2018 11:38:41 -0200
From: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: apply coding-style into ms5611_probe function
Message-ID: <20180216133841.3yt4ip3tbck7ihdm@smtp.gmail.com>
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
