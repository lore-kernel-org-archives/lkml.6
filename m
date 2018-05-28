Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeE1FUH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:20:07 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35994 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeE1FUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:20:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180528052001epoutp027a2f88c23cae98a407d9ceec7f28c801~yt1WSVnDS1835518355epoutp024
X-AuditID: b6c32a39-235ff7000000106b-7a-5b0b9175af7e
To: undisclosed-recipients:;
Mime-Version: 1.0
Subject: RE: [PATCH 07/11] PM / devfreg: Add support policy notifiers
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180525203043.249193-8-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180528051949epcms1p3bedd6ac3e2f20d0bcd8cb082349d97fa@epcms1p3>
Date: Mon, 28 May 2018 14:19:49 +0900
X-CMS-MailID: 20180528051949epcms1p3bedd6ac3e2f20d0bcd8cb082349d97fa
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmvm7pRO5og0lrNCz+TjrGbrHp43tW
        i5eHNC2uf3nOajH/yDlWi7PLDrJZNC9ez2ZxtukNu8XlXXPYLD73HmG0WHr9IpPF5w2PGS1a
        9x5hd+D1WDNvDaPH71+TGD1mN1xk8di0qpPNY//cNewefVtWMXp83iQXwB6VapORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
        386mKL+0JFUhI7+4xFYp2tDQSM/QwFzPyAhIG8daGZkClSSkZny/2cFasICjou18E2sD4wO2
        LkZODgkBE4mWhr+sXYxcHEICOxglznYvZQdJiAjISMyd/RgowcHBKyAo8XeHMEhYWMBV4uCZ
        vcwgtpCAkkTDzX3MEHF9iY4H2xhBbDYBXYmtG+6ygMxkFljCIrFk439GiGW8EjPan7JA2NIS
        25dvZQSZzylgLrHhTCZEWFTi5uq37DD2+2PzoVpFJFrvnWWGsAUlHvzcDRWXknjydiFUfb3E
        9c+LmED2SghMYJT4feM/VEJf4tGV2WAP8wr4Sux7vpwVxGYRUJVYN6cBqsZF4tzbBrA4s4C8
        xPa3c5hBbmMW0JRYv0sf5vyGjb/Z0dnMAnwS7772sMLEd8x7wgRhq0kc2r0Eql5G4vT0hVD3
        e0jM23CFdQKj4ixE6M5CsngWwuIFjMyrGMVSC4pz01OLDQtM9YoTc4tL89L1kvNzNzGCk6yW
        5Q7GY+d8DjEKcDAq8fA2/OaKFmJNLCuuzD3EKMHBrCTCy6ULFOJNSaysSi3Kjy8qzUktPsRo
        CvT/RGYp0eR8YAbIK4k3NDUyNja2MDE0MzU0VBLnbTP/FyUkkJ5YkpqdmlqQWgTTx8TBKdXA
        WClzYob2koj4F/N3Lt/7RuV8Rvn54sXVDEk3UrNt5G6w1S3axb/OYYnXr/V2Sk4N1wVTZi/d
        dcjT/UZA4frJrlp+H7o0pL39li5ce7idZ59t+ydlsysCj7+43pG1mzx/Z+qP6in9Uv7fpS9M
        Y+k4vz2daXpT+Pm8QLuQbd+e7mVP+qvz1LDigRJLcUaioRZzUXEiALeEl/7IAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203128epcas5p138dbf89498c03bc2a9221aa662001fd4
References: <20180525203043.249193-8-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203128epcas5p138dbf89498c03bc2a9221aa662001fd4@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Policy notifiers are called before a frequency change and may narrow
>the min/max frequency range in devfreq_policy, which is used to adjust
>the target frequency if it is beyond this range.
>
>Also add a few helpers:
> - devfreq_verify_within_[dev_]limits()
>    - should be used by the notifiers for policy adjustments.
> - dev_to_devfreq()
>    - lookup a devfreq strict from a device pointer
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++-------
> include/linux/devfreq.h   | 66 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 102 insertions(+), 11 deletions(-)

Hello Matthias,


Why should we have yet another notifier from an instance of devfreq?
Wouldn't it better to let the current notifier (transition notifier)
handle new events as well by adding possible event states to it?

Anyway, is this the reason why you've separated some data of devfreq
into "policy" struct? (I was wondering why while reading commit 6/11).


Cheers
MyungJoo
