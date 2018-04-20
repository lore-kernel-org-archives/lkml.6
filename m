Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeDTIG3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:06:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37185 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754034AbeDTIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:06:26 -0400
X-Google-Smtp-Source: AIpwx4+CmkGw2NdZwhqBub1m8yKWgvyHBC1Zzw6Mz3+qmZwz30dteITHmSR5+CgkvMW6aTk/z3pO/Q==
Date: Fri, 20 Apr 2018 09:06:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: ryang <decatf@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: tps6586x: Add support for TPS658624
Message-ID: <20180420080623.cyohf6js6evxgtmx@dell>
References: <20180419161850.GA9144@computer>
 <20180419164801.GI27188@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419164801.GI27188@sirena.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Mark Brown wrote:

> On Thu, Apr 19, 2018 at 12:18:50PM -0400, ryang wrote:
> > This version is exists in the Samsung Galaxy Tab 10.1 which is based on the
> > Nvidia Tegra 2 board. The TPS658624 has the same SM2 voltage table as
> > TPS658623.
> 
> > Signed-off-by: ryang <decatf@gmail.com>
> > ---
> >  drivers/regulator/tps6586x-regulator.c | 1 +
> >  include/linux/mfd/tps6586x.h           | 1 +
> >  2 files changed, 2 insertions(+)
> 
> This also touches the MFD header for the part so should've been sent to
> Lee, the MFD maintainer (CCed here, left the entire patch for context).  

Thanks Mark.

Please take it.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
