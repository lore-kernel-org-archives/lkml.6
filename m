Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeBIHgz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:36:55 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:45913 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeBIHgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:36:53 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180209073650epoutp03e235858be0e44ca7126a4ceef9c14715~RmB_Y3gXX2617426174epoutp03Q
X-AuditID: b6c32a45-3ebff70000001023-19-5a7d4f926234
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A7D4F92.100@samsung.com>
Date: Fri, 09 Feb 2018 16:36:50 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 2/3] clk: exynos5433: Allow audio subsystem clock rate
 propagation
In-reply-to: <3fcfad37-4c8f-7375-b2c2-5154607aa47a@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTcRjH+e3utiktz/Ptp0HaQYHW1nbpdlZmkcZQw0H9EavQQw8dutvY
        zdLIGkVOlq0sK5mliyJM0MoiVMhAjbLMTMssTQNlSET2Rq6w6M4r6r/n5fO8fXmUCHFEHqe0
        cE7WwTGlpDwUvdObqFefzq00a8c88fTN+usY3T49itGfaiYxeqTrgpyuf9oto1v73ijoZ48y
        6d73bowODhxHN4cY58aOKYwj3hMy460rh43e2y3A+KV9uQkzsxuLWaaQdSSwXIGt0MIVpZHZ
        O/K25qXotTq1LpU2kAkcY2XTyIwck3qbpVRYh0zYx5SWCSETw/Pk2k0bHbYyJ5tQbOOdaeRu
        nY7S6LQGDUVRmuR1e9dTKQKSzxaPuYMyuzemvLv7B+IC8+EeoFRCPBme9Gd5QKiSwDsAvHa9
        B5OceQCPBQNyDwhZhBY+vv6TuAFg1Y9hVEyo8HAYPDOJip0QPB72DZeIYQRPhLNfT6MSPyl0
        bf6skPhV0DffhIg8iq+Eb1stYliOJ8F7s2OLs8LwFfBFcBqIdhS+C3Y2fVOIeCSeBRtdarEl
        gg8DOD7nBmI8QmAmniSJeAieDgNXxEmhwspTcvhtZlAm7Z8B22YvY5IdAd89uK2Q7GUw0HIT
        SAVuAN13GxHJqQNw8OXkn+p1MHDJI5MuWwqre38qJOlUsLqKkBAjrHnoRyV7C/T3H1FIx5+V
        wb6qJnAKLPf9p5fvn16+//TyA6QFRLN23lrE8pRdp+EZK1/GFWkKbNZ2sPh/SZkdoH4wpwfg
        SkAuUZ3ac9BMYMw+vsLaA6ASISNVQ9srzYSqkKk4wDpseY6yUpbvASmC3LVIXFSBTfhmzpmn
        S07VJuv1lEFPC/8Vo6oyZZgJvIhxsiUsa2cdf+tkypA4F/BSjuaFg+hMLTrSjF2dHtqQHTNB
        fL9H7Jyq9OcX2p/H1uREfRw4d7nJ2nv+8Ku6QI2WIlpm3xkMFeeiy6sbGtrDEsnxOVd4mLe+
        Mr92yQd439XWcP8iV9fVx/Wr0wdHLXSDybc/4/HR2F+HCLuqs4t7mW82r16W27p6TWZgPYny
        xYwuCXHwzG/VhDDVlQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t9jQd1J/rVRBo0tPBYbZ6xntdj0+Bqr
        xceee6wWl3fNYbOYcX4fk8XaI3fZLS6ecrU4/Kad1eLHmW4WB06P9zda2T0u9/UyeWxeUu/R
        t2UVo8fnTXIBrFFcNimpOZllqUX6dglcGTfafzAV9IlX7Nv3i7mB8btgFyMnh4SAicSfD7dY
        uxi5OIQE1jFKvNrRwgaS4BUQlPgx+R5LFyMHB7OAvMSRS9kQprrElCm5IBVCAg8YJQ4v8Yeo
        VpOY9X0+M0gJi4CqxIO1mSBhNgEtif0vboAN5BdQlLj64zEjSImoQIRE94lKEFNEwEtiXoMu
        yH5mgUuMEqc37mMFiQsDldw5qwVx12QmiRebfjKBjOEUsJd4tuQT+wRGgVlIzpyFcOYshDMX
        MDKvYpRMLSjOTc8tNiowykst1ytOzC0uzUvXS87P3cQIDPhth7X6dzA+XhJ/iFGAg1GJh/dF
        XE2UEGtiWXFl7iFGCQ5mJRHeC761UUK8KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeW
        pGanphakFsFkmTg4pRoYZ+/p+rV8/WMvlUL+hgvOKZqrOe+cvCS5ekrSksffpy6dfNh/oulz
        g6pTPS9vGZYKcikrOH54r/JT71P+lGsfFrU6/jw4TSF2T79W9zrFyqWOxS+fZNvGTX7s5X33
        8ubDU0trv2peEpM/VdQdpLNhpcWPhumXVa/8XzFTmkmn613rSievlQs3iymxFGckGmoxFxUn
        AgArlXb1dAIAAA==
