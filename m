Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDSGEg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:04:36 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:40110 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeDSGEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:04:33 -0400
X-Google-Smtp-Source: AIpwx4/iOu8UkiKIvBR6FmAVPuPIcS8ONXx04rPZsHNfCU190eThQ3Egrd+gZ5Sjw0KOFgQR88WZnA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: David Collins <collinsd@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
Message-ID: <152411787180.46528.5441480997805485928@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
Date: Wed, 18 Apr 2018 23:04:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3J64fV4005752

Quoting David Collins (2018-04-18 16:30:26)
> On 04/17/2018 01:02 PM, Doug Anderson wrote:
> > On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
> >> +#define RPMH_REGULATOR_DISABLE                 0x0
> >> +#define RPMH_REGULATOR_ENABLE                  0x1
> > 
> > In the last version Stephen said he didn't like the above two #defines
> > and you said you'd remove them, yet they are still here.  Explanation?
> 
> I thought that he was referring to the comments above the constants since
> his review comment was immediately following the second of two comments as
> opposed to these constants.  I'll let him follow-up on this point if
> necessary.
> 

I think I was talking about the comments. The defines don't look super
useful either though.
