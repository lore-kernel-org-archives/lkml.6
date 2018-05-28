Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeE1E5z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 00:57:55 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:57901 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeE1E5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 00:57:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180528045749epoutp0122b2fd3cbc16183cd7a9ae3d70b7317a~yth9Y7MEC2200622006epoutp01j
X-AuditID: b6c32a39-24dff7000000106b-41-5b0b8c48474a
To: undisclosed-recipients:;
Mime-Version: 1.0
Subject: RE: [PATCH 04/11] PM / devfreq: Remove redundant frequency
 adjustment from governors
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
In-Reply-To: <20180525203043.249193-5-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180528045744epcms1p115f761df5eff88a1648639385425f02b@epcms1p1>
Date: Mon, 28 May 2018 13:57:44 +0900
X-CMS-MailID: 20180528045744epcms1p115f761df5eff88a1648639385425f02b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmnq5HD3e0wb3PEhZ/Jx1jt9j08T2r
        xctDmhbXvzxntZh/5ByrxdllB9ksmhevZ7M42/SG3eLyrjlsFp97jzBaLL1+kcni84bHjBat
        e4+wO/B6rJm3htHj969JjB6zGy6yeGxa1cnmsX/uGnaPvi2rGD0+b5ILYI9KtclITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
        b2dTlF9akqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM6a+f8xcsJ+1omf3BbYGxiMs
        XYycHBICJhJzFt9i62Lk4hAS2MEo8ebYUzaQhIiAjMTc2Y9Zuxg5OHgFBCX+7hAGMYUF4iVW
        njQHqRASUJJouLmPGcQWFtCX6HiwjRHEZhPQldi64S4LyEhmgSUsEks2/meE2MUrMaP9KdRe
        aYnty7eCxTkFzCWWre1mh4iLStxc/RbOfn9sPlSviETrvbPMELagxIOfu6HiUhJP3i6Eqq+X
        uP55ERPIYgmBCYwSv2/8h0roSzy6MhvsL14BX4lrW36AxVkEVCVWHXgCNdRFYkPHIrChzALy
        EtvfzmEGeZhZQFNi/S59mPsbNv5mR2czC/BJvPvawwoT3zHvCROErSZxaPcSqHoZidPTF0Kt
        8pDYsvU56wRGxVmI0J2FZPEshMULGJlXMYqlFhTnpqcWGxaY6hUn5haX5qXrJefnbmIEJ1kt
        yx2Mx875HGIU4GBU4uFt+M0VLcSaWFZcmXuIUYKDWUmEl0sXKMSbklhZlVqUH19UmpNafIjR
        FOj/icxSosn5wAyQVxJvaGpkbGxsYWJoZmpoqCTO22b+L0pIID2xJDU7NbUgtQimj4mDU6qB
        0a5zovo6A9OYKo2EEO5HUVyFjhKbC/as9eg++vvvUrVVfzdemyB4+8oWIfmYgkdFewPDErf5
        qv1868DAmMIQvY/bp/yfTh3PjA7d9l3hZ63i5pZdvSdjtuds+6kgzlUcr/6G/+v8POlmto78
        M/HJIRdPqVxf9IHJ4Ya/ta9y82We94K7hWd9UWIpzkg01GIuKk4EAMZS1a/IAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203124epcas2p2db3f1996b33348f19a6a91cee55abb0b
References: <20180525203043.249193-5-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203124epcas2p2db3f1996b33348f19a6a91cee55abb0b@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The userspace and simpleondemand governor determine a target frequency and
> then adjust it according to the df->min/max_freq limits that might have
> been set by user space. This adjustment is redundant, it is done in
> update_devfreq() for any governor, right after returning from
> governor->get_target_freq().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_simpleondemand.c |  5 -----
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  2 files changed, 4 insertions(+), 17 deletions(-)
> 

Yes, indeed. Governors are no longer required to be aware of min/max freq.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
