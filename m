Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932787AbeDXCbW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:31:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:60734 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932709AbeDXCbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:31:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180424023107epoutp044e5ba7706a05bc181f35890f62b5ceac~oPmLNdL4W0811308113epoutp04N
X-AuditID: b6c32a37-968579c000001030-10-5ade96e8c4a4
Mime-Version: 1.0
Subject: RE: [PATCH 3/6] devfreq: rk3399_dmc: remove wait for dcf irq event.
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
        Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180419104019.24406-4-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180424023104epcms1p7935bae38d97c401b0d2a25d7b1b9ee14@epcms1p7>
Date: Tue, 24 Apr 2018 11:31:04 +0900
X-CMS-MailID: 20180424023104epcms1p7935bae38d97c401b0d2a25d7b1b9ee14
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180424023104epcms1p7935bae38d97c401b0d2a25d7b1b9ee14
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTaUwTQRR2Ot12MdasFXSCis0ajTVybGtlUTBG1FQ5xBh/WKOwgRGIPUi3
        NWpirCZ41CMQ70K0eBFQIhS1jSiYlShRi8EbDcSDeiNGlOAB2NI2mvhrvvne99733ssMCeXX
        JdFkodGCzUZOT0tGii/fUCbEvjvcqUv4XaFm3wtK9sm3twT7of6qhD3R3EqwTneViD3/XADs
        9m63mB169ZFg+2tvQ7a+dS/Berd/krIPrpRL2N59zYAtvtYsnT9aW2ZrE2s9HaeB1umyal3V
        uyXaAUeTWLv/YjXQuh8fh9peV0wWqcPJBZjLw2YFNuaa8gqN+Sl02ors1GzN7AQmlkliE2mF
        kTPgFHphelbs4kK9v21asYHTW/1UFsfzdPy8ZLPJasGKAhNvSaFXM4wqjklIjFOp/Kd6zRyV
        xi/JwQWDgoMoekZs/HmrR2QDbWI7iCARNQt1XeiX2sFIUk55ADrgPSWyA5KUUWPQgGdsQDOW
        SkfHvAIMYDlFI1t7Iwzy8WjXi8sggCVULLpU2yEO1ImkSgG6+WAHEbhA6iVEvsFDIOgmQ0d3
        +kLOE5C78tIwH0EtQI+ay0VBPgq1n+uWhnHPzROh3EhU3OmFQTwGvfjREOKjUVd3RUi/FT3p
        PSkKGCOqBKBfT4dCgXj06mGZJIBlVAa6d6ZpuJCYmorKq8JFF6LXRz8P6yE1Gbm7y2FgE5BS
        ogtX4sP92+p+Sf/HKWjomACCqaPR5+97ibDGc7wrNNc0JDScDuknojtHKmAJmOL4u2vHP8aO
        v8ZOAKvBOFzEG/IxzxSp43jOwFuN+XG5JoMLDL/eGYkeUNuaLgCKBPQomfNHh05OcBv4TQYB
        IBLSkbJrMZ06uSyP27QZm03ZZqse8wLQ+OcvhdFRuSb/XzBashmNSq1Ws7OY2RqGocfLfOl3
        dXIqn7Pg9RgXYXM4T0RGRNvApCN99xSu83V7SkeocjKT5k9MfvZ1bc0jKGo62FbZU/V62R2f
        fW6rt6EvtabGxy2tb+GvX4WOupyWRl1SY+33kjTwZp0yM2lANNPZdfhQ2iq7PuPs/eUfo/qX
        rTBv7XvsKMTVnxYNLk0dXBLTcrF4m7J9ZcwXgtzSOz3j4Ly+plORtJgv4JgZ0MxzfwBJhd9O
        0wMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104056epcas2p29c74949b650fea596900e395dec662e8
X-RootMTR: 20180419104056epcas2p29c74949b650fea596900e395dec662e8
References: <20180419104019.24406-4-enric.balletbo@collabora.com>
        <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104056epcas2p29c74949b650fea596900e395dec662e8@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We have already wait dcf done in ATF, so don't need wait dcf irq
> in kernel, besides, clear dcf irq in kernel will import competiton
> between kernel and ATF, only handle dcf irq in ATF is a better way.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

This does not apply to 4.17-rc2 or a little less recent rc's.

Would you please rebase to the latest?


Cheers,
MyungJoo

> ---
> 
>  drivers/devfreq/rk3399_dmc.c | 53 +-----------------------------------
>  1 file changed, 1 insertion(+), 52 deletions(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 5dfbfa3cc878..44a379657cd5 100644
> 
