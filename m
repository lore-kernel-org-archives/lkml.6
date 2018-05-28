Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeE1FEx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:04:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:27918 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbeE1FEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:04:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180528050447epoutp02dad93d45f4dec79fdb4dc92e774643d2~ytoDNKam50727407274epoutp028
X-AuditID: b6c32a36-bd1ff70000000fe4-fa-5b0b8dec8f46
To: undisclosed-recipients:;
Mime-Version: 1.0
Subject: RE: [PATCH 05/11] PM / devfreq: governors: Return device frequency
 limits instead of user limits
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
In-Reply-To: <20180525203043.249193-6-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180528050444epcms1p8e6552d55231a099ec89304dfb1f819b9@epcms1p8>
Date: Mon, 28 May 2018 14:04:44 +0900
X-CMS-MailID: 20180528050444epcms1p8e6552d55231a099ec89304dfb1f819b9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOjtbiuKzelqSdsFLY9GxNT5ERZHUoi0E/DEXsoB+b6C7s
        bF2JZmGZZTeIQs110YxlWLPMLAuX9acsy8qC7lZGZFLrgpnZbl1+fQ/P+7zf8z4vL0Uo60kV
        VWRxYLtFKGHIaGnLtSS1+kPlmNzU3oZp3Mj+G3LO+2lQxvV+6Zdx7s7bMq7rRAfJbT3eRHJd
        Wz7IuZ62GpLzV3Yirr73roTzn+lDXFl7p3zBWL6xthHxwz/2I77adVfKez07SP7q4UY5v/uc
        B/F+71SDPAfPM2GhENsTsKXAWlhkMWYwy1bmL8zXp6WyanYOl84kWAQzzmAyswzqxUUlgUmZ
        hDVCiTNAGQRRZFLmz7NbnQ6cYLKKjgwml2W1GjY1XaPVBl5d3lytPiBZjU3Xq3zIdjJqXf3x
        ExIXei6vQFEU0LPhdO3ZAI6mlHQrgocVbZJgIZaOg8PVfbIKRFEKOgZGWscH6fF0MZR/3oOC
        WEkz4Hp8hQjzKVD+oiXEk7Qazp95Kg3+SdB1Uqg7O4rCZgo4tP2NNIynwIWG8yE+ik4Hr7s9
        MtAEeHxq4C8evOGO9MZC2bMuIoxj4MXQpQivgtcDRyP6zdDrPyYJGgO9F8Hwo9FIIQVe3a8m
        w2GWw7V3oV4pnQjfPGURSSY87KgNZSfoeLgwUEME5QSdBE1tKWF6HHz8ukv2J0pr7WtJGM8A
        36W6yDdxcPPg0VAr0Dy8bJkZXu0pBP3fa8i9KL7q30ar/jOr+md2BBEeNBHbRLMRi6xNqxEF
        s+i0GDUFVrMXhU40Oa0VHbud5UM0hZixCtdwdK5SJqwR15t9CCiCiVVEqwOUolBYvwHbrfl2
        ZwkWfUgfyLyPUE0osAYO3uLIZ/VanU7HzWbT9CzLTFJsS/+Vo6SNggMXY2zD9j99EipK5UKV
        X4zubXv6FQbPqDvm/WBOdRvf3PRt0dpRZ0Op9fmPbNPSGQsu6oylaRWbbPXNTz7eOTmiWnzP
        3wOls7b8FG6x6gerp29MytoxtGpZuzPbkOh1LsnYKY2XdWu2dpfnDGTnFTl1cc0rMl1HFJMT
        56+VN/cMNWGNsm847+1lW7b+ACMVTQKbTNhF4TfAdUXKuAMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203125epcas3p46c7cac352ede4b0ba5d2b36bc32ad566
References: <20180525203043.249193-6-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203125epcas3p46c7cac352ede4b0ba5d2b36bc32ad566@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>The performance, powersave and simpleondemand governors can return
>df->min/max_freq, which are the user defined frequency limits.
>update_devfreq() already takes care of adjusting the target frequency
>with the user limits if necessary, therefore we can return
>df->scaling_min/max_freq instead, which is the min/max frequency
>supported by the device at a given time (depending on the
>enabled/disabled OPPs)
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/governor_performance.c    | 2 +-
> drivers/devfreq/governor_powersave.c      | 2 +-
> drivers/devfreq/governor_simpleondemand.c | 6 +++---
> 3 files changed, 5 insertions(+), 5 deletions(-)
>

Actually, even scaling_max_freq and scaling_min_freq are
covered centerally at devfreq.c:update_devfreq();

Wouldn't it be sufficient to return UINT_MAX for performance
and return UINT_MIN (0) for powersave, if the purpose is to
remove redundancy?

In the same sense, we may return UINT_MAX for freq-increasing
case for simpleondemand as well, because they are filtered
centrally anyway.

(This commit might be better merged to 4/11 in that case as well.)


Cheers,
MyungJoo
