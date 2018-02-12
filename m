Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeBLLqF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:46:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:36779 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934152AbeBLLqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:46:01 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180212114559epoutp0183f7037be3533677d50b6d3601f8a2bb~SkXXV1UiJ2075220752epoutp01C
X-AuditID: b6c32a38-adbff70000001054-6f-5a817e76c496
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH 2/3] clk: exynos5433: Allow audio subsystem clock rate
 propagation
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <e0d88ac2-439b-8e6e-af32-310b53ca0693@samsung.com>
Date: Mon, 12 Feb 2018 12:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <5A7D4F92.100@samsung.com>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmvm5ZXWOUwZVeKYuNM9azWlz/8pzV
        YtPja6wWH3vusVpc3jWHzWLG+X1MFmuP3GW3uHjK1eLHmW4WB06P9zda2T0u9/UyeWxeUu/R
        t2UVo8fnTXIBrFFcNimpOZllqUX6dglcGbvumhVcEam4drKLpYFxqkAXIyeHhICJxP3WRexd
        jFwcQgI7GCVOdZ9jgXC+M0o0PHjHCFP17d1XJojEbkaJJxf3soIkeAUEJX5MvscCYjMLaEq8
        +DIJqvs+UFHnKaAODg5hgQiJO2e1QGpEBJwlFly6ywhSwyxwiVHi9vt2sA1sAoYSvUf7GCGG
        2klsWbYUbCiLgKpE29/pYLYo0JyFU58ygszkFFCXeHJTFmKvuMSx+zcZIWx5iYNXnrNAHH2f
        TeLZE3UI20Xi+5b5bBC2sMSr41vYQcZICEhLXDpqC3KOhEA/o8TH4/tZIJzVjBKvv+1ihWiw
        ljh8/CIrxAI+iXdfe1ghmnklOtqEIEo8JHpOLIDa6yix4GQTNEg3MUk837WVaQKj3Cyk8JqF
        FF6zkPwwC8kPCxhZVjGKpRYU56anFhsWmOgVJ+YWl+al6yXn525iBKcYLYsdjHvO+RxiFOBg
        VOLhdahuiBJiTSwrrsw9xCjBwawkwjszqjFKiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9AgEuU
        kEB6YklqdmpqQWoRTJaJg1OqgVHulofyYoermeI71joEN1lmcL6dvqhQ9M4uVtMTbQK318zg
        leQ6PsX+85PN6zj0T12sTdprnCN5VMvPfYLjZa3/C7bfqp3H2vzyYKyq2v1AZmVPib8816P+
        W2y+8a0xxu36jd1Lrm97zhMhY+eyYOuqMwZ9U3Oz3y8vaexdHHT06LKybwE79U8rsRRnJBpq
        MRcVJwIAHUEwzS0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t9jAd3SusYog94lFhYbZ6xntbj+5Tmr
        xabH11gtPvbcY7W4vGsOm8WM8/uYLNYeuctucfGUq8WPM90sDpwe72+0sntc7utl8ti8pN6j
        b8sqRo/Pm+QCWKO4bFJSczLLUov07RK4MnbdNSu4IlJx7WQXSwPjVIEuRk4OCQETiW/vvjJ1
        MXJxCAnsZJS4O3keO0iCV0BQ4sfkeyxdjBwczALqElOm5ELUPGSUmPrkFytIXFggQuLOWS2Q
        chEBZ4kFl+4ygtQwC1xilDi9cR8rRMM6JolvTQsZQarYBAwleo/2MUIssJPYsmwpC4jNIqAq
        0fZ3OpgtCjS0c+V8sMWcQIuf3JQFCTMLiEscu3+TEcKWlzh45TnLBEaBWUhOnYVw6iwkHbOQ
        dCxgZFnFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYEdsOa/XtYLy/JP4QowAHoxIP
        r0N1Q5QQa2JZcWXuIUYJDmYlEd6ZUY1RQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJI
        TyxJzU5NLUgtgskycXBKNTBmSr05njjhR7O/z6uauf/85RMvrjTrZb8383f6xbata2eH/pF8
        c/BUvZLb1daE8GVOJR/u3pO6HTq9ZSLTp+D79yYpCCuIGE5+bCtTciE16gSH1H2BdzklhkEz
        D4q5/I1wWHCnMblri4iYC1NUxC7GHsbbFguY8yUPPc1Rf2O6ZG6s6D2O8J9KLMUZiYZazEXF
        iQAuOr1VhAIAAA==
X-CMS-MailID: 20180212114557epcas1p4d53c55192b5ee150ca99d715599ce8d0
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
X-RootMTR: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
        <20180205142230.9755-2-s.nawrocki@samsung.com>
        <5A7929C1.8040706@samsung.com>
        <3fcfad37-4c8f-7375-b2c2-5154607aa47a@samsung.com>
        <5A7D4F92.100@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 02/09/2018 08:36 AM, Chanwoo Choi wrote:
> On 2018년 02월 08일 00:18, Sylwester Nawrocki wrote:
>> On 02/06/2018 05:06 AM, Chanwoo Choi wrote:
>>>>  drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
>>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>>>> index 74b70ddab4d6..d74361736e64 100644
>>>> --- a/drivers/clk/samsung/clk-exynos5433.c
>>>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>>>> @@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
>>>>  
>>>>  static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>>>>  	/* MUX_SEL_TOP0 */
>>>> -	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>>> -			4, 1),
>>>> +	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>>> +	      4, 1, CLK_SET_RATE_PARENT, 0),
>>> If you add CLK_SET_RATE_PARENT to 'mout_aud_pll' and mout_aud_pll changes the rate,
>>> fout_aud_pll's rate will be changed. But, fout_aud_pll is also the parent
>>> of 'mout_aud_pll_user'. It might change the rate of children of mout_aud_pll_user.
>>> mout_aud_pll_user would not want to change the parent's clock.
>>>
>>>     fout_aud_pll                          2            2   196608009          0 0  
>>>        mout_aud_pll_user                  1            1   196608009          0 0  
>>>        mout_aud_pll                       0            0   196608009          0 0  
>> I'd say the range of changes is such that the consumers of the affected child 
>> clocks can cope and could adjust to the changed frequencies. Those consumer 
>> devices are all components/peripherals of the audio subsystem (LPASS) and, 
>
> The mout_aud_pll_user has the child clock of serial_3.
> serial_3 was used for bluetooth on TM2. If you change the aud_pll
> with CLK_SET_RATE_PARENT, it might affect the bluetooth operation.
> The bluetooth is only used for transfering the data.
> 
> Actually, I'm not sure that this patch might affect bluetooth operation or not.

You are right, the AUD PLL frequency adjustments would break the bluetooth's 
operation. I double checked and in the downstream kernel only one AUD PLL 
frequency can be set - 196608009. So I will drop this patch and add just
a single PLL_36XX_RATE() entry for that frequency, the PMS values have been
confirmed by the HW team. Only 48000/9600/192000 sample rates will then be 
supported natively and others could be through software rate conversion.

-- 
Regards,
Sylwester
