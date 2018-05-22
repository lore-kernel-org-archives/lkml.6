Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeEVHdF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:33:05 -0400
Received: from mout.perfora.net ([74.208.4.197]:45139 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbeEVHcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:32:15 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 2/9] staging: rtl8723bs: Rename 'Hal8723bPhyReg.h' using snake case.
Date: Tue, 22 May 2018 00:26:30 -0700
Message-Id: <20180522072637.9782-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522072637.9782-1-quytelda@tamalin.org>
References: <20180522072637.9782-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:GAtCWXaLGMB8N+JQdQHndPJ+lm86hMPrelCVTPpcN9v10RFCkP5
 +7IOpSQClagIyfcX/TaIyruQpNt7csNfS823tB7pjMNiSwoGIUK93CbQb2elc8YMW5EnDn2
 9wpg6A1MDM3OV09T5jM5I4jQDtK74ZHK+NoKbySaSA4kpG5Ej98TtDcrKGZDt2t3Pz6Gs9Q
 xodLKaft5XrpFWatczuvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZYhXdLQFZkU=:kmJ/iv4BmzZ9ahSo28eURk
 mGXLOfzm0cb18OqrIppbTNhIfhanycIFOs6BHt/kf3u+gJqoeBdFGRshH42MBao2dyjXttStG
 xWxCh4ShkqaBQZ64OtmU8lmCdAA4nPjVJ7LdmqSUvUEkTOt6Q8sSYENmijptDXy2V0Oc6Lm76
 ZXwVwKE0sGkRI1fj0aoq0APmYfN6FRxfBn+fXhnMjI4qKEBLPvQBBfor1SwP8CQrrx2uNqSfu
 XonQiWMpem3u8cLd+oDI7IVeGFPi1iBpcj62BxxtcplCRppMgyV43hW6bZncyz6Ut+B5uRW53
 VK6fe3eop5a47Q3utWrY02omjs70eErJBdwXWS+qwpTOtdJFaytHoAyqcZC1kgV+RjQDci/w7
 Mz2jYQkcGDiy1lRPVdV62weWX4dmMQeUi1nBBcACfI/+AKQKIifsmuc3Bshr+t5ZAvF+z8UgC
 7kVkavzglxr4GtzsNh7yxhOPh9sPK68gq8a53EzbHCs69NuGl/NEM9Ush5yGdOGImF+l7OQ/P
 cQfiTMPYmT6gPTi86tckR7xSRaRCjoFzfIWsRRhCIz050fmrJGHjLS7tSQcNNmbyxnBZyk9+4
 WXXhAa2sMk2paUaLKhGXiw7DhuzObApyTRtdB8bm9C5n9Kd3D+uxqyiSt9G3OGFMfWargNxp9
 Q/EneJXEgId6Jh1cRgpODz/aY6i1/aZiWv/ZkysPN6iFwwIoc4MX7mGyfrjLkBLlv5Fc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel-case is discouraged in the linux kernel coding style.  Rename
this header using snake case instead.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../rtl8723bs/include/{Hal8723BPhyReg.h => hal_phy_reg_8723b.h} | 0
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h                | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/staging/rtl8723bs/include/{Hal8723BPhyReg.h => hal_phy_reg_8723b.h} (100%)

diff --git a/drivers/staging/rtl8723bs/include/Hal8723BPhyReg.h b/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
similarity index 100%
rename from drivers/staging/rtl8723bs/include/Hal8723BPhyReg.h
rename to drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 46ac61b058c8..c2b71b4e4982 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -17,7 +17,7 @@
 #include "rtl8723b_cmd.h"
 #include "rtw_mp.h"
 #include "hal_pwr_seq.h"
-#include "Hal8723BPhyReg.h"
+#include "hal_phy_reg_8723b.h"
 #include "Hal8723BPhyCfg.h"
 
 /*  */
-- 
2.17.0
