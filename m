Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeDXBxw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:53:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:16326 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeDXBxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:53:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180424015347epoutp0244faa5e1ad1839c928c8e574e4e170ab~oPFknV-841634616346epoutp025
X-AuditID: b6c32a38-6f7ff7000000105c-c5-5ade8e278773
Mime-Version: 1.0
Subject: RE: [PATCH 1/6] dt-bindings: devfreq: rk3399_dmc: improve binding
 documentation.
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "groek@google.com" <groek@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Nick Milner <nick.milner@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180419104019.24406-2-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180424015343epcms1p30dd08ebdea1e25582012711470cf7cdf@epcms1p3>
Date: Tue, 24 Apr 2018 10:53:43 +0900
X-CMS-MailID: 20180424015343epcms1p30dd08ebdea1e25582012711470cf7cdf
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180424015343epcms1p30dd08ebdea1e25582012711470cf7cdf
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmrq56370og7bHShYvD2laXP/ynNXi
        1eY9bBbzj5xjtViwfSWTxZrbhxgtmt5uZ7H4/+g1q8Xmcz2sFmeb3rBbXN41h83ic+8RRoul
        1y8yWfTvv8lq0br3CLsDv8eaeWsYPWY3XGTx2HF3CaPHgk2lHptWdbJ59G1Zxeix/do8Zo/P
        m+QCOKJSbTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CpFGxoa6RkamOsZGQFp41grI1OgkoTUjOtP
        5jEVrGaruNRzlamBcQtrFyMnh4SAicT8i1MYuxi5OIQEdjBKHJm9gb2LkYODV0BQ4u8OYZAa
        YYFoiVfLP7CB2EICShINN/cxQ8T1JToebGMEsdkEdCW2brjLAjJHRGAio8Sxy22sIA6zwAQW
        iYk3v0Bt45WY0f6UBcKWlti+fCsjyDJOASeJLdeNIcKiEjdXv2WHsd8fm88IYYtItN47ywxh
        C0o8+LkbKi4l8eTtQqj6eonrnxcxgeyVEJjAKPH7xn+ohL7EoyuzwT7gFfCV2HJ1NhOIzSKg
        KtHbPBnqNheJVZ1HwIYyC8hLbH87hxnkNmYBTYn1u/Rhzm/Y+Jsdk20rMeEvxM3MAnwS7772
        wL27Y94TJghbTeLQ7iVQ9TISp6cvZJ7AqDwLEdSzkCyehbB4ASPzKkax1ILi3PTUYsMCE73i
        xNzi0rx0veT83E2M4BSsZbGDcc85n0OMAhyMSjy8C37ejRJiTSwrrsw9xCjBwawkwrtX7l6U
        EG9KYmVValF+fFFpTmrxIUZToP8nMkuJJucD80NeSbyhqZGxsbGFiaGZqaGhkjjvU58zUUIC
        6YklqdmpqQWpRTB9TBycUg2MTQwFyxb6nnjS2NssH31k8+TQp0XBAirTF908GtNQ0e3VxPaU
        9V3T5S3KrAsMYlzrepIlfu70P9uTst9rp9pKtf8yH8NZEg/tizSVaHjAvMMo415YLv+vBmf/
        Sf4vXSbpfzM/sCnuyMsD3/TNNwX+9f7J3Ct7y6HLwaMl9Usd+4HQtkW3em8psRRnJBpqMRcV
        JwIAcgJ3kdcDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104054epcas5p49612174afb26493bcd937a0232b9b1df
X-RootMTR: 20180419104054epcas5p49612174afb26493bcd937a0232b9b1df
References: <20180419104019.24406-2-enric.balletbo@collabora.com>
        <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104054epcas5p49612174afb26493bcd937a0232b9b1df@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Nick Milner <nick.milner@collabora.com>
>
>There are several typos, references to non existent files, grammar and
>punctuation mistakes in the rk3399_dmc.txt binding. This patch tries
>to improve the binding documentation and fix these mistakes.
>
>Signed-off-by: Nick Milner <nick.milner@collabora.com>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

CC (The original author of this doc): Lin Huang <hl@rock-chips.com>


Cheers,
MyungJoo.

>---
>
> .../bindings/devfreq/rk3399_dmc.txt           | 207 +++++++++---------
> 1 file changed, 105 insertions(+), 102 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
