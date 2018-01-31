Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeAaGNr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:13:47 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:28075 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbeAaGNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:13:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180131060727epoutp04c65e246ad599a0512bfd9cea48022a77~O0AXG8YD22813328133epoutp04P
X-AuditID: b6c32a46-3a9ff70000001029-03-5a715d1fcecc
Date: Wed, 31 Jan 2018 15:07:26 +0900
From: Andi Shyti <andi.shyti@samsung.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>,
        jeesw@melfas.com
Subject: Re: [PATCH 7/8] Input: mms114 - add SPDX identifier
Message-id: <20180131060726.GB7575@gangnam.samsung>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-disposition: inline
In-reply-to: <20180129194659.df7nlhwx4demk6o6@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nOjuLiNDU/tMs43VBybXPOo2gYSQ3sxyCxXIge5sc2chd3
        NnH+SbRMLdRSUdfNtP4YlJdhpkildiMviISUNZiRhZDRRiqW2NxR8N/zvu/zvs/7fN9LYOJF
        QTRhNNuRzcwUUngov28kNjF+f26RVtb9fCfdsfKdR4+0/wD01blqAf3RtySgpwdu47R7bBZP
        x9UzD3yY+pnri1B9+UkPrl5uGQNqf88+jUCLUg2IKUA2CTLrLAVGsz6NyjybdzIvUSWTx8uT
        6SRKYmZMKI3KOKOJP2UsDGxASYqZQkcgpWFYljp2PNVmcdiRxGBh7WnUBblcIZXLkqQKhUKq
        TMhNUSQGKPnI8KLBB6yf+CWumkVBGZjEakAIAUklbGmaADUglBCT/QD+7KnbDJYB7Bht5G2x
        fs295XOFQQC/lnsxLvAB6L/2TbjB4pOH4NDqveBcnIyF5bMr+AaOII/Bp7dWg2MxshlAb8MA
        f6MQTqbCCU9rEIvIBPjh9zvA4V1wpcETzGPkUTj++jHgcAycW2sJioWQKjjfPhoUiyQPwLaF
        RuGGACT7cVhZ9xnn9s6Ar7xuAYfD4cIbt5DDMXC+sxtwuALAvlkd11wPoG/oz6bpBDh/v4bH
        Ke+EVSNrgWYikBfBqkoxR1HDrvf+zfkn4NTfMh73LD8BXPqxgNeDva5thlzbDLm2GWoDWCfY
        jaysSY9YhVUhZRkT6zDrpTqLqQcEby3uVD94MHFmGJAEoMJERIlVKxYwxazTNAwggVERIv7R
        Iq1YVMA4S5HNkmdzFCJ2GCQGfuUGFh2pswQu12zPkyuTZUqVSpGkogOHFSW6osnQikk9Y0cX
        EbIi21YfjwiJLgNVg9kVxsFlsv75ZWll5t0+PFtX16ufufNpXCMpjapb33Ewzj8YdiRrzDj9
        aHQyKyedXlp33dPL2njXsw1itnt2xuMYS3c2/ztYHZPjQVc8ztCmXBTR7ek9D1PktSmNN7vy
        b9S6DxtP74l4mP+ydfJcTrXF3xrmvH0pc8rr0lN81sDI4zAby/wHPBmaUYEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t9jAV252MIog0f7jC0W/3jOZHF40QtG
        i/ZHnawWNz99Y7W4vGsOm8WWM7fZHNg8ri/5xOyxc9Zddo+W9ZvYPL7POMPo8XmTXABrFJdN
        SmpOZllqkb5dAlfGgcmfGAtusVTM6nrH2sB4nrmLkZNDQsBE4v2jEyxdjFwcQgI7GSV2P9vN
        DuF8YpRYtPgiI0gVi4CqxN5f88E62AQ0JZpu/2ADsUUE9CW2z/7FCNLALDCVUWLW85NgCWEB
        G4lz92aygNi8AsYSVz+eZISY+pZR4mHXCnaIhKDEj8n3wIqYBbQk1u88zgRhS0s8+jsDrIZT
        wEzi2aIjYJtFBZQlFryawj6BkX8WkvZZSNpnIWlfwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4
        NC9dLzk/dxMjMKC3Hdbq38H4eEn8IUYBDkYlHt6EqoIoIdbEsuLK3EOMEhzMSiK8LDqFUUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoY5T30LuRuFc24
        qOn4R8vrv/K9w7fT7ymsPj/3eJhy46QnV7XthCSfm84WWOeR2H532/uK+qqTLluadapkH606
        aW1tfah8wRqvfW9uvSyt3eJyQnDGNo3/H9/u0M/rc7F7IPCtxmvZq9YrKxjPri/klXzHPum6
        o4/f0gPchVsDd+cJG3nn1EtpKLEUZyQaajEXFScCAAyq8mJkAgAA
X-CMS-MailID: 20180131060726epcas2p40b5a5c54dc18b41780c5f1ddc0dbabad
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c
X-RootMTR: 20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c@epcas2p1.samsung.com>
        <20180129113323.18961-8-andi.shyti@samsung.com>
        <20180129194659.df7nlhwx4demk6o6@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > -/*
> > - * Copyright (C) 2012 Samsung Electronics Co.Ltd
> > - * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - */
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Samsung S6SY761 Touchscreen device driver

I'm very sorry, but my distrcation will kill me one day.

Is it possible to revert this patch or do you want me to send a
fix?

Sorry,
Andi
