Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EF82089F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d9YBINQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfBRAfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:35:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:34777 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfBRAfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:35:04 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190218003501epoutp01f4b6b678765bd06b1dad09325f8896b4~ETicPEkJX1387313873epoutp01J
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:35:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190218003501epoutp01f4b6b678765bd06b1dad09325f8896b4~ETicPEkJX1387313873epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550450101;
        bh=kt92MKYao0ua5UEjTusIy1ELa/itcGRUBvaadkv/PDM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d9YBINQsLywZGEXi/jW+kPfgSZDGZjajHGyPk+qio++RL2lHanMfd9D7iHo7wWnd0
         Nhhl5/yTSXzXIu17upT9aXZI/fFqoUWZRmD4nbSHURC9nWaukeAoQETiGDmKK+JsC7
         5IIpcmWobYhVG2uFtwZcJ4dihqTD0HYQqt8FtlN0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190218003458epcas1p3f6f2fc9827780e5534520acb61eaf90f~ETiZjhQab0296202962epcas1p3W;
        Mon, 18 Feb 2019 00:34:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.D4.04069.2BDF96C5; Mon, 18 Feb 2019 09:34:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190218003457epcas1p11d8c26022f11c1cbb86633164aa87e14~ETiZB7UeM0621106211epcas1p15;
        Mon, 18 Feb 2019 00:34:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190218003457epsmtrp1ad965ac915eaad0119da8627e5f82290~ETiZAn2NH0256802568epsmtrp1Q;
        Mon, 18 Feb 2019 00:34:57 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-c1-5c69fdb21ee2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.37.03971.1BDF96C5; Mon, 18 Feb 2019 09:34:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190218003457epsmtip1bccfd951888e9b775d6b2ab05e1aa020~ETiYvf6U40754207542epsmtip1b;
        Mon, 18 Feb 2019 00:34:57 +0000 (GMT)
Subject: Re: [PATCH 1/3] PM / devfreq: rk3399_dmc: remove unneeded semicolon
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
Date:   Mon, 18 Feb 2019 09:34:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216151826.11584-2-tiny.windzz@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta2xLYRj27ZyenqF86rJXBXMYsWSXo7odbCK20LDEFn9EFnWsJ22z3vS0
        jREMs4vYEPdSwyzuG7WxLWQxi2YJ4rrIxOK2uC3FsLDFpu2p2L/nfb7n+d73+S40oWymVLTJ
        6hQcVt7MUMPJ63dmJyX4/phykx8PxHCDbz7LuCLPaZK7v71bzvnetsu4J03HKe57eSviel4N
        ElzZDw/Fvdh2juJ+N50gOW//XmrRCG2j56Vce+3MVm35jgClrai7gLQ32k8Q2u++KdnU6vw0
        o8DrBUesYM2z6U1WQzqzfKUuQ6dJSWYT2HlcKhNr5S1COpOZlZ2wxGQOjsfEunmzK0hl86LI
        JC1Mc9hcTiHWaBOd6Yxg15vt8+yJIm8RXVZDYp7NMp9NTp6jCQrX5htrOispezu14ea3e0Qh
        apTtQtE04LnQUtGIdqHhtBI3IKg+2ENJRQ+Cb3d9pFT0Iqh485D4Z/HfrCKkhVsIes+9j/i/
        IKi91EOGVGNxFrzuvB+2j8MnEdSUHZSHCgJXI/DeklQUjofmD8+pEB6Np8GzX29RCCvwQugs
        7Q+PSOI4aD3cFsbj8Sq4Ux6IaMZA29F3wX1oOhovAP/TZSGawDHQ8a4ySsJTYUf9sfCogPfL
        oSvQh6QMmXD04qHIEYyFT/46uYRV8HFPcQRvgvNtrZRkLkVQ1/wwYlBDc/X+qFBjAs+G2qYk
        qdkoCPzcLQvRgBVQWqyU1NPhyauXURKeCFUlZZSEtXC74al8L5rmGZLGMySCZ0gEz/9mJxF5
        AU0Q7KLFIIisXT30vn0o/HjjUxvQlQdZLQjTiBmp+Oo25SplvFsssLQgoAlmnOJ0b5BS6PmC
        jYLDpnO4zILYgjTBw95HqMbn2YJfwerUsZo5arWam8umaFiWiVHULsrIVWID7xTyBcEuOP75
        ouhoVSHa+bre6+7SNbUGHqlyGn6QS0cUddzzD149kFFy2bul25j6q4yepfezhrPDnAPKi+tm
        +euLCx/HlSzuXzOlu29SYde6TxPr3THe9ZUFNe8nDOtvS6CfTU7MZ+PiU86SjZNWHEnbvOXa
        ZW9mzkBVkepnUY5r3+KZpX237acedfgGZ8x4zpCikWfjCYfI/wW42Ftm0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnO7Gv5kxBjvu6Vv8f/Sa1aJl1iIW
        i7NNb9gtNj2+xmpxedccNovPvUcYLT49+M9s0fllFpvF7cYVbBY/d81jsZj7ewKbA7fHzll3
        2T02L6n36G1+x+bRt2UVo8f2a/OYPT5vkgtgi+KySUnNySxLLdK3S+DKWHdvPlvBNbaKPR/P
        MDcw7mTtYuTkkBAwkTi+ZzFzFyMXh5DAbkaJb39/sEEkJCWmXTwKlOAAsoUlDh8uhqh5yygx
        tWEuO0iNsICPxMN7Z1lAEiICCxgl/n58ATaVWWApo8T+N6wQHfsZJZq/zAHrYBPQktj/4gbY
        Bn4BRYmrPx4zgti8AnYS9zp+gzWzCKhKHJl+EswWFYiQ+Ph0HxNEjaDEyZlPWEAu4hSwljh+
        xQtil7rEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR7FpKWWUhaZiFpWcDIsopRMrWgODc9
        t9iwwDAvtVyvODG3uDQvXS85P3cTIzj+tDR3MF5eEn+IUYCDUYmH90NZZowQa2JZcWXuIUYJ
        DmYlEd5F34BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1
        MPZ8n/ZjfnCN6exvu45P2XT2b0msdG1HyMlb1WsOcBS+uKjEX7bjr87nnYLs85Om6/3d9qhu
        20/+9p5fGk52Nxf/PfjWcL7kVh/X3HVh9rUHPypMTt411V3UPKH8658JhhNldm666SV9jmf+
        2cUrDrRweV6uEDoz5UeFOvOq0jkmz37t8/rktixfiaU4I9FQi7moOBEA0lBeGrsCAAA=
X-CMS-MailID: 20190218003457epcas1p11d8c26022f11c1cbb86633164aa87e14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190216152219epcas4p3ec89de91f9e158da7cc7cfeefb6e113e
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
        <CGME20190216152219epcas4p3ec89de91f9e158da7cc7cfeefb6e113e@epcas4p3.samsung.com>
        <20190216151826.11584-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> The semicolon is unneeded, so remove it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/rk3399_dmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index e795ad2b3f6b..a228dad2bee4 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -322,7 +322,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  		dev_err(dev, "Cannot get the clk dmc_clk\n");
>  		return PTR_ERR(data->dmc_clk);
> -	};
> +	}
>  
>  	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
>  	if (IS_ERR(data->edev))
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
