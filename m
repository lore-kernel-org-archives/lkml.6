Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933097AbeE1JuF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:50:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55038 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbeE1Jra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528094727euoutp01809e68e431d01a6c4a6ab82f61a041c6~yxe2WuADD1961319613euoutp01T
X-AuditID: cbfec7f2-1dbff70000011644-bf-5b0bd02edc23
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 05/12] panel/hv070wsa-100: add DT bindings
Date: Mon, 28 May 2018 11:47:09 +0200
Message-id: <1527500833-16005-6-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0iTURjGPd++m6vJxzQ8rrAYRGKpCUGHjChQ+qACCUxQSGf7Umle2tQ0
        qWygm8a8Fs4SL6ASY2lO0bIUtOmstU3zrnlBIzIVNS+kUbY5/e85v+d53pcXDs0TZhMiOj4x
        hZMnSmRiko+39GzZ/Pz7DkSe3t45icbrrQTSWD9iSKleIlCjtoFAlUY7G9xYJlHxdCGOfkz1
        46hgboGHbLbXFLIoFymUW1RDIcPcMIEG2spJpLV1YKhqfhxHr4yTFKod6cdQdruRQtqSeRJt
        tVXgFw+x+go9YAfyNRj79vkkxb5QlxGsQZdLsq2bMwQ7/cSEsU01j9j8Zh1g1wzeofwI/nkp
        J4tP4+QBF6L5cYt9K1jyVyp9sbsczwJjZB5wpSFzBpY9fo/lAT4tZF4CqDS1UA5DyKwBuDIT
        vB9Stv7Z43UAWlQiZ2EHwL9TC3aDpknGF+pVUQ7uwegAbBpdAo4Hj3lGwL7KBcLRdmfOQWWJ
        CnNonDkONfV1PIcWMMFwedRCObd5wzFr7i53ZULgQHsO6RgEmQIKPu2sIhzboL3QOC1y5t3h
        T1PzXvcIzFV3Yk6dBLO/z+3xdNihMRNOHQQ/mPp3NY9xg8UtpTznSAFU5widERYWdRcB55Fa
        ALdN+Vgh8KoCLjrgyaUqEmI5RWAid89fIUlQpCbG+t9KSjAA++cw/zP9egM2vsR0AYYG4oMC
        ny1+pJCQpCkyEroApHliDwHfz44EUknGfU6eFCVPlXGKLnCYxsWegps+DyOETKwkhbvDccmc
        fN/FaFdRFgi5llZqPmaL9Fi/mzkn2S6P6A2fnSXFaldZtSVMGqcSrW8PWwe1V4Z7zROrmeHT
        1tV1fjS2KWBDb0hvj3tN5rucuqwnY4fCOntkn+OunnCpNdpCdN9aLwncqwPenY1hP6V4j2xN
        6Iboo+K134UNS0GmNo3n8bAYVFnldj3kgRhXxEkCfXlyheQ/i54H/xgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xy7p6F7ijDVauYbG4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErow3Fz4wFdxhr3hzdA5LA+NNti5GTg4JAROJpu2/2bsYuTiEBJYwSjT8usEM4TQy
        ScxcdpWxi5GDg01AS2JNezxIXERgFaPE1L93wDqYBWazSrx6NIERZJSwgJVE0+R2JhCbRUBV
        onfdMmYQm1fAReL9jbPsEOvkJG6e6wSLcwq4Slze2wZ2hhBQzfbGWSwTGHkWMDKsYhRJLS3O
        Tc8tNtQrTswtLs1L10vOz93ECAz9bcd+bt7BeGlj8CFGAQ5GJR7eht9c0UKsiWXFlbmHGCU4
        mJVEeLl0gUK8KYmVValF+fFFpTmpxYcYpTlYlMR5zxtURgkJpCeWpGanphakFsFkmTg4pRoY
        FXMshVWX1sZ+mMDOvuXhXwk+7alG9YVeMWGPf0/iuf/ctuqBJ9fewCv70kJYT+ftW5KrcjPY
        iMHPNzfmG9uDaX/iZRNEJ3BVZsntjziWnLTHdsGEZ1l/c4NVxGO33Zns9E7hZv3xzRVfb+hu
        OSlwVm7fOfX1E2Inxs7aWFLb+7GDy59Zu8NIiaU4I9FQi7moOBEAr+tZxXkCAAA=
X-CMS-MailID: 20180528094726eucas1p14c9d821881865955a4d8b1735a650c8f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094726eucas1p14c9d821881865955a4d8b1735a650c8f
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094726eucas1p14c9d821881865955a4d8b1735a650c8f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds bindings to BOE HV070-WSA WSVGA panel.
Bindings are compatible with simple panel bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../devicetree/bindings/display/panel/boe,hv070wsa-100.txt         | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt

diff --git a/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
new file mode 100644
index 0000000..bfc20ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
@@ -0,0 +1,7 @@
+BOE HV070WSA-100 7.01" WSVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "boe,hv070wsa-100"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.7.4
