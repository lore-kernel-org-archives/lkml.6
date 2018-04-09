Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeDIUnM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:43:12 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34937 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeDIUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:43:10 -0400
X-Google-Smtp-Source: AIpwx48G9vw9RYkYT2m3v5Dnr0nX10OstRZ1Y6D7bQfjowIlEYAHBisCio/6ulRjOVPlKVc+bgfavA==
MIME-Version: 1.0
References: <20180406151356.7818-1-ilina@codeaurora.org> <20180406151356.7818-3-ilina@codeaurora.org>
 <152305660223.94378.422604779280814924@swboyd.mtv.corp.google.com>
In-Reply-To: <152305660223.94378.422604779280814924@swboyd.mtv.corp.google.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 09 Apr 2018 20:42:32 +0000
X-Gmail-Original-Message-ID: <CAE=gft4uBMknENW5o7Rr+ZPQYWUBRBRzAPdvy2=8wGDMMV4CVw@mail.gmail.com>
Message-ID: <CAE=gft4uBMknENW5o7Rr+ZPQYWUBRBRzAPdvy2=8wGDMMV4CVw@mail.gmail.com>
Subject: Re: [PATCH v7 [RESEND] 2/2] dt-bindings: introduce Command DB for
 QCOM SoCs
To: swboyd@chromium.org
Cc: Lina Iyer <ilina@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, msivasub@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 4:16 PM Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Lina Iyer (2018-04-06 08:13:56)
> > From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> >
> > Command DB provides information on shared resources like clocks,
> > regulators etc., probed at boot by the remote subsytem and made
> > available in shared memory.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >

> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> > +       reserved-memory {
> > +               [...]
> > +               qcom,cmd-db@85fe0000 {

> Nitpick: This may want to be called 'memory@85fe0000' because we prefer
> generic node names.

Another nit: the cmd-db region seems to need "no-map" to make the example
actually work.

Reviewed-by: Evan Green <evgreen@chromium.org>

-Evan
