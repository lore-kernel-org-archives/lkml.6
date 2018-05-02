Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEBQ3l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:29:41 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:42438 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEBQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:29:38 -0400
X-Google-Smtp-Source: AB8JxZrMw/hnm0tQz5gA+R1A40NN1W6O1vOEHuUsp+tuiXaiip7Hh0tVt0ErqMqNQHSlOdd6M8CJ7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=VoGpRLsPXcfPaiaJh18u+79DcN9PUGScDKUu+COgj7Gw@mail.gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20180419230032.13611-1-swboyd@chromium.org>
 <CAD=FV=VoGpRLsPXcfPaiaJh18u+79DcN9PUGScDKUu+COgj7Gw@mail.gmail.com>
Message-ID: <152527857679.138124.10889204252669437850@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] mfd: qcom-spmi-pmic: Add support for pm8005,pm8998,pmi8998
Date: Wed, 02 May 2018 09:29:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42GTjM0030068

Quoting Doug Anderson (2018-04-23 22:26:29)
> 
> >  static const struct of_device_id pmic_spmi_id_table[] = {
> >         { .compatible = "qcom,spmi-pmic", .data = (void *)COMMON_SUBTYPE },
> > @@ -54,7 +57,10 @@ static const struct of_device_id pmic_spmi_id_table[] = {
> >         { .compatible = "qcom,pmi8994",   .data = (void *)PMI8994_SUBTYPE },
> >         { .compatible = "qcom,pm8916",    .data = (void *)PM8916_SUBTYPE },
> >         { .compatible = "qcom,pm8004",    .data = (void *)PM8004_SUBTYPE },
> > +       { .compatible = "qcom,pmi8998",   .data = (void *)PMI8998_SUBTYPE },
> > +       { .compatible = "qcom,pm8005",    .data = (void *)PM8005_SUBTYPE },
> >         { .compatible = "qcom,pm8909",    .data = (void *)PM8909_SUBTYPE },
> > +       { .compatible = "qcom,pm8998",    .data = (void *)PM8998_SUBTYPE },
> 
> nit: It appears that the above table was previously sorted by SUBTYPE
> ID.  Could you perhaps move your 3 new PMICs to the bottom to maintain
> this?  Other than that, you can add my Reviewed-by if you would like
> (not that I have _any_ real expertise on SPMI, so might not be worth
> it).

Ok. I'll change the order and resend the patch with the reviewed-by
tags.
