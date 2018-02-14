Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031050AbeBNO7N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:59:13 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:60315 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030648AbeBNO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:59:10 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180214145908epoutp0264555b57cdc84e54039db76954f5bea0~TOSkitlKL2417024170epoutp02G
X-AuditID: b6c32a39-467ff70000000fc5-5f-5a844ebb0a42
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH v2] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <7fa753f3-dcea-2fec-de44-f7404851c7eb@samsung.com>
Date: Wed, 14 Feb 2018 15:58:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <5A820B19.8080902@samsung.com>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCmru5uv5Yogzf7mS02zljPanH9y3NW
        i/PnN7BbfOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4sfZ7pZHDg93t9oZfe43NfL5LFpVSeb
        R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGXMXb+AqWAiZ8WGA23MDYwn2bsYOTkkBEwkDuxe
        xtjFyMUhJLCDUWLn1MvMEM53RolvWx8zw1Ste/KIFSKxgVGi7+QEVpAEr4CgxI/J91hAbGYB
        TYkXXyaxQBTdZ5TYMXspWEJYIE7i07IWRhBbREBDYubfK2D7mAVuMEpcuXcSbBKbgKFE79E+
        RoipdhLfD18Ga2YRUJX4cfEhE4gtKhAhsXDqU7AaTgFtie2z7zFDbBaXOHb/JiOELS9x8Mpz
        sCskBJ6zSdw4eAjqBxeJhcd2MkLYwhKvjm8BhgAHkC0tcemoLUR9P6PEx+P7oZpXM0q8/raL
        FaLBWuLw8YusEBv4JN597WGFaOaV6GgTgijxkPiy5jwbhO0o8a31G9hecHgtul8xgVFuFlKI
        zUIKsVlIfpiF5IcFjCyrGMVSC4pz01OLDQtM9YoTc4tL89L1kvNzNzGCU42W5Q7GY+d8DjEK
        cDAq8fAa2LRECbEmlhVX5h5ilOBgVhLhNT7fHCXEm5JYWZValB9fVJqTWnyIUZqDRUmcNyDA
        JUpIID2xJDU7NbUgtQgmy8TBKdXAKPrTlee2yuYlhqnvtyXUCR/QnfL24NIK2dOWisuXLb7L
        xO+rXLf+OauzyHlL5ZOxmp0MjwQL9P87z3n+Y929r7MaNm6f1v/Tc/diHaH8Wf/kFzT+FxWd
        W/B7FuOED+8KfzKwiKydF/ySOTCpOadyrfSdes59Dma77uXeWvLjxtatOeyidd03fZVYijMS
        DbWYi4oTATadOkAxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t9jQd1dfi1RBku3C1psnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jslh75C67xcVTrhY/znSzOHB6vL/Ryu5xua+XyWPTqk42
        j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4MqYu34BU8FEzooNB9qYGxhPsncxcnJICJhIrHvy
        iLWLkYtDSGAdo8S0N71sIAleAUGJH5PvsXQxcnAwC6hLTJmSC1HzkFHi3Jy9YM3CAnESn5a1
        MILYIgIaEjP/XmEEKWIWuMYo0fO7GywhJLCBUeLBb34Qm03AUKL3aB8jxAI7ie+HL7OA2CwC
        qhI/Lj5kArFFBSIkOlfOB4tzCmhLbJ99jxnEZhYQlzh2/yYjhC0vcfDKc5YJjAKzkNw6C+HW
        WUg6ZiHpWMDIsopRMrWgODc9t9iowDAvtVyvODG3uDQvXS85P3cTIzAuth3W6tvBeH9J/CFG
        AQ5GJR5eA5uWKCHWxLLiytxDjBIczEoivMbnm6OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ897O
        OxYpJJCeWJKanZpakFoEk2Xi4JRqYKz70/fL6cAkhac3N3peOncy+yt/8Z2Vtecucyy/lsfY
        x+iSpeSwas200izh9wZatq+0fjGJrH+pbnb179fGp2JOKfPyJOcd7vzuYhFsdCHWUoxRzDbu
        /O4/yTVVkqtXXX6jeuKq/reznV+V1n16k6LNq3qt5n7AjoT/24rXP+QJnRWUvyJAL1yJpTgj
        0VCLuag4EQCoZXJThwIAAA==
X-CMS-MailID: 20180214145906epcas1p2d2096ced0388b4622cfeb0bbd3858278
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3
X-RootMTR: 20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3
References: <CGME20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3@epcas2p3.samsung.com>
        <20180212155227.20605-1-s.nawrocki@samsung.com>
        <5A820B19.8080902@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 10:46 PM, Chanwoo Choi wrote:
> On 2018년 02월 13일 00:52, Sylwester Nawrocki wrote:
>> Add one more entry to the exynos5433_aud_pll_rates table, this allows
>> to support audio sample rates: 48000, 96000, 192000 Hz with minimum
>> error. The M, P, S, K values re confirmed by the HW team.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5433.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>> index ebd18586e325..b08a9028653f 100644
>> --- a/drivers/clk/samsung/clk-exynos5433.c
>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>> @@ -765,6 +765,7 @@ static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initcons
>>  	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
>>  	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
>>  	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
>> +	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
>>  	{ /* sentinel */ }
>>  };
> Looks good to me.
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks, patch applied to clk/samsung tree.
