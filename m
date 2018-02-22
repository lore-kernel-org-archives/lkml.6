Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeBVFOY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:14:24 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:43693 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbeBVFOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:14:20 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180222051419epoutp04608fca5c4d4a7ffb6fd198f7dd93c200~VjePhpJTJ0881908819epoutp04X
X-AuditID: b6c32a37-44bff70000001029-4d-5a8e51aa8cf2
Mime-Version: 1.0
Subject: RE: Re: [PATCH] PM / devfreq: exynos-ppmu: Delete an error message
 for a failed memory allocation in exynos_ppmu_probe()
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5A8364F8.8050801@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180222051418epcms1p515085d1b1fabaf50983ff2ecb3442c02@epcms1p5>
Date: Thu, 22 Feb 2018 14:14:18 +0900
X-CMS-MailID: 20180222051418epcms1p515085d1b1fabaf50983ff2ecb3442c02
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180222051418epcms1p515085d1b1fabaf50983ff2ecb3442c02
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmnu6qwL4og54WNYvrX56zWpzvXM5s
        sfWWtEX/49fMFufPb2C3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwOXB6bVnWyeWxeUu/R
        t2UVo0fTqXZWj8+b5AJYo1JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJz
        U22VXHwCdN0yc4BuUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKkUbGhrpGRqY6xkZGemZ
        GMdaGZkClSSkZmz9vYWlYD9/xb3VFg2MnfxdjJwcEgImEs/m3mfsYuTiEBLYwShx/dtMpi5G
        Dg5eAUGJvzuEQeLCAs2MEt83zGEBaRASUJJouLmPGcQWFtCX6HiwjRHEZhPQldi64S4LSIOI
        wFJmiZkNk8ASzAJ5Ep3TVrJBbOOVmNH+lAXClpbYvnwrWA2ngLZE74duqBpRiZur37LD2O+P
        zWeEsEUkWu+dZYawBSUe/NwNFZeUWHKgCSpeL3H98yImkCMkBCYwSvy+8R9qkL7EoyuzwRbw
        CvhKtK7+ANbAIqAqca5lJlSNi8T7PatZII7Wlli28DUzKCSYBTQl1u/Shyixlfh/8y0rRAmf
        xLuvPawwf+2Y94QJwlaTOLR7CdRIGYnT0xeCjZEQ8JBY38oFEXaU2HzrMMsERsVZiKCehWTv
        LIS9CxiZVzGKpRYU56anFhsWGOsVJ+YWl+al6yXn525iBCdMLfMdjBvO+RxiFOBgVOLhjSjp
        jRJiTSwrrsw9xCjBwawkwmur0RclxJuSWFmVWpQfX1Sak1p8iNEU6P2JzFKiyfnAZJ5XEm9o
        YmlgYmYETHGWhoZK4rwBAS5RQgLpiSWp2ampBalFMH1MHJxSDYwsf6Tef63O6rl8ZLbRj2lO
        lhb92zhXX53HUTfbO+7dBWbXR5ZlLP82t/9Z9qEwpm2Kve2nszpXJ21hSCueYVAW+/7L3frw
        rY0nXyx5V9O26Ekum8XKVXd2yXXPPGXE927ZNoHlsdPe7wvbFr7vt+6Nacfu5B8N+PWVuXza
        UVfVMs/U8+a96pwvlViKMxINtZiLihMBitie/q4DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78
X-RootMTR: 20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78
References: <5A8364F8.8050801@samsung.com>
        <e4d3a870-f420-5a06-1665-59152c1924a3@users.sourceforge.net>
        <CGME20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1M5ETuN006933

> On 2018년 02월 14일 06:17, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Tue, 13 Feb 2018 22:10:42 +0100
> > 
> > Omit an extra message for a memory allocation failure in this function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/devfreq/event/exynos-ppmu.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> > index d96e3dc71cf8..72ac9113500d 100644
> > --- a/drivers/devfreq/event/exynos-ppmu.c
> > +++ b/drivers/devfreq/event/exynos-ppmu.c
> > @@ -627,11 +627,9 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
> >  
> >  	size = sizeof(struct devfreq_event_dev *) * info->num_events;
> >  	info->edev = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> > -	if (!info->edev) {
> > -		dev_err(&pdev->dev,
> > -			"failed to allocate memory devfreq-event devices\n");
> > +	if (!info->edev)
> >  		return -ENOMEM;
> > -	}
> > +
> >  	edev = info->edev;
> >  	platform_set_drvdata(pdev, info);
> >  
> > 
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
