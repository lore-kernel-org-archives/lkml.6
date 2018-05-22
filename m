Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeEVHcT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:32:19 -0400
Received: from mout.perfora.net ([74.208.4.196]:45881 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbeEVHcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:32:15 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 3/9] staging: rtl8723bs: Rename 'Hal8723BPhyCfg.h' using snake case.
Date: Tue, 22 May 2018 00:26:31 -0700
Message-Id: <20180522072637.9782-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522072637.9782-1-quytelda@tamalin.org>
References: <20180522072637.9782-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:zR4SHY4z62uOoi77vTpyDA5iElPVZ/KwC4cJjQpILwfYxvygvQ5
 OE53LeFWyjRLymmwizoDsDPzJ3jnV2nJC9jrNmanSvPATNdlREu4p6HMoJUu8HH9Vgc+3IL
 MtrpiSFisFkcP0pyg839DA/CwOHzFzqXy7HyZtU1VfmdWm5Jx561EYppUyQZHnmGFvXGfdr
 kxfDvwuBBh6ekT+uFOKtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bOJF3Hw9gLI=:fizyeVLg8xZ52mckmd2T6L
 UsFS3E6WCBdsI9YGDGnqJpczz3gSIV9lW9Wn2R1fHvDx9Tf5aN8tASAElhOlKOAeYFrH15RmF
 cPpklYd8Su8/2jkEx1yXYqWsN3qqOr6Jm4yQ0+fGgPYF2xpE8dIycAmafVEFQ9sTj8dXFGIK+
 kaJ5ANUarAhylPHqWwZgU0E0WvoSj+4h9Zac85FdFCFISCQJnS4LAdaZZytqDxzbCg0At3Ixx
 vHdXs+wujtHv+ofafvEjpsxjhAES31oAEpWl33nY/tZ4EDkn14qt1NtwYYVB+z/WuXMGx3FQx
 oTQMwYxaEZFVQkS599v8zw4OXZJJ+J4sSC2ikY/TlyDpg9ZtNXQp7FGaAe48YtfUpjLL2b6GU
 5A+XHfS/jaLZ9+DZjibozvoG3zknMIVGgthXkCaRH6U8lQB0x05ke8yUg8fs6lkZwMSEXqzSS
 zwSb2ymYyJIuhAp8v43BA4Ssti/wLLNlLFmWl4LCPN7DYBE6ThaNhxgE5NKu2t+1Vy93+4t9D
 tzvcBrm2kEsj2Dky7lU6qjMJlgnIUcrNyMOKzqIWN1y1rkejL+qH6q9AUsHYXvhdYnp8iy9Ks
 ltrT7rtsxquD+Uc1/2v8nw+mpyPwh39OC337St3oF4z6P8iYQx7PQxKXv21jAgZMyzWXSYiA1
 E0+CbCvPvEnK3LLi+t4iBiB6fuUemGrkF7WDhQO9vz01wsQdaENmPeG7dTxF6JNZgzEM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel-case is discouraged in the linux kernel coding style.  Rename
this header file using snake case instead.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../rtl8723bs/include/{Hal8723BPhyCfg.h => hal_phy_cfg.h}       | 0
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h                | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/staging/rtl8723bs/include/{Hal8723BPhyCfg.h => hal_phy_cfg.h} (100%)

diff --git a/drivers/staging/rtl8723bs/include/Hal8723BPhyCfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
similarity index 100%
rename from drivers/staging/rtl8723bs/include/Hal8723BPhyCfg.h
rename to drivers/staging/rtl8723bs/include/hal_phy_cfg.h
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index c2b71b4e4982..eedc765b6a6e 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -18,7 +18,7 @@
 #include "rtw_mp.h"
 #include "hal_pwr_seq.h"
 #include "hal_phy_reg_8723b.h"
-#include "Hal8723BPhyCfg.h"
+#include "hal_phy_cfg.h"
 
 /*  */
 /* 		RTL8723B From file */
-- 
2.17.0
