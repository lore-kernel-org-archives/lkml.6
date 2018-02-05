Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeBEPob (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:44:31 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16323 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeBEPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:44:25 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180205154423epoutp02c9f70bc18d938e59cc9b841bd9d0db53~QeGg03eSS3221532215epoutp02J
X-AuditID: b6c32a45-403ff70000001023-45-5a787bd6b5b2
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 0/8] ASoC: samsung: Add HDMI sound support for tm2 board
Date: Mon, 05 Feb 2018 16:43:55 +0100
Message-id: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCmqe616ooogx+3BC2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujAPPLzMV
        XOCsOPl1EmsD41z2LkZODgkBE4l5Hx6wdjFycQgJ7GCU2D+rDywhJPCdUeLjHtsuRg6woiXz
        yyBqdjNK3J32ghHC+cUosat5ChtIA5uAoUTv0T5GEFtEQEzi9pxOZpAiZoEzTBLT961hAkkI
        C3hIzFx6DayBRUBV4tmBJrBtvALWEivu7maGOEle4v2C+2AbJASWsEks+76QCSLhIjHh3CGo
        ImGJV8e3QP0gLfFs1Uaohn5GiRNrmqGcGYwSd9onQHVbSxw+fpEVxGYW4JPoOPyXHeI5XomO
        NiGIEg+JvvtLoBY4SnxesIoJEhaxEkfmXmaawCi5gJFhFaNYakFxbnpqsVGBoV5xYm5xaV66
        XnJ+7iZGcOxque5gnHHO5xCjAAejEg+vQEZFlBBrYllxZe4hRgkOZiURXqfr5VFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEedsCXKKEBNITS1KzU1MLUotgskwcnFINjDVbvp+YuV4rZ9mV1JcH
        KjzvtUfUuCbknslNErUIvFiTzZTQtHTSKRvOVMkXlyvelNvXnnXcufdvw4VNFvf8TW5vqEov
        bnaMOJD0bl6B6oIg1gcKZ/dfX7CNKUebz0YtZvaqNK8N7oeV02adar8yjeuCHG/WEb7i+xNl
        e75X6M6fx7+A7Y3kWyWW4oxEQy3mouJEADKLEzHZAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t9jAd2r1RVRBpO3KlhcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGQeeX2Yq
        uMBZcfLrJNYGxrnsXYwcHBICJhJL5pd1MXJyCAnsZJR4PZO3i5ELyP7FKPFy00FmkASbgKFE
        79E+RhBbREBM4vacTmaQImaBM0wSXyZeYgdJCAt4SMxceo0NxGYRUJV4dqAJLM4rYC2x4u5u
        sEESAvIS7xfcZ5zAyLWAkWEVo2RqQXFuem6xUYFRXmq5XnFibnFpXrpecn7uJkZgQG07rNW/
        g/HxkvhDjAIcjEo8vAIZFVFCrIllxZW5hxglOJiVRHidrpdHCfGmJFZWpRblxxeV5qQWH2KU
        5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamAsuCmf8K1+38tOid66zC+8Qb82x7GXZP9O
        DMlMW/ySXzD2ct/d8ut/64vyU6wKZ5mskGSYor+F5ac2V4/e3h+Tb7BMWbhLjjnK0ED3nAD3
        n6Y7xdnHz90ss305W8f949QNdtV7/xg+m2m6TV1bqVhJOG2GgK7epDvLDK782fk63CXNY94s
        zRAlluKMREMt5qLiRABPC88oJAIAAA==
X-CMS-MailID: 20180205154421epcas2p16072f713ea81f72b3f8230f6a9d412cf
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205154421epcas2p16072f713ea81f72b3f8230f6a9d412cf
X-RootMTR: 20180205154421epcas2p16072f713ea81f72b3f8230f6a9d412cf
References: <CGME20180205154421epcas2p16072f713ea81f72b3f8230f6a9d412cf@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for HDMI audio on exynos5433 tm2 board, it
includes a few fixes for the I2S driver and an extension of the existing
card driver to support the I2S1<->HDMI transmitter path.

Sylwester Nawrocki (8):
  ASoC: samsung: i2s: Ensure the RCLK rate is properly determined
  ASoC: samsung: i2s: Ensure names of supplied clocks are unique
  ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access
  ASoC: samsung: i2s: Define the parameters list for SAMSUNG_I2S_OPCLK
  ASoC: samsung: Add support for HDMI audio on TM2 board
  ASoC: samsung: i2s: Update clock-output-names property documentation
  ASoC: samsung: Add missing #sound-dai-cells property documentation
  ASoC: samsung,tm2-audio DT binding documentation update

 .../bindings/sound/samsung,tm2-audio.txt           |  14 +-
 .../devicetree/bindings/sound/samsung-i2s.txt      |  22 +--
 sound/soc/samsung/i2s-regs.h                       |  11 +-
 sound/soc/samsung/i2s.c                            |  50 ++++--
 sound/soc/samsung/i2s.h                            |  11 +-
 sound/soc/samsung/tm2_wm5110.c                     | 180 ++++++++++++++++++---
 6 files changed, 229 insertions(+), 59 deletions(-)

--
2.14.2
