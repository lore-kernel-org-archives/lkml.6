Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeEGRLZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:11:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41771 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbeEGRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:11:23 -0400
X-Google-Smtp-Source: AB8JxZqL8zGc6qeUmvsW08zLvpqxk06lMZJoHGzJnMG6oefElQbQsnvsAh2zxGzjjrD0Rkm8Vm7bzg==
Date: Mon, 7 May 2018 12:11:21 -0500
From: Rob Herring <robh@kernel.org>
To: Amit Nischal <anischal@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add QCOM video clock controller driver
Message-ID: <20180507171121.GA22656@rob-hp-laptop>
References: <1525350925-16006-1-git-send-email-anischal@codeaurora.org>
 <152545146453.138124.2471609033510400995@swboyd.mtv.corp.google.com>
 <09ac2bd5eab25cfc70a1c5dc7b0f90ed@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ac2bd5eab25cfc70a1c5dc7b0f90ed@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:16:53PM +0530, Amit Nischal wrote:
> On 2018-05-04 22:01, Stephen Boyd wrote:
> > Quoting Amit Nischal (2018-05-03 05:35:23)
> > > Changes in v1:
> > >    https://lkml.org/lkml/2018/4/24/545
> > > Addressed below review comments given by Rob
> > > - Change the compatible property as per '<vendor>,<soc>-<block>'
> > > format.
> > > - Add header definitions for resets and power-domain cells.
> > 
> > You didn't add any reset definitions though?
> 
> We haven't added the reset definitions for videocc as there is no
> video reset client.

So? You don't know what resets there are?

Rob
