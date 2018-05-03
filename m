Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECWWf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:22:35 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33626 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeECWWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:22:33 -0400
X-Google-Smtp-Source: AB8JxZqMbkum7h4YqUTCZhKzGClqjVjn3zaun0z46q+m5+pyBkp0gaZQ/LoDsev4P283TcFNqp8VfWQ5V6ifT05GHuc=
MIME-Version: 1.0
In-Reply-To: <1525343956-10089-2-git-send-email-tdas@codeaurora.org>
References: <1525343956-10089-1-git-send-email-tdas@codeaurora.org> <1525343956-10089-2-git-send-email-tdas@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 May 2018 15:22:30 -0700
X-Google-Sender-Auth: z78pSLHZR8_z5iViagGoFCyOIuo
Message-ID: <CAD=FV=WRfctkUtMgtNh=4DT4aZWKFXRfV3YRjMG-qH2sjW8sgA@mail.gmail.com>
Subject: Re: [v7] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: Taniya Das <tdas@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 3, 2018 at 3:39 AM, Taniya Das <tdas@codeaurora.org> wrote:
> +       rpmh_client = rpmh_get_client(pdev);
> +       if (IS_ERR(rpmh_client)) {
> +               ret = PTR_ERR(rpmh_client);
> +               dev_err(&pdev->dev, "Failed to request RPMh client, ret=%d\n",
> +                                                                       ret);
> +               return ret;
> +       }

Please rebase atop the latest RPMh code (v7).  There is no more
rpmh_get_client().  If you want help doing this, please see
<http://crosreview.com/1042987> which contains all the changes to work
with v7.


-Doug
