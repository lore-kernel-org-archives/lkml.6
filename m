Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeEBKFj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:05:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55405 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeEBKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:05:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502100532euoutp02eb24b1050ba8b72620f51f60ab3754d2~qy9NP4vsC2975429754euoutp020
X-AuditID: cbfec7f4-6f9ff700000043e4-d6-5ae98d6b47d5
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] thermal: exynos: remove unused defines for
 Exynos5433
Date: Wed, 02 May 2018 12:05:30 +0200
Message-id: <22436608.hx2xeEDBlI@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501110434.GN27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7rZvS+jDI4/5rKY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvj/NM3rAU3mSu+tP9gb2D8wdTFyMkhIWAiseTPD7YuRi4OIYEVjBK7rx5ngXA+M0ps
        O36GuYuRA6zq9E4RiPgyRokFj54wQTi/GSUuXpzGDjKKTcBKYmL7KkYQW0RAT6LxfRtYEbPA
        KkaJ/k/vmEAmCQsESaxvrwOpYRFQlehY1sIGYvMKaEksO9sC1isq4CWxZV872HmcApoSj3rn
        M0PUCEr8mHyPBcRmFpCX2Ld/KiuErSNx9tg6Roh31rBJHHsbBXG0i8T6A1BfCku8Or6FHcKW
        kejsOAh2moRAM6PEtx17mCESExgl9qwXgrCtJQ4fvwg1n09i0rbp0IDglehogyrxkLg24wTU
        TEeJxs2f2eBhsmXnFpYJjLKzkJw9C8nZs5CcvYCReRWjeGppcW56arFRXmq5XnFibnFpXrpe
        cn7uJkZgOjj97/iXHYy7/iQdYhTgYFTi4TXIexElxJpYVlyZe4hRgoNZSYR3ZcezKCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQZGyd/NE20XPvALP13x
        krPYrZ/pXMCaDzrpwZPbKye+urSapV/0pnf3qTX1yl4TXO35Z/6WP3bw/PszNxtO5kdOWbZ7
        xYQFHOwLO8znv8ly+vP0kV/W/bXCfzdbPhGeN7H8m5JL//Hm13MWXtyyI+qE6g6vXedYe+5e
        NNwntKmWbVnj3q+Bf9ewdCuxFGckGmoxFxUnAgCeeQB9AwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xq7pZvS+jDCb3aVvM+yxrMf/KNVaL
        y7vmsFl87j3CaDHj/D4miycP+9gc2Dx2zrrL7rF4z0smjzvX9rB5fN4kF8ASxWWTkpqTWZZa
        pG+XwJVx/ukb1oKbzBVf2n+wNzD+YOpi5OCQEDCROL1TpIuRi0NIYAmjxNy1F9ghnL+MEld3
        PWPtYuTkYBOwkpjYvooRxBYR0JNofN/GBFLELLCKUWJlay8zSEJYIEDi76mJLCA2i4CqRMey
        FjYQm1dAS2LZ2RawZlEBL4kt+9qZQGxOAU2JR73zmSG2LWeU+H17JhNEg6DEj8n3wAYxC8hL
        7Ns/lRXC1pJYv/M40wRG/llIymYhKZuFpGwBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
        wMDdduzn5h2MlzYGH2IU4GBU4uE1yHsRJcSaWFZcmXuIUYKDWUmEd2XHsygh3pTEyqrUovz4
        otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjCJ5BjwsZ+7qc8pLq2+vFr0T
        4B6oWTPJfe5MlwevA1gFs9TSPoZcEf2mYs1VGLJvqunHpMAH9+2z8mZX9GhUPHlle1C8cceR
        X6pFMvse8dlb/pZLPyu6+rbs4TUXymenl/Pv8VwmW/qBZ+5FxdsCtj82rHOyYspqqPkZoVGd
        8sNkruZ5Jbn/SizFGYmGWsxFxYkANFL8VFgCAAA=
X-CMS-MailID: 20180502100530eucas1p180d0b51059ca8002ffe9440810391e9a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502100530eucas1p180d0b51059ca8002ffe9440810391e9a
X-RootMTR: 20180502100530eucas1p180d0b51059ca8002ffe9440810391e9a
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-18-git-send-email-b.zolnierkie@samsung.com>
        <20180501110434.GN27619@mai>
        <CGME20180502100530eucas1p180d0b51059ca8002ffe9440810391e9a@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 01:11:20 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Remove unused defines for Exynos5433.
> 
> I agree to remove these macros but is there a place with the documentation for
> those values if we need to put them back ?

They can be always resurrected from git repo if needed.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
