Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933860AbeE2Maj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:30:39 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44732 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933565AbeE2Mah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:30:37 -0400
X-Google-Smtp-Source: ADUXVKI6yJqJBqHH/UZ8gaF9bjsrp4199AVd4pnh2pLrWjwYxT2SWDhlgTAB9kSxaBzxj+bG0zAjnzTmAU0DGaXQznE=
MIME-Version: 1.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 29 May 2018 22:00:16 +0930
X-Google-Sender-Auth: Ug87zoNO_SXc9cKRXUIqwLOGblk
Message-ID: <CACPK8XdvnGHz6Om2RQmgu+7F4h9AEh+Ay=A_b4+3vDGqD4SKbA@mail.gmail.com>
Subject: Re: [PATCH 00/15] fsi: Overall improvements and new SBE fifo driver
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2018 at 11:00, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This series brings in a number of improvements to our FSI stack
> (one of the service interfaces for communicating between a BMC chip and
> our POWER processors).
>
> The GPIO based "Soft FSI" performance is significantly improved, and
> it's reliability as well.
>
> The SBE fifo driver provides the interface to the processor "Self Boot
> Engine"
>
> Some of these patches have been simmering for a while in the OpenBMC
> tree.

I run this series atop of 4.17-rc7 today, and they look solid.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
