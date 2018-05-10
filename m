Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966068AbeEJBPB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:15:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51047 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965830AbeEJBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:14:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180510011457epoutp021219da4bcc6e9055a18b70633e4dd955~tI4Ov210e0357503575epoutp02C
X-AuditID: b6c32a38-6f7ff7000000105c-a1-5af39d0f52d1
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AF39D0F.20006@samsung.com>
Date: Thu, 10 May 2018 10:14:55 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com
Subject: Re: [PATCH v4 6/6] devfreq: rk3399_dmc: fix spelling mistakes.
In-reply-to: <20180509125749.31318-7-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmgS7/3M9RBpc/KVi82ryHzWL+kXOs
        FmtuH2K0OPVqGbPF/0evWS1+bDjFbLH5XA+rxdmmN+wWl3fNYbP43HuE0eJ24wo2i9a9R9gt
        jq8Nd+D1mN1wkcVjx90ljB6bVnWyedy5tofN4++s/SwefVtWMXpsvzaP2ePzJrkAjqhUm4zU
        xJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygk5UUyhJzSoFC
        AYnFxUr6djZF+aUlqQoZ+cUltkrRhoZGeoYG5npGRkDaONbKyBSoJCE149W7m2wFe1kq/l++
        wdLAeJi5i5GTQ0LARGL3iTPsILaQwA5GiV9XbLsYuYDs74wSE7ZshSt6N+82K0RiN6PE+38N
        TCAJXgFBiR+T77F0MXJwMAvISxy5lA0SZhbQlNi6ez07RP1dRonZOzayQNRrSNyedA1sKIuA
        qkTb+vdsIDabgJbE/hc3wGx+AUWJqz8eM4LYogIREjvnfwMbJCLQwijxbu9fJogNtxkl/rUY
        gCwWFnCX2PffGiTMKeAk8XLyRiaQegmByewSrS/usUN84CIxqWEWlC0s8er4FnaQXgkBaYlL
        R20h6tsZJdr3zmOGcKYwSpy7fo8JosFY4tnCLqjFfBLvvvawQjTzSnS0CUGUeEj0XJnKBmE7
        Srzsv84G8f1ZRomjs/+xTmCUm4UUYLMQATYLKcAWMDKvYhRLLSjOTU8tNiww0StOzC0uzUvX
        S87P3cQITqRaFjsY95zzOcQowMGoxMM7g+tzlBBrYllxZe4hRgkOZiUR3sfxQCHelMTKqtSi
        /Pii0pzU4kOMpsDwnsgsJZqcD0zyeSXxhqZGxsbGFiaGZqaGhkrivE99zkQJCaQnlqRmp6YW
        pBbB9DFxcEo1MLpkTVVe4rP1vfK6A3185mkxgdsEYnxO2L473XZbgNl/4ZLPoRMXbur5wfRi
        iUTxrweZO/Y/un1IyydUy8Fs3aREhz+ffuTNVby1/9XHVT5+XMw6XgrTuPqcjtlplqZHsLKF
        npadcm+aL8N19ub8rHuzHk2s17seKNA6f/l6C5clJ1JNNKS8M5RYijMSDbWYi4oTAQcM6J26
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e+xgC7/3M9RBotX8li82ryHzWL+kXOs
        FmtuH2K0OPVqGbPF/0evWS1+bDjFbLH5XA+rxdmmN+wWl3fNYbP43HuE0eJ24wo2i9a9R9gt
        jq8Nd+D1mN1wkcVjx90ljB6bVnWyedy5tofN4++s/SwefVtWMXpsvzaP2ePzJrkAjigum5TU
        nMyy1CJ9uwSujFfvbrIV7GWp+H/5BksD42HmLkZODgkBE4l3826zdjFycQgJ7GSUWDH7PliC
        V0BQ4sfkeyxdjBwczALyEkcuZYOEmQXUJSbNW8QMUX+fUeLo0X2MEPUaErcnXQPrZRFQlWhb
        /54NxGYT0JLY/+IGmM0voChx9cdjRpCZogIREt0nKkHCIgItjBLn/rmAzGQWuM0ocWXmElaQ
        GmEBd4l9/60hdp1llFi++xXYHE4BJ4mXkzcyTWAUmIXk1FkIp85CcuoCRuZVjJKpBcW56bnF
        RgWGeanlesWJucWleel6yfm5mxiBMbTtsFbfDsb7S+IPMQpwMCrx8M7g+hwlxJpYVlyZe4hR
        goNZSYT3cTxQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6p
        BsaIVVqnDzLPl0h2/co7oePepRnHNV+ErNLeJrXo0t6stUu9GN0WLnmjtCN3/Qof8XCVI63r
        aie82f9b9ovQKZk5+14lqU5KnPUuVizI+Oy7Ky7MX1d7r3fKKWUvct1yImGtymyLVSFXdZgW
        a7ybJ7z6wI+frT+PX2Zf5Tbjrv2+jMz27YzM667sUmIpzkg01GIuKk4EAJk9HDSdAgAA
X-CMS-MailID: 20180510011455epcas1p116094cde74772c816f7c1c3fe1e7f9bb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509125837epcas1p2fb18921a0c7f25e277e795c290a824d6
X-RootMTR: 20180509125837epcas1p2fb18921a0c7f25e277e795c290a824d6
References: <20180509125749.31318-1-enric.balletbo@collabora.com>
        <CGME20180509125837epcas1p2fb18921a0c7f25e277e795c290a824d6@epcas1p2.samsung.com>
        <20180509125749.31318-7-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 09일 21:57, Enric Balletbo i Serra wrote:
> Fix some spelling mistakes in error and debug messages.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4:
> - [6/6] Introduce this new patch that fixes some spelling.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/devfreq/rk3399_dmc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
