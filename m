Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbeBERFg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:05:36 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:43141 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbeBERF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:05:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180205170525epoutp0180147b807fb522362e4bd4aa0b2940ea~QfNQ31Ise0656906569epoutp019
X-AuditID: b6c32a37-44bff70000001029-9e-5a788ed4fb16
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: Add the DT binding files entry to
 MAINTAINERS
Date: Mon, 05 Feb 2018 18:05:00 +0100
Message-id: <20180205170500.8992-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCmnu6VvooogxlLuS2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujIaWa+wF
        81krWuceZm9g3MLSxcjJISFgIrH293qmLkYuDiGBHYwSv9rmMUM43xklZu9ZxQRTNXXfWUaI
        xG5GiRXnbkE5v4Ba5u5mBaliEzCU6D3axwhiiwiISdye0wk2ilngDJPE9H1rwEYJC/hLXGy+
        wgZiswioSkxo/ADWwCtgJfHj2WKodfIS7xfcZ4SwF7BJdGx0gbBdJJ4/fMsOYQtLvDq+Bcjm
        ALKlJS4dtQXZJSHQzyhxYk0zI4Qzg1HiTvsEqKHWEoePXwS7lFmAT+Ld1x5WiGZeiY42IYgS
        D4mby5cwQoQdJc7M4AAxhQRiJab8LJ7AKLmAkWEVo1hqQXFuemqxYYGxXnFibnFpXrpecn7u
        JkZw3GqZ72DccM7nEKMAB6MSD69ARkWUEGtiWXFl7iFGCQ5mJRFep+vlUUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5AwJcooQE0hNLUrNTUwtSi2CyTBycUg2MzFk3w7S2TY20Z26pbNro3PDm
        dKrKD03218Xc01j04xMuJ+q0NWTM1G/lMut0eB8bZnlj9unVovskuLmOHso9L31l8+5LlevU
        5aKd3QsYrJ5rzZFbtmhS6NM3IY++OKWYLSudmP9i0+Ys6dLnE3mncAVEhp6+1BPX1PQz+LkI
        U8Zzx4Ib+XOVWIozEg21mIuKEwEqLQzZ1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsVy+t9jAd3LfRVRBltWCFpcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGQ0t19gL
        5rNWtM49zN7AuIWli5GTQ0LARGLqvrOMXYxcHEICOxklOm5fYYdwfjFKrGmZB1bFJmAo0Xu0
        jxHEFhEQk7g9p5MZpIhZ4AyTxJeJl9hBEsICvhJbJ+0CK2IRUJWY0PgBzOYVsJL48WwxE8Q6
        eYn3C+4zTmDkWsDIsIpRMrWgODc9t9iowDAvtVyvODG3uDQvXS85P3cTIzCoth3W6tvBeH9J
        /CFGAQ5GJR7ejKyKKCHWxLLiytxDjBIczEoivE7Xy6OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYJy95OBqpZOu95+JNO2TbFbg0F+n8PVTQjPfzquX
        rHtXLfIsmWufOCMhVm3dUZ3zoj5z/qxKyTigKf/nwMIVz144xU9eeX63LfM0hXP3mL68/HZt
        kmd4zv+UrbmHvp1edDbqet/jTRmhveef7KnhuXl6h/M3dT9rK6nXa3RUtvAp6pc8eJPq43Fd
        iaU4I9FQi7moOBEAWXNyliYCAAA=
X-CMS-MailID: 20180205170523epcas1p31ebef69e5d5db0a1ef2f1c3b5ac544ae
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205170523epcas1p31ebef69e5d5db0a1ef2f1c3b5ac544ae
X-RootMTR: 20180205170523epcas1p31ebef69e5d5db0a1ef2f1c3b5ac544ae
References: <CGME20180205170523epcas1p31ebef69e5d5db0a1ef2f1c3b5ac544ae@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing DT binding files to the Samsung ASoC
drivers entry.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5046003ea162..da2df3194d72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11921,6 +11921,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/samsung/
+F:	Documentation/devicetree/bindings/sound/samsung*
 
 SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-- 
2.14.2
