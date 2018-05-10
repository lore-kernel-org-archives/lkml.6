Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757251AbeEJMI0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:08:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41984 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757158AbeEJMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:08:24 -0400
X-Google-Smtp-Source: AB8JxZpegVrFurC8bD6BL92neKMt0TY2Ya48KrnhkpZt57aLXhNoLCKaaIIj9MbT4Sjo5Px5SR3y5g==
Date: Thu, 10 May 2018 17:38:20 +0530
From: Vinod Koul <vinod.koul@linaro.org>
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: srinivas.kandagatla@linaro.org, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        lakml <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: msm8916: fix gic_irq_domain_translate warnings
Message-ID: <20180510120820.GA18812@vkoul-mobl.Dlink>
References: <20180418163415.21646-1-srinivas.kandagatla@linaro.org>
 <CAHLCerOZ3_A7PvD6i53WXLJXVPmUWcNakvA2gcwFYMT9f1iR0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerOZ3_A7PvD6i53WXLJXVPmUWcNakvA2gcwFYMT9f1iR0A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-18, 12:03, Amit Kucheria wrote:
> On Wed, Apr 18, 2018 at 7:34 PM,  <srinivas.kandagatla@linaro.org> wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >
> > Remove the usage of IRQ_TYPE_NONE to fix loud warnings from
> > patch (83a86fbb5b56b "irqchip/gic: Loudly complain about
> > the use of IRQ_TYPE_NONE").
> >
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
