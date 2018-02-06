Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeBFNyn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:54:43 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9868 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751725AbeBFNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:54:36 -0500
X-IronPort-AV: E=Sophos;i="5.46,468,1511823600";
   d="scan'208";a="312279255"
Date: Tue, 6 Feb 2018 14:54:29 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Wolfram Sang <wsa@the-dreams.de>
cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] tree-wide: fix comparison to bitshift when dealing
 with a mask
In-Reply-To: <20180206135310.deiaz55xemc26xn4@ninjato>
Message-ID: <alpine.DEB.2.20.1802061453440.3306@hadrien>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com> <20180206131044.oso33fvv553trrd7@mwanda> <alpine.DEB.2.20.1802061414340.3306@hadrien> <20180206132335.luut6em3kut7f7ej@mwanda> <alpine.DEB.2.20.1802061439110.3306@hadrien>
 <20180206135310.deiaz55xemc26xn4@ninjato>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2018, Wolfram Sang wrote:

> Hi Julia,
>
> > and got the results below.  I can make a version for the kernel shortly.
>
> It should probably take care of right-shifting, too?

I did that too but got no results.  Perhaps right shifting constants is
pretty uncommon.  I can put that in the complete rule though.

julia
