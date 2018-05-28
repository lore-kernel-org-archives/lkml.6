Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeE1GAZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:00:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:60756 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbeE1GAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:00:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180528060020epoutp023870311f036157bf5739aa69077dde63~yuYjUmGq_1642616426epoutp02m
X-AuditID: b6c32a38-773ff700000010f7-f3-5b0b9aeea40a
Mime-Version: 1.0
Subject: RE: [PATCH 2/2] PM / devfreq: Generic cpufreq governor
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Saravana Kannan <skannan@codeaurora.org>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d@epcms1p8>
Date: Mon, 28 May 2018 15:00:14 +0900
X-CMS-MailID: 20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA11Sa0hTYRjuO2eeHVerz2n1tW52oMhiujNdni5WlNkiAyMIcox10I8p7iI7
        MyqiltHFrvYjqiWrLEvnorKmo5bUHBVdBDWy+w3DhFyElcS02k2Kfn0Pz/e8z/O+Ly9Nyuop
        OV1qtmGrmTcylETU3JamVAQdo7XKwE45t8t+juD6/Glc97feBO50oD2Be1z5Wcx13aihuIFD
        AcDVdXcQXJXjO8HtvhUQc7c7jlJLR2vcTjfQdB0+RGiaXFWU5tVTH6U5fN0FNANN0wqoQryo
        BPPF2JqKzUWW4lKzIYdZvU6/XK+ep2QV7Hwum0k18yacw+TmFyjySo3h9pjUTbyxIkwV8ILA
        ZCxeZLVU2HBqiUWw5TBallWls8rsdJUq/GbqFqjUYclGXHK8tQWUH6E3D590E3Zwn9oPEmkE
        s9Cn4cYwltAy6AWor71BvB/QtBQmoWFvckSTDJeg354z4giWQQbZn7eSMT4D7XvXDCKYggrk
        ufJaFPFJgU6ABl/UR01J6CXQW18jiKVJ0Ym9H0UxPBm1XPRE+USYhx7VuMkYPx49b+wXj+Av
        d0/Ha1PQ7jeP45ok9O7nzTgvRz39Z+P6Hah7oJaIBCNYDVDo2e/4Rwb68ORUdGQpXIMunXgV
        NRLBmcjj6idimlz05UBflCfhdNTSX0NGNkHCNHT5RsZI//arIfH/mIRjUfD7wYQR3uvsiVvO
        Qv6b5+P6Kejh8bPx/jWoLtRLVIMZjr+7dvwT7PgbfAaQLjABlwsmAxbY8qx0gTcJFWZDepHF
        1ASiVzqH8wJfe74fQBowY6T2kEQrS+A3CVtMfoBokkmRShRhSlrMb9mKrRa9tcKIBT9Qh+c/
        SsrHF1nCN2+26Vm1KjMzk8ti56lZlpko3ZP9q1AGDbwNl2Fcjq0jdQSdKLcDm/P9tpC4Vaue
        rluuXlt3riNXFVgVHLdsVIrEZwgaO815v96MmTR57VS5S+dZf53Ui7YP/jCtgcLXbx/amsvw
        gR07fbUXnBu6GLxk6Or6Y7s6V77AK97PrtS2HaytezlXVz/orlQm3btzrapwA617W80NDA0d
        Cc7YntOYbH/QsJARCSU8O4e0CvwfuNYq7LsDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180518082505epcas2p265038f51fc070a4aada4c692a71ebc3c
References: <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
        <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
        <CGME20180518082505epcas2p265038f51fc070a4aada4c692a71ebc3c@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Many CPU architectures have caches that can scale independent of the CPUs.
>Frequency scaling of the caches is necessary to make sure the cache is not
>a performance bottleneck that leads to poor performance and power. The same
>idea applies for RAM/DDR.
>
>To achieve this, this patch series adds a generic devfreq governor that can
>listen to the frequency transitions of each CPU frequency domain and then
>adjusts the frequency of the cache (or any devfreq device) based on the
>frequency of the CPUs.

I agree that we have some hardware pieces that want to configure
frequencies based on the CPUfreq.

Creating a devfreq governor that configures devfreq-freq
based on incoming events (CPUFreq-transition-event in this case)
is indeed a good idea.

However, I would like to ask the followings:
The overall code appears to be overly complex compared what you need.
- Do you really need to revive "CPUFREQ POLICY" events for this?
especially when you are going to look at "first CPU" only?


Cheers,
MyungJoo
