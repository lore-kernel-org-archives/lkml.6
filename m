Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEVH1V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:27:21 -0400
Received: from mout.perfora.net ([74.208.4.197]:55889 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbeEVH1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:27:14 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 9/9] staging: rtl8723bs: Fix grammar error in comment.
Date: Tue, 22 May 2018 00:26:37 -0700
Message-Id: <20180522072637.9782-9-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522072637.9782-1-quytelda@tamalin.org>
References: <20180522072637.9782-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:QX5fqGU0MwqS/wbqw1/7QQf8zOx1eZW5xq5DRtz8SYZc5vrOlTM
 1pRS9ampD5tqOo7LPLhXKQQ+VQxCoxrVhhAqqDl8Di2DgN+LJonzkqErRGRStMo8CN0/G4u
 71agtyCWiMm2cs13tO96rSlHFWipxtxmB8XVhHEvwFS3yE6A7MfOMjD28b4a4OFofKlPO0u
 1DH0WKKzrTeQVDRHkbknQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bZIIYS6zcVk=:Yd9vAw4dfVLQPPTSLFC9s3
 tUwEZ+Lt2EBmuol0Vz5LBWlaz+u713luR2lIyO/virCxXJYcXUzfpIrkuhaYlqBnY8mMKtn09
 VQZ0k0u4FkJrQcA58jMY8s7srNn72xnq02vVk366s86nIhIqJuqQkXgpMZ3kKZnwzYsb7H1V/
 ptNVyK+CUYrH6P+UKSQNfYnAXc+WGiJm70tMN+jodNM0vvTqA4EU5hqPBz+llr2U9N6etIRgT
 C7ehILfSZI9WZGGUYdLO66MtjQt8GT4wgT1iDRLQLps+bfyxPoDmj1brmgXaGBIDCuoq2+6+C
 Fm4OrnVBn7VXEqNnYcUfhRINvJv1wMKCqmP+mHQlu5GbrJvWKeRdDYqBMxHvxRlxICP+QQg+q
 I6nbBR4JfQhr8Kc7F/3vQR7cqtulNgDg02xyxigt1LIGE+H9r+dCmspxmLmUBRUxIP76CkBQg
 YmQTK2bOvPXr+dy7bPJZ6ZcMq9QehjEH1CMFvCPD47ATIF42LhcVsRn41oBCBqsgqoiNdlZbK
 ytAp0QxrrJJjj5TXqRG3b4UONKPVwwXioWpV6hShI9YS3yxjyrNlrEu5YMRsissBQOlNd/M+y
 2gkwrx9S3TXnEUqmxtTa3S1B95YEcbNiC16Ow4/uWFhSxnkd6ZQvNQV5rElRPFOSPBqXUdTtx
 iZDXLTfO96WXaX0EAgFFptJhDDZXrauIADcbEkKVXfO7ShiTh+Hj/N/BT8p6jBP4Grms=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a grammatical error in the comment describing 'struct
rt_firmware_hdr'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 946236f704fe..8f00ced1c697 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -51,7 +51,7 @@ struct rt_firmware {
 	u8 *fw_buffer_sz;
 };
 
-/*  This structure must be cared byte-ordering */
+/* This structure must be carefully byte-ordered. */
 struct rt_firmware_hdr {
 	/*  8-byte alinment required */
 
-- 
2.17.0
