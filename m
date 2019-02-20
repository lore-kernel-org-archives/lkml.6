Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6422EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB5920880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfBTN4k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:56:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44591 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBTN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:56:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so11466590wrt.11;
        Wed, 20 Feb 2019 05:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mr2SnelbiJUUghAwbgCBMha1QF1gvL4tCn0WX03/2GA=;
        b=c5rZNLnVt6LfLRYOfcOrOm6MxzdtrINd5c1oMBBfRQ+Yupr66jAipt0L833bZTJwM4
         1acgfRiWCyzES20rltkPkhVdrO8eUGo2sW+JQ0N7QiX+3UFau78FzG7Racw+++Bx0tbz
         wE0eUM7S3rzYi2zFGDT/MSM0eifZi4JWVZyxEVvgikDZ6dY3XhLTkJWv95F1KtFlwm5W
         guGUr0gCYhBDc3Bw1Uz0isWpcnaAEgd9NgMyTMYJg6J3s0j2MuAKV8l2lYB90yXHxYCt
         g445BELx6SyW/7OX9/09e0byJBNj6TKFg/DgyC/56ijOah9tJAS0+QYJCbuwwJbCDh3B
         Ioiw==
X-Gm-Message-State: AHQUAuaWnF6pSg2itfHZ7BsmYmh2mkRBqvZqUNbr07SknEFT3Ag0gdrG
        h/ntXBioHh1Z/vu81gRRFSbSkn3cKNyWgM1QkB4=
X-Google-Smtp-Source: AHgI3IYBtbJJWNE6Xq/xTWlMIowgeujfUGTLg6tdqk/fmeF5vWf3j/so314W4MCUDohhZ1t8o2GPd4SqoPmlpNSeMKQ=
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr23193693wrs.94.1550670997475;
 Wed, 20 Feb 2019 05:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20190216151826.11584-1-tiny.windzz@gmail.com> <CGME20190216152219epcas4p3ec89de91f9e158da7cc7cfeefb6e113e@epcas4p3.samsung.com>
 <20190216151826.11584-2-tiny.windzz@gmail.com> <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
In-Reply-To: <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
Reply-To: myungjoo.ham@gmail.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
Date:   Wed, 20 Feb 2019 22:55:59 +0900
Message-ID: <CAJ0PZbQ808ztVzWyq_cTAD5o276y-t+0Lih2a5jOv05585VTEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM / devfreq: rk3399_dmc: remove unneeded semicolon
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:09 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi,
>
> On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> > The semicolon is unneeded, so remove it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/rk3399_dmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> > index e795ad2b3f6b..a228dad2bee4 100644
> > --- a/drivers/devfreq/rk3399_dmc.c
> > +++ b/drivers/devfreq/rk3399_dmc.c
> > @@ -322,7 +322,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> >
> >               dev_err(dev, "Cannot get the clk dmc_clk\n");
> >               return PTR_ERR(data->dmc_clk);
> > -     };
> > +     }
> >
> >       data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
> >       if (IS_ERR(data->edev))
> >
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Merged.

>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics


-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
