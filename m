Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935517AbeBLQP7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:15:59 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12768 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934873AbeBLQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:15:57 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180212161555epoutp038d06166b41fd91182f0be927806b20c5~SoDCpAKzm1960419604epoutp03e
X-AuditID: b6c32a46-3c1ff70000001029-c1-5a81bdbaccd4
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 0/7] ASoC: samsung: Add HDMI sound support for tm2 board
Date: Mon, 12 Feb 2018 17:15:31 +0100
Message-id: <20180212161538.22669-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCmhe6uvY1RBqeua1tcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGaePPmEq
        6OOqePdvF3sD4wX2LkZODgkBE4kzc5cydzFycQgJ7GCUOLWhmRHC+c4o8WX9VEaYqvcfF0BV
        7WaU+Ph5JpTzi1Hi9PbbTCBVbAKGEr1H+8A6RATEJG7P6QQrYhY4wyQxfd8asCJhAW+JCYvu
        M4PYLAKqEqeXvgWL8wpYS2yceIUJYp28xPsF98HukBBYwCbxa/YSVoiEi8TV07PYIGxhiVfH
        t0B9IS3xbNVGqIZ+oPuO72eBcFYzSrz+tguq21ri8PGLYDazAJ9Ex+G/QN0cQHFeiY42IYgS
        D4m+6U+gnnaUuHXrKli5kECsxP/f55gnMEouYGRYxSiWWlCcm55abFRgpFecmFtcmpeul5yf
        u4kRHL9abjsYl5zzOcQowMGoxMPbMbsxSog1say4MvcQowQHs5II759moBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHe1gCXKCGB9MSS1OzU1ILUIpgsEwenVAOjc3KiRNfigMVv7F6UnGd7d1LK
        26b8pcDyVe6TfDNZfm/+tGXyBU2LxdlttpqnFZXqVifvPxCzT6P0dIXk61y3l4L/rr/ZL7fq
        wda2ZKfWI8uj1z21eP6lYcHGjRus/WcuPROuVsRizCyfcjmxRr9WVnLytJeJ3X/Nfn5tzpgp
        uP2p/R+vfClGJZbijERDLeai4kQAmlP1gNsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsVy+t9jAd1dexujDDbskbW4cvEQk8XGGetZ
        LaY+fMJmMf/IOVaLt/u7mS3On9/AbvHtSgeTxeVdc9gsZpzfx2Sx9shddovWvUfYLQ6/aWe1
        uLjiC5MDr8eGz01sHjtn3WX32LSqk82jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mk4ffcJU
        0MdV8e7fLvYGxgvsXYycHBICJhLvPy5g7mLk4hAS2MkocWLXTyYI5xejRPeXXawgVWwChhK9
        R/sYQWwRATGJ23M6wTqYBc4wSXyZeAlslLCAt8SERfeZQWwWAVWJ00vfMoHYvALWEhsnXmGC
        WCcv8X7BfcYJjFwLGBlWMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIEBtW2w1r9Oxgf
        L4k/xCjAwajEw9sxuzFKiDWxrLgy9xCjBAezkgjvn2agEG9KYmVValF+fFFpTmrxIUZpDhYl
        cV7+/GORQgLpiSWp2ampBalFMFkmDk6pBsYmk+vvKy9t70/bfPlmYimD2LLXhXWi/yP5a8q+
        ccRo9/080FWTJLfZ6fndjBdchy8zzqtPdDn30ubHyet5ietWZFQkKDXLuwSIxH+x8xJ5uS/5
        9qQdQn9uOAl0lnDbTbZ2Nl/6K6VY3u/1kslLFry/u/Gw9y6+mce9FW+fDn14Pe5A6vfW8hwl
        luKMREMt5qLiRACX5u5wJgIAAA==
X-CMS-MailID: 20180212161554epcas2p26c19860d14006b0e1501699dc50d3f2f
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180212161554epcas2p26c19860d14006b0e1501699dc50d3f2f
X-RootMTR: 20180212161554epcas2p26c19860d14006b0e1501699dc50d3f2f
References: <CGME20180212161554epcas2p26c19860d14006b0e1501699dc50d3f2f@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for HDMI audio on exynos5433 tm2 board, it
includes a few fixes for the I2S driver and an extension of the existing
card driver to support the I2S1<->HDMI transmitter path.

In v2 only support for 48k/96k/192k samples rate is left, as adjusting
the AUD PLL output frequency might cause regressions.

Sylwester Nawrocki (7):
  ASoC: samsung: i2s: Update clock-output-names property documentation
  ASoC: samsung: i2s: Ensure names of supplied clocks are unique
  ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access
  ASoC: samsung: i2s: Define the parameters list for SAMSUNG_I2S_OPCLK
  ASoC: samsung,tm2-audio DT binding documentation update
  ASoC: samsung: Add support for HDMI audio on TM2 board
  ASoC: samsung: Add missing #sound-dai-cells property documentation

 .../bindings/sound/samsung,tm2-audio.txt           |  14 +-
 .../devicetree/bindings/sound/samsung-i2s.txt      |  22 +--
 sound/soc/samsung/i2s-regs.h                       |  11 +-
 sound/soc/samsung/i2s.c                            |  39 ++++--
 sound/soc/samsung/i2s.h                            |  11 +-
 sound/soc/samsung/tm2_wm5110.c                     | 152 +++++++++++++++++----
 6 files changed, 191 insertions(+), 58 deletions(-)

--
2.14.2
