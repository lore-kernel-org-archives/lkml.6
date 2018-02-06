Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeBFEGg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:06:36 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:23204 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeBFEG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:06:26 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180206040624epoutp01240dcfed9192ca3b27486a2feb5efcd5~QoOYjw6j40919809198epoutp019
X-AuditID: b6c32a46-3a9ff70000001029-a3-5a7929bf9020
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A7929C1.8040706@samsung.com>
Date: Tue, 06 Feb 2018 13:06:25 +0900
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
In-reply-to: <20180205142230.9755-2-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c7Z5UxanpbWxwJbB4pcbbnj7VTa1WKUxSqKWMQ86Mcm7iI7
        85ZBkpmx7iRdRNLK/mgU4bTQzFa6sKul0hTNgUhrpaRWlhRdtp2i/nve9/19D9/78BK4rFwk
        J3KtDmS3smZKFCW43RHPqDzxJfqElsdKpuH8TSHjHvEJmcljfiHTe6dGxJx/cQ9jbniHxEz3
        kw1Mx1ilkJl+dlSwRqId768Qa3tPHMe0jfUHtCeaXED7yR2nE+pRmgmxOciuQNZsW06u1ZhO
        bd5hWG9ITknQqDTLmVRKYWUtKJ3KyNSpNuaaQ9+hFIWsuSDU0rEcRy1blWa3FTiQwmTjHOnU
        Ho2GVmsSUtU0TauTEveuoJNDSBYy9Y9exvOnFMVna04Ky0CH3AkkBCSTYHdbL+YEUYSMbAbw
        7Z02IV98BdB5aBD/S034pnB+0ArgVNUFLDyQkrPg9Bm/wAkIAifnQ29PXriNk/HwVutNMc/7
        AWx6GhDzvBL2dwVAWAvIhfBy0BfxEYX6nmC/KKyjyQXw1fRIhIkld8OW2i/isH8MuQleLFOF
        PXGyB8DB8UoQ7s8OMa+fK8O4hFwJJx+6IgtAclAEr79pizCQzIDNtUp+l9nwfWeTmNfzYMDV
        AHi+EsDKtos4X1QB2NXnx3gqEQYuOTF+s5nwSMcPMW8qhUcOy3hEC489qhPwei2se3zwz/Ie
        AAd+dWKnQFz1f3lV/8ur+r+86gDuAnNQPmcxIo7Op9Uca+EKrEZ1ts3iBpEDVG5sBvVdme2A
        JAA1Q0qaivUyIVvIlVjaASRwKka6rq9IL5PmsCX7kN1msBeYEdcOkkNxn8blsdm20DlbHQZN
        0vKEpJQUOjWFCR3YXGmFLkMvI42sA+UhlI/sf99hhEReBrxjIolZGT2kHn1wtQvVdg7/zN6+
        9dYSn8TY9KH8rsf/gDjzfHybmx2WKPps3xPjG75ldQZ3qlZ/rFi7NGP/WFX9cWdjsMgV0HnX
        3b8xv2Voy3DQ0419bpy4cqjQ8JLOvH96oLR08bfy6AVl54xnFd5Va3alLX0nX+TyuXOuRY/X
        UgLOxGqUuJ1jfwNJ5kpAlgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jAd39mpVRBrtviFtsnLGe1WLT42us
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2VosfZ7pZHDg93t9oZfe43NfL5LF5Sb1H
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZdx4vYi54KtCxbQ5/awNjIeluhg5OSQETCQ+XPvK
        3MXIxSEksJNR4nRTOxNIgldAUOLH5HssXYwcHMwC8hJHLmWDhJkF1CUmzVsEVf+AUWLC22+M
        EPVaEjfOPQOzWQRUJRa9uAY2hw0ovv/FDTYQm19AUeLqj8eMIDNFBSIkuk9UgpgiAl4S8xp0
        QUYyC1wCOmHjPlaQuDBQyZ2zWhCr9jNKnLh5H2wkp4C1xMejq1gnMArMQnLpLIRLZyG5dAEj
        8ypGydSC4tz03GKjAqO81HK94sTc4tK8dL3k/NxNjMDA33ZYq38H4+Ml8YcYBTgYlXh4BTIq
        ooRYE8uKK3MPMUpwMCuJ8DpdL48S4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1
        OzW1ILUIJsvEwSnVwOi3b36c0QXxxO9v4xwsNj7p2CPeEMj45lDJPaNwvSJNRn++W5f1M69u
        SxbWuvlt7Z5Cw5p3kgZvl7uVxMayvnxzba/r9N31+4VKRKzPih1w7Lv8VMksWHfDJ7+77o/f
        O947k2m/oHbOi6vb53aKh/Roas0r1zint2XmPoVV71m73QVayoR1niuxFGckGmoxFxUnAgBV
        2quUeAIAAA==
X-CMS-MailID: 20180206040623epcas2p40600e2fab4644d87ef8de0e0cfea75a3
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
X-RootMTR: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
        <20180205142230.9755-2-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 2018년 02월 05일 23:22, Sylwester Nawrocki wrote:
