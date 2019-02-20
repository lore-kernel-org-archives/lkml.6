Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96571C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7287E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfBTN63 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:58:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44799 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfBTN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:58:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so11473442wrt.11;
        Wed, 20 Feb 2019 05:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9gWmZamgsA69HolfNaaWEg8e9mDbjUxOCkA1kE6tmlw=;
        b=JwLQUWRUeE0AfMoI5BLp+OZ/NTc8bK62fXyqWugeHk5BPIgpbqt9zDwOjuwctJ41wZ
         YKdlWq202xDLLgqJ8SgmgPVorwTiQ3vojOPn6SGBLr3Gpr/1fu/QOBUJ+b3BLQLmtMjS
         W9IodLMuySnCzuegSU1D77QzgR9/Pawh6U89hPsMrflqxMIHT4O4E4EDOUsbc5T7FpJ7
         DYAZRrTjKXpZESFWcw5UJOandZK6G9PhYSF3E+Cbsmu9BP8k0qEV7c4kH9jOkIDOhddR
         aZLAG8VvbFDxkfnB2Wg89zxtPneAA9pbPCp0G5Mb9dG5T4Lb9Vgk/0blXHzr9I72AETY
         RxsQ==
X-Gm-Message-State: AHQUAuY0ZWz18FzofVyYJnDL8oFGNskSOgpccESEsCLKLdYbcBYbGWZE
        dmxiRvCvLCUW+ihQjYzUNHdAgdMVWZdMSOQPSCQ=
X-Google-Smtp-Source: AHgI3Iat7/JFbIEG3jubX1hdHuYXOBePGIB2MNcS2gCDAizWlmp4cvnDlUS5xTQEYFyWDvYEAscp1uqyZkNB7AFdOg0=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr6387918wrv.199.1550671107581;
 Wed, 20 Feb 2019 05:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20190216151826.11584-1-tiny.windzz@gmail.com> <CGME20190216152000epcas1p216810769e13852c4b92896348657b6d6@epcas1p2.samsung.com>
 <20190216151826.11584-3-tiny.windzz@gmail.com> <47edbfaa-2c2d-04d3-cf24-8368f723c6fa@samsung.com>
In-Reply-To: <47edbfaa-2c2d-04d3-cf24-8368f723c6fa@samsung.com>
Reply-To: myungjoo.ham@gmail.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
Date:   Wed, 20 Feb 2019 22:57:49 +0900
Message-ID: <CAJ0PZbQORXei7y2RkSTF8SQJCya=d13x9n0DBYpNby-rSccUMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM / devfreq: rockchip-dfi: remove unneeded semicolon
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

On Mon, Feb 18, 2019 at 9:41 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi,
>
> On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> > The semicolon is unneeded, so remove it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/event/rockchip-dfi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> > index 22b113363ffc..fcbf76ebf55d 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -211,7 +211,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
> >       if (IS_ERR(data->clk)) {
> >               dev_err(dev, "Cannot get the clk dmc_clk\n");
> >               return PTR_ERR(data->clk);
> > -     };
> > +     }
> >
> >       /* try to find the optional reference to the pmu syscon */
> >       node = of_parse_phandle(np, "rockchip,pmu", 0);
> >
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Merged. Thanks.

>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics



-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
