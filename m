Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE7AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4C0218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RDD0W4RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbeLTRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:43:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46304 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387472AbeLTRn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:43:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220174323euoutp018857728747a13d3d4acfe253563f1085~yG3Mv7TkS2160221602euoutp01R
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:43:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220174323euoutp018857728747a13d3d4acfe253563f1085~yG3Mv7TkS2160221602euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545327803;
        bh=z4wCJgAjBfc/+eMcmkSFGk1ZgpN0oTfB7UjJkp1lhos=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RDD0W4RBOm3Rqw0mc972MIey8odD5bpOYIbZ5r3XkL5apGPgfIt03en3uhDCT+oAi
         1fqcoV62WPKSSWbCUrlwQjwDfxgjNrAOmntKVZfsJ7U4XFZyA5okoVW7B78+3zXmMs
         J6a9SUpSUZLerVPKlDHD4ldnqlH36juJgKmHvXEo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220174323eucas1p215a5013e474eff87cc8cb5cebbf023cd~yG3MKr-im3265032650eucas1p2Y;
        Thu, 20 Dec 2018 17:43:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 39.AA.04806.AB4DB1C5; Thu, 20
        Dec 2018 17:43:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220174322eucas1p12c2fc2b22ec6b69ea8710b305783aba1~yG3LgPGat0401504015eucas1p1i;
        Thu, 20 Dec 2018 17:43:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220174322eusmtrp292839e829ba729d3371b993a6577d3b2~yG3LR8Bsx1380413804eusmtrp2c;
        Thu, 20 Dec 2018 17:43:22 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-e2-5c1bd4ba23a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.6A.04284.AB4DB1C5; Thu, 20
        Dec 2018 17:43:22 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181220174321eusmtip1a95d30ed36cd85bcfa9a4a5766e0fea2~yG3K9rDFq2189121891eusmtip1H;
        Thu, 20 Dec 2018 17:43:21 +0000 (GMT)
Subject: Re: [PATCH] fbdev: uvesafb: fix spelling mistake "memoery" ->
 "memory"
To:     Colin King <colin.king@canonical.com>
Cc:     Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6ffc5f38-a167-e51c-ee36-f7bf1d190a4e@samsung.com>
Date:   Thu, 20 Dec 2018 18:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181128153735.14083-1-colin.king@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87q7rkjHGLS91rf4vbqXzeLK1/ds
        FltvSVuc6PvAanF51xw2iykfjzM7sHnMauhl87j8/Q2zx/3u40wenzfJBbBEcdmkpOZklqUW
        6dslcGV8PLyUteAzU8WE28vYGxjXM3UxcnBICJhIvHhk28XIxSEksIJRYtu6TjYI5wujxLFd
        v6Ccz4wS93bPYO9i5ATruDZtBiuILSSwnFGir9EDoug9o8TLs+1gRcICgRJTbtxiBlkhIqAp
        cf5cEUgNs8AqRonpfx+wgNSwCVhJTGxfxQhi8wrYSSxd1s4GUs8ioCrRsVsHxBQViJDoP6MO
        USEocXLmE7BOTqDqa4+/MIPYzALyEtvfzmEGGS8hMJldYvHK2awQd7pIbP/znBnCFpZ4dXwL
        1P0yEv93zmeCaJjOKPHm11IWCGc9o8SaM8eYIKqsJQ4fv8gKcgUz0APrd+lDhB0lHs1vhgYd
        n8SNt4IQR/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07V0Kd4yFxZvZRlgmMirOQvDYLyTuz
        EPYuYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZhQTv87/nUH474/SYcYBTgYlXh4
        NXZJxwixJpYVV+YeYpTgYFYS4V1/CCjEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpi
        SWp2ampBahFMlomDU6qBUfyau6HGqjnGRTKcTrPtn7urrw43engmhTXJxS9093zlQ/8O8SZF
        8OuJ132NO7gryXZi+cp5R90y/879WfHiD9+hYzaf9mxRO79T85p48IsajbV50z49PrvxnX8B
        s7li7oRtO8ylgkzizm+YvjTaXkBd+2WnysVsTrYnTnmnlm64qPVb1Uf5mhJLcUaioRZzUXEi
        AJ+yKi0kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7q7rkjHGLx7yWTxe3Uvm8WVr+/Z
        LLbekrY40feB1eLyrjlsFlM+Hmd2YPOY1dDL5nH5+xtmj/vdx5k8Pm+SC2CJ0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4eHgpa8FnpooJt5ex
        NzCuZ+pi5OSQEDCRuDZtBmsXIxeHkMBSRon7s+4DORxACRmJ4+vLIGqEJf5c62KDqHnLKPGh
        rYkZJCEsECgx5cYtZpB6EQFNifPnikDCQgITGSUaHmuC1DMLrGKUaPp9ihUkwSZgJTGxfRUj
        iM0rYCexdFk7G0gvi4CqRMduHZCwqECExK2HHSwQJYISJ2c+AbM5gcqvPf4CtpZZQF3iz7xL
        ULa8xPa3c5gnMArOQtIyC0nZLCRlCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGyrZj
        PzfvYLy0MfgQowAHoxIPr8Yu6Rgh1sSy4srcQ4wSHMxKIrzrDwGFeFMSK6tSi/Lji0pzUosP
        MZoC/TCRWUo0OR8Yx3kl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODil
        GhiFVF9UzqhfnTVV5Y/2T90LzFuOvzqy+tlzo8AfWTs3/jz0+mc1hzFX6Y3/zPffR2TzaAY4
        n9m3TKtn0/3jpzIX7EpdMWXb/AUP99bfzZetPL7RIa8sfIaU7IL2wNIXAeuPh5kvedLAe3W1
        nN42tlzx3R/5njctOZywaKv23pllV0NiPzp/szvppcRSnJFoqMVcVJwIADbgUKyrAgAA
X-CMS-MailID: 20181220174322eucas1p12c2fc2b22ec6b69ea8710b305783aba1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181128153831epcas3p2e9de4c3758e444885c08644a03b586a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181128153831epcas3p2e9de4c3758e444885c08644a03b586a1
References: <CGME20181128153831epcas3p2e9de4c3758e444885c08644a03b586a1@epcas3p2.samsung.com>
        <20181128153735.14083-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/2018 04:37 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the module parameter description, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