> CLK_SET_RATE_PARENT flag is added to definitions of clocks on a path
> starting from CLK_SCLK_I2S1 up to AUD_PLL in order to allow setting
> required audio root clock frequency for the I2S1 block. This is now
> only done for the I2S1 block, related CMU_TOP, CMU_PERIC clock
> definitions are changed.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index 74b70ddab4d6..d74361736e64 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
>  
>  static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>  	/* MUX_SEL_TOP0 */
> -	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
> -			4, 1),
> +	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
> +	      4, 1, CLK_SET_RATE_PARENT, 0),

If you add CLK_SET_RATE_PARENT to 'mout_aud_pll' and mout_aud_pll changes the rate,
fout_aud_pll's rate will be changed. But, fout_aud_pll is also the parent
of 'mout_aud_pll_user'. It might change the rate of children of mout_aud_pll_user.
mout_aud_pll_user would not want to change the parent's clock.

    fout_aud_pll                          2            2   196608009          0 0  
       mout_aud_pll_user                  1            1   196608009          0 0  
       mout_aud_pll                       0            0   196608009          0 0  


>  	MUX(CLK_MOUT_ISP_PLL, "mout_isp_pll", mout_isp_pll_p, MUX_SEL_TOP0,
>  			0, 1),
>  
>  	/* MUX_SEL_TOP1 */
> -	MUX(CLK_MOUT_AUD_PLL_USER_T, "mout_aud_pll_user_t",
> -			mout_aud_pll_user_p, MUX_SEL_TOP1, 12, 1),
> +	MUX_F(CLK_MOUT_AUD_PLL_USER_T, "mout_aud_pll_user_t",
> +	      mout_aud_pll_user_p, MUX_SEL_TOP1, 12, 1, CLK_SET_RATE_PARENT, 0),
>  	MUX(CLK_MOUT_MPHY_PLL_USER, "mout_mphy_pll_user", mout_mphy_pll_user_p,
>  			MUX_SEL_TOP1, 8, 1),
>  	MUX(CLK_MOUT_MFC_PLL_USER, "mout_mfc_pll_user", mout_mfc_pll_user_p,
> @@ -370,8 +370,8 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>  			MUX_SEL_TOP_PERIC1, 16, 1),
>  	MUX(CLK_MOUT_SCLK_SPDIF, "mout_sclk_spdif", mout_sclk_spdif_p,
>  			MUX_SEL_TOP_PERIC1, 12, 2),
> -	MUX(CLK_MOUT_SCLK_AUDIO1, "mout_sclk_audio1", mout_sclk_audio1_p,
> -			MUX_SEL_TOP_PERIC1, 4, 2),
> +	MUX_F(CLK_MOUT_SCLK_AUDIO1, "mout_sclk_audio1", mout_sclk_audio1_p,
> +			MUX_SEL_TOP_PERIC1, 4, 2, CLK_SET_RATE_PARENT, 0),
>  	MUX(CLK_MOUT_SCLK_AUDIO0, "mout_sclk_audio0", mout_sclk_audio0_p,
>  			MUX_SEL_TOP_PERIC1, 0, 2),
>  
> @@ -524,12 +524,12 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
>  			DIV_TOP_PERIC2, 0, 4),
>  
>  	/* DIV_TOP_PERIC3 */
> -	DIV(CLK_DIV_SCLK_I2S1, "div_sclk_i2s1", "sclk_audio1",
> -			DIV_TOP_PERIC3, 16, 6),
> +	DIV_F(CLK_DIV_SCLK_I2S1, "div_sclk_i2s1", "sclk_audio1",
> +			DIV_TOP_PERIC3, 16, 6, CLK_SET_RATE_PARENT, 0),
>  	DIV(CLK_DIV_SCLK_PCM1, "div_sclk_pcm1", "sclk_audio1",
>  			DIV_TOP_PERIC3, 8, 8),
> -	DIV(CLK_DIV_SCLK_AUDIO1, "div_sclk_audio1", "mout_sclk_audio1",
> -			DIV_TOP_PERIC3, 4, 4),
> +	DIV_F(CLK_DIV_SCLK_AUDIO1, "div_sclk_audio1", "mout_sclk_audio1",
> +			DIV_TOP_PERIC3, 4, 4, CLK_SET_RATE_PARENT, 0),
>  	DIV(CLK_DIV_SCLK_AUDIO0, "div_sclk_audio0", "mout_sclk_audio0",
>  			DIV_TOP_PERIC3, 0, 4),
>  
> @@ -693,7 +693,7 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
>  	GATE(CLK_SCLK_SLIMBUS, "sclk_slimbus", "mout_sclk_slimbus",
>  			MUX_ENABLE_TOP_PERIC1, 16, 0, 0),
>  	GATE(CLK_SCLK_AUDIO1, "sclk_audio1", "div_sclk_audio1",
> -			MUX_ENABLE_TOP_PERIC1, 4, 0, 0),
> +			MUX_ENABLE_TOP_PERIC1, 4, CLK_SET_RATE_PARENT, 0),
>  	GATE(CLK_SCLK_AUDIO0, "sclk_audio0", "div_sclk_audio0",
>  			MUX_ENABLE_TOP_PERIC1, 0, 0, 0),
>  };
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
