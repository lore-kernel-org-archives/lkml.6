Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934966AbeEJIhN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:37:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58752 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934266AbeEJIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:37:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180510083707euoutp02f34aa82414fce2bdfbb584dbb43c617f~tO6TRZGOy1597915979euoutp02Y
X-AuditID: cbfec7f5-f95739c0000028a9-df-5af404b04e0b
Subject: Re: [PATCH 1/2] i2c: exynos5: remove some dead code
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b3915e40-895f-2a72-27a2-dcffe504456d@samsung.com>
Date: Thu, 10 May 2018 10:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509194532.28929-1-peda@axentia.se>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+++cbWejyXFavqgkTaIbaZbCAW99KFoQoaIQY5anPKjk1HbU
        ssLmKp2r0AovzUoRwxRJm07UnJiFlyJvgTdEKZXM0g85yWu1s5Pkt4fn+b3v/33gT2Byq9Cd
        SEhKZbRJdKJCJMUbO1d6D9XhNtXhKhtB3dcXCai8qe8Y1ddXJ6bMU0NCyrBhQ9Snliciqriv
        TUBZO0oRVdVtwijrxCI6JlUWtpeIlebqXJHyWU+4sr7iprK76Beu7Hk/jSsXzbvCxCppUCyT
        mJDOaH1DYqTxd4YzUwolVysqw3UoT2xEEgJIf8jqXkZGJCXk5AsERcUNiAvkpA1BaU4MHywi
        mFmdQZsT9QXDYh6qRNDU6cdD8wjeDbc5IBcyCHIfFDggVzIUCoa+CTgII1sFUPuoU8gFInI/
        bNSPijgtI0NgzfjFPkwQOLkHmsc0nL2DPAv6rytiHnGGnsfTOKclZADoLesOjZFecMtSgvHa
        DcamSx1vATkohknrioDbCeRx6Nd58wVcYK6r4V99T/jTzPGcvg6js3qcnzUgmFzLEfFBILzt
        GhByezD7zbUtvrwdDAN3u0X8eicYmXfmT3CCh41FGG/LwJAt5+ndMPnRgvHaDZ73L4nykbdp
        SzHTljKmLWVM/98tQ3g1cmPSWE0cwx5NYq74sLSGTUuK87mYrDEj+6f68LtrqQm1rV/oQCSB
        FNtlxdJFlVxIp7MZmg4EBKZwlS332i1ZLJ1xjdEmn9emJTJsB/IgcIWb7Ny+TJWcjKNTmUsM
        k8JoN1MBIXHXISfPEnWpLe6Etib5ZbbsDHU6YDxq+ZQhEpf7O02n3MiCaHW5IgyhHwc9imMW
        VGWrZnY8wmvZKKneu0SFzpjXXAd/zlpara8/j8vdR8olO4NMkXMT+UeeRi9E+BQMBi6l6mt0
        r9QDlsv+7SfvpeoSbucE0+XqzOGGqG1qOuiNAmfjab8DmJal/wL0SDa1UAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7prWb5EGUxeZGDR2zSdyaL/8Wtm
        i/PnN7BbbHp8jdWi4+8XRovLu+awWcw4v4/JYu+h+YwWK0/MYrbYe+8zowOXx7QDs9k9Nq3q
        ZPOYdzLQY/OSeo8T07+zeJw89YTF4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2M1ut1BdM4K5YsD2xg7GfvYuTkkBAwkdg89TqYLSSw
        lFFi4aR6iLi4xO75b5khbGGJP9e62LoYuYBqXjNKtPxYywqSEBawkeicOBWsWUTAXmLqtZdM
        IEXMAvuYJJY3zGGGmNrBKHHsSTaIzSagKfF38002EJtXwE7id9cjxi5GDg4WAVWJnbdyQcKi
        AhES985/gioRlDg58wkLiM0pYCrRtPUPmM0soC7xZ94lZghbXqJ562woW1zi1pP5TBMYhWYh
        aZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzObcd+bt7BeGlj8CFG
        AQ5GJR7eGVyfo4RYE8uKK3MPMUpwMCuJ8P44BxTiTUmsrEotyo8vKs1JLT7EaAr020RmKdHk
        fGDiyCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwDjhodLjfCWe
        nR4+0ySvx565bNLl4SAk9PbnSr8bFkGTbt5uCppzn1vwknXD/ef595Yn2oe4Ciz8OvPcAQf3
        Ey/Ob496eZKvzLnR9+2kK2sZrGe6pa3Yftj4ydm4FOW0Q9dl9e1zD3g1ypTOUja3KGkKb06e
        WFHx57tWqVDQ28q4VcdTIxh6PyqxFGckGmoxFxUnAgAsysyi5AIAAA==
X-CMS-MailID: 20180510083702eucas1p2c6a0c9b25b46ef2c579450759ff2a896
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180510083702eucas1p2c6a0c9b25b46ef2c579450759ff2a896
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180509194548epcas2p25579e969e21707afe2435b1f568ff005
X-RootMTR: 20180509194548epcas2p25579e969e21707afe2435b1f568ff005
References: <CGME20180509194548epcas2p25579e969e21707afe2435b1f568ff005@epcas2p2.samsung.com>
        <20180509194532.28929-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.2018 21:45, Peter Rosin wrote:
> The else branch cannot be taken as i will always equal num.
> Get rid of the whole construct.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/busses/i2c-exynos5.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index 12ec8484e653..a2cbc779c33a 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -727,17 +727,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>  			goto out;
>  	}
>  
> -	if (i == num) {
> -		ret = num;
> -	} else {
> -		/* Only one message, cannot access the device */
> -		if (i == 1)
> -			ret = -EREMOTEIO;
> -		else
> -			ret = i;
> -
> -		dev_warn(i2c->dev, "xfer message failed\n");
> -	}
> +	ret = num;
>  
>   out:
>  	clk_disable(i2c->clk);

You can go further and remove "out:" label, use break instead, and at
the end use "return (i == num) ? num : ret;" or sth similar.

With this change you can add:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
