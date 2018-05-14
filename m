Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeENKYF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:24:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34337 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeENKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:24:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180514102358epoutp046ddb89e4ed8750d0751327953b2efb9f~ue8uqm3SD2036020360epoutp04g
X-AuditID: b6c32a36-b6dff70000001027-64-5af963bc27a5
Mime-Version: 1.0
Subject: RE: [PATCH v4 6/6] devfreq: rk3399_dmc: fix spelling mistakes.
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180509125749.31318-7-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180514102355epcms1p5baf3df2741827f9b9bf3e1de37e27880@epcms1p5>
Date: Mon, 14 May 2018 19:23:55 +0900
X-CMS-MailID: 20180514102355epcms1p5baf3df2741827f9b9bf3e1de37e27880
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180514102355epcms1p5baf3df2741827f9b9bf3e1de37e27880
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmnu6e5J9RBrefsVm8PKRpcf3Lc1aL
        V5v3sFnMP3KO1WLB9pVMFmtuH2K0OPVqGbPF/0evWS1+bDjFbLH5XA+rxdmmN+wWl3fNYbP4
        3HuE0aJ17xF2i+Nrwx34PWY3XGTx2HF3CaPHgk2lHptWdbJ53Lm2h83j76z9LB59W1Yxemy/
        No/Z4/MmuQDOqFSbjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
        XbfMHKD7lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGQNo41srIFKgk
        ITXj6elf7AUrmSsWnGlla2C8y9TFyMkhIWAi0dS2g7WLkYtDSGAHo8TrGbPYuxg5OHgFBCX+
        7hAGqREWcJe4ffEmM4gtJKAk0XBzHzNEXF+i48E2RhCbTUBXYuuGuywgc0QEJjJKHLvcBjaU
        WWAZi8TJbWdYILbxSsxofwplS0tsX74VrJtTwEniWPMXRoi4qMTN1W/ZYez3x+ZDxUUkWu+d
        ZYawBSUe/NwNFZeSePJ2IVR9vcT1z4uYQBZLCExglPh94z9UQl/i0ZXZbCA2r4CvxOUvzawg
        X7IIqEp87PGBKHGRaJm3F6ycWUBeYvvbOcwgJcwCmhLrd+nDnN+w8Tc7JttW4tuxG0wQrXwS
        7772sMLU7Jj3BBrQahKHdi+BqpeROD19IfMERuVZiKCehWTxLITFCxiZVzGKpRYU56anFhsW
        GOkVJ+YWl+al6yXn525iBKdiLbMdjIvO+RxiFOBgVOLhDVj+I0qINbGsuDL3EKMEB7OSCO9u
        o59RQrwpiZVVqUX58UWlOanFhxhNgd6fyCwlmpwPzBN5JfGGpkbGxsYWJoZmpoaGSuK8c5S+
        RgkJpCeWpGanphakFsH0MXFwSjUwulf7m/DP+p1neH+Rx+sJtjGOQnU/HEQuS2QxF96N0b+w
        tWidv7mV9lJtubKTe2/y908P+eycsu/CKZsVCom5H9lCZzEdcT9YW/Xb2OjmGpsvXz48Oap0
        1M/k+SSXGxJr9tevYvtS7vp+epPKo/Dv29nmvrmh9+Bn+Rah49qlU5I5r+3/KJ/op8RSnJFo
        qMVcVJwIABFjLRjbAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509125806epcas3p42927285eece7f031ad7c9e422ee0a43c
X-RootMTR: 20180509125806epcas3p42927285eece7f031ad7c9e422ee0a43c
References: <20180509125749.31318-7-enric.balletbo@collabora.com>
        <20180509125749.31318-1-enric.balletbo@collabora.com>
        <CGME20180509125806epcas3p42927285eece7f031ad7c9e422ee0a43c@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Fix some spelling mistakes in error and debug messages.
>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>---
>
>Changes in v4:
>- [6/6] Introduce this new patch that fixes some spelling.
>
>Changes in v3: None
>Changes in v2: None
>
> drivers/devfreq/rk3399_dmc.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