X-CMS-MailID: 20180209073650epcas2p1d8f5693798e259fedd1816ba020e4646
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
X-RootMTR: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
        <20180205142230.9755-2-s.nawrocki@samsung.com>
        <5A7929C1.8040706@samsung.com>
        <3fcfad37-4c8f-7375-b2c2-5154607aa47a@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 2018년 02월 08일 00:18, Sylwester Nawrocki wrote:
> Hi Chanwoo,
> 
> On 02/06/2018 05:06 AM, Chanwoo Choi wrote:
>>>  drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>>> index 74b70ddab4d6..d74361736e64 100644
>>> --- a/drivers/clk/samsung/clk-exynos5433.c
>>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>>> @@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
>>>  
>>>  static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>>>  	/* MUX_SEL_TOP0 */
>>> -	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>> -			4, 1),
>>> +	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>> +	      4, 1, CLK_SET_RATE_PARENT, 0),
>>
>> If you add CLK_SET_RATE_PARENT to 'mout_aud_pll' and mout_aud_pll changes the rate,
>> fout_aud_pll's rate will be changed. But, fout_aud_pll is also the parent
>> of 'mout_aud_pll_user'. It might change the rate of children of mout_aud_pll_user.
>> mout_aud_pll_user would not want to change the parent's clock.
>>
>>     fout_aud_pll                          2            2   196608009          0 0  
>>        mout_aud_pll_user                  1            1   196608009          0 0  
>>        mout_aud_pll                       0            0   196608009          0 0  
> 
> I'd say the range of changes is such that the consumers of the affected child 
> clocks can cope and could adjust to the changed frequencies. Those consumer 
> devices are all components/peripherals of the audio subsystem (LPASS) and, 

The mout_aud_pll_user has the child clock of serial_3.
serial_3 was used for bluetooth on TM2. If you change the aud_pll
with CLK_SET_RATE_PARENT, it might affect the bluetooth operation.
The bluetooth is only used for transfering the data.

Actually, I'm not sure that this patch might affect bluetooth operation or not.

> for example, in case of TM2 there is no issues at all with varying the AUD PLL
> frequency depending on the HDMI audio sample rate. The other audio path uses
> the audio CODEC's internal PLL as the root clock source. The AUD PLL frequency
> will need to be adjusted somehow anyway, we could also get the PLL clock 
> directly and set it's rate, instead of relying on that rate propagation 
> algorithm.  I think we could also export a function from the exynos-lpass mfd 
> driver for setting the PLL's rate directly, after listing the AUD PLL clock 
> in the lpass DT node. That would be more flexible API, easier to adopt for 
> various use cases/boards, now we have only TM2. I can't list the PLL clock 
> in the sound node, that would not have passed the DT maintainters' review. 
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
