Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeBIHZe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:25:34 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38645 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeBIHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:25:31 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180209072529epoutp0371a02273572343b1ce5c6e85d8de2f2a~Rl4EDZjVm1605116051epoutp03Z
X-AuditID: b6c32a45-403ff70000001023-c4-5a7d4ce97b61
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A7D4CE9.6070900@samsung.com>
Date: Fri, 09 Feb 2018 16:25:29 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
In-reply-to: <086b44d2-6556-fa7c-1a5b-01c243bf0682@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTVPelT22Uwa0PfBYbZ6xntdj0+Bqr
        xceee6wWl3fNYbOYcX4fk8XaI3fZLS6ecrU4/Kad1eLHmW4WB06P9zda2T0u9/UyeWxeUu/R
        t2UVo8fnTXIBrFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
        AbpumTlA5ygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N9AwNzPWMjIz0TIxjrYxM
        gUoSUjM+nDvAWrCPteLSyqNMDYzzWboYOTgkBEwkHj3K72Lk4hAS2MEo8f56LzuE851R4nVb
        KxtM0ZRjIhDx3YwSE56cA2rm5OAVEJT4Mfke2CBmAXmJI5eyQcLMApoSL75MYoGov8co8fDy
        fKh6LYmWvcvZQWwWAVWJOdf3M4PYbEDx/S9usIHY/AKKEld/PGYEsUUFIiR2zv8GVi8ioC+x
        ZNVFNpChzAJvGSXWn5oE1iwsEC+x7+FJsCJOAXuJQz/fgzVLCNxmk2j9FwBhu0hc71/EAmEL
        S7w6voUdwpaWeLZqIyPIUAmBdkaJ9r3zmCGcKYwS567fY4KoMpZ4trCLCeI3PomOw3/ZIcHC
        K9HRJgRR4iHx5dx0VgjbUeL9vwVQ7+9ikpjw9AXjBEa5WUghNgsRYrOQQmwBI/MqRrHUguLc
        9NRiowJDveLE3OLSvHS95PzcTYzgBKjluoNxxjmfQ4wCHIxKPLwTYmqihFgTy4orcw8xSnAw
        K4nw5pnURgnxpiRWVqUW5ccXleakFh9iNAUG+ERmKdHkfGByziuJNzSxNDAxMzMyN7MAJjBx
        3rYAlyghgfTEktTs1NSC1CKYPiYOTqkGRr4SgfNnCrYE/fvrtqDfIWNd0UVZzc9rBET95hnw
        y/MofQ2sbAmdvtTDJdAvjbl10YkZJoJslv5Nck9e3l+9aQmb4u2sp3csGVr9xf6XvPudLrlu
        wvTkWe8jBYv3/s+OMIj5vlZR6/R3Tt2Wcyts5T6ueuIetmfajcwplp/ypfakGefslnbjUmIp
        zkg01GIuKk4EAODRioWWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t9jAd0XPrVRBhsOaVtsnLGe1WLT42us
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2VosfZ7pZHDg93t9oZfe43NfL5LF5Sb1H
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZXw4d4C1YB9rxaWVR5kaGOezdDFycEgImEhMOSbS
        xcjFISSwk1Git2EGYxcjJwevgKDEj8n3wGqYBeQljlzKhjDVJaZMyYUof8AosX3HFCaIci2J
        lr3L2UFsFgFViTnX9zOD2GxA8f0vbrCB2PwCihJXfzxmBJkjKhAh0X2iEiQsIqAvsWTVRTaQ
        mcwCbxkl3qzcB9YrLBAvse/hSXaIZbuYJKb3TQa7jVPAXuLQz/eMExgFZiE5dRbCqbMQTl3A
        yLyKUTK1oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMw7Lcd1urfwfh4SfwhRgEORiUe3hdx
        NVFCrIllxZW5hxglOJiVRHjzTGqjhHhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJ
        zU5NLUgtgskycXBKNTA2XGJn0xQ5Ir0gctOR1qgKNa+r+Xn2n3XaFFa+uVGZFnnJfNvpDsX/
        E6wEfnxbX3r9yn+F7Rt9rx6eOyV9rqDe/9ylfXdsPu+pb/8/9fHs6R9KZ8vodHdU+XTtOm1b
        1dtwutZrrj7fnfSfu+WlFdI5xc3mGffKsL18uL9Q6mv+3R9yi+7NLFygxFKckWioxVxUnAgA
        JKhEX3cCAAA=
X-CMS-MailID: 20180209072528epcas2p3f61251be066e88db396aae558177a136
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
X-RootMTR: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
        <20180205142230.9755-1-s.nawrocki@samsung.com>
        <5A7916A2.7010307@samsung.com>
        <75cac4e7-9bbb-e591-36a1-dcacc3f94ace@samsung.com>
        <5A7AE1E0.8000509@samsung.com>
        <086b44d2-6556-fa7c-1a5b-01c243bf0682@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 07일 22:04, Sylwester Nawrocki wrote:
> On 02/07/2018 12:24 PM, Chanwoo Choi wrote:
>> Could you share your equation?
>> because your result is a little bit different of my result.
>> - my equation : ((mdiv + kdiv/65535) x 24MHz) / (pdiv x POWER(2,sdiv))
> 
> It resembles the code from samsung_pll36xx_recalc_rate():
> 
> (24 * 10^6 * (M * 2^16 + K)) / (P * 2^S) / 2^16
> 
> and a more accurate one
> 
> ROUNDDOWN(ROUNDDOWN(24 * 10^6 * (M * 2^16 + K), 0) / ROUNDDOWN(P * 2^S, 0) / 2^16, 0)
> 
> Shouldn't you substitute 65535 with 65536?

65536 is right. It is my mistake using 65535.
Thanks for your share.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
