Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeBWGma (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:42:30 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:41334 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:41:43 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180223064141epoutp041fb30903123bf1250eebe6dd23584930~V4Tz-50CW2369223692epoutp04K
X-AuditID: b6c32a47-19fff7000000100c-92-5a8fb7a47dca
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        manabian@gmail.com, dinguyen@kernel.org, will.deacon@arm.com,
        xuwei5@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/6] arm64: dts: stratix10: remove 'num-slots' property for
 dwmmc
Date: Fri, 23 Feb 2018 15:41:36 +0900
Message-id: <20180223064138.18401-4-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.15.1
In-reply-to: <20180223064138.18401-1-jh80.chung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSWUwTURT1ddqZAawZissLRiGToIFIbUtpBy0GlegkEkPkA61RnMCzEGhL
        Zlri8kNUEDBsoRLFBRdUUoEANoCoH5QSjEKFkICCStwIgktcUaLRKaN/591zzrsnN4fEVF5F
        OJljcyDexuXReLC8ozfaENvQWWnW1F4xMfU+v4Lpe3RHxjyeL1YwI93nccb3pxIwd8b8gLk2
        Nixjiu75CKa/OZ15++m+nHnd58KSQtimi02AvV33jGBfXWgj2HZ3Kc4+Hb2LsxUeN2C/tK9O
        JczIlI24LMRHIlumPSvHZkmkd6RlbM2IN2i0sdoExkhH2jgrSqSTU1Jjt+XkiRnpyAIuzymO
        UjlBoNdvMvF2pwNFZtsFRyK9V6vVqbUao1qn06n1cfs26OJFyQGU/fKUS57foDhU0mMqBD55
        GQgiIaWHnqs1RBkIJlVUF4Bni+aJAKGi5gAs/278L5qZ/aCQRK0A+ufGgPT4AWDdcIssoMKp
        dbDze/8CXkrtgfXuXiwgwigfgCMvJrAAEUalwU89U6KbIOVUFJyPCEyV1EbYOXQDl5ZFwCrP
        sYV0QZQJVv2alge+gZQHh6PVx//FTobPK1wKCYfBmX4PIeGVcMrdBiR8EsDBc2GS2QVg45lT
        MomIg1OXyxYwRi2BJb2/RTMpzpWwpFglQRb2v18jqTfDuuJaXDpKJYAnZokqEH4JLHKD5Shf
        sFqQoMuPUwucVXDaLOpMu7UdLPQnZnsX6PCneAFFAnqxcrej3KxScAXCYasXQBKjlyqT3JVm
        lTKLO3wE8fYM3pmHBC+IFw9TjYUvy7SLbbQ5MrT6BI3eYNAZDYxYhRXKotRks4qycA6Ui1A+
        4v/7ZGRQeCHY5Y/5ueazbbppq/7gquYrwUTD/cJ0zfiq09/MNxsHZMOetRb++qJQ5HtiHcj8
        Cdhb3a9iee9kbqkR4K0JWC0+NbnrXZ9+i7OmYdqx4fSgYW78d8h+g/zyzvTQidz20o8pX12G
        emfrw+jRlhBBf3R2yPQr6mHpg5meN6/JgYIoWi5kc9oYjBe4vwxBwLxVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t9jQd0l2/ujDBqmi1vMP3KO1eLo+d1M
        Fjd+tbFaXN41h83iyP9+Rovd188xWiy9fpHJonXvEXaL42vDLV5+PMFi8eToFGYHbo8189Yw
        euycdZfd4/Hcjewem1Z1snncubaHzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyHnVPYSlY
        wlrRcdCmgfEISxcjJ4eEgInEq9fvWLsYuTiEBNYxSjw89wfK+cEosaOnkR2kik1AR2L7t+NM
        ILaIQKTEgd9TmECKmAWOMErs3DAVLCEsECzx8eAzxi5Gdg4WAVWJX/IgUV4Ba4ntF5azQSyT
        l5iwpQlsMaeAjcSEPy/AbCGgmnfnf7NMYORZwMiwilEytaA4Nz232KjAKC+1XK84Mbe4NC9d
        Lzk/dxMjMPi2Hdbq38H4eEn8IUYBDkYlHt6Ikt4oIdbEsuLK3EOMEhzMSiK8Dqv6o4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwMjI21vAEljNOC/zN
        GHjbSO21t99a1c/HLpeuWHD8g037w675zTfWbHDzm31F4+mBbWeZRMqX3Kk7lO59b0luzKcd
        f20XcdytvvYhU20LZ+Lxz9PjLmtJOAhZMa1PCr23hVdIVpTP482hsDNGJ28Jt233WTZXqyhv
        9Z1cpoyeD9feLP+RfFb4tBJLcUaioRZzUXEiAGGqDCQ6AgAA
X-CMS-MailID: 20180223064140epcas2p3804fe3b7d63e4b7975d94a178e94dffb
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p3804fe3b7d63e4b7975d94a178e94dffb
X-RootMTR: 20180223064140epcas2p3804fe3b7d63e4b7975d94a178e94dffb
References: <20180223064138.18401-1-jh80.chung@samsung.com>
        <CGME20180223064140epcas2p3804fe3b7d63e4b7975d94a178e94dffb@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'num-slots' had already deprecated, remove the property in
device-tree file.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index a37c46112876..4e146b4e6487 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -88,7 +88,6 @@
 
 &mmc {
 	status = "okay";
-	num-slots = <1>;
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
-- 
2.15.1
