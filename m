Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbeDKOAD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:00:03 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35374 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeDKOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:00:01 -0400
X-Google-Smtp-Source: AIpwx4/q0c7U4OWdH/0ivu4Y2ILHnAI2cp+etSQrbw9Z3b2I7hFeDm9o5nN3qzzEAvTSOKoePSxPR/z7y8iUAdmaalc=
MIME-Version: 1.0
In-Reply-To: <CAN6D2nrPeWG-LxurpT=u8-kS-2jVQPpWnkth7bxqFn_U=VZJvA@mail.gmail.com>
References: <20180406014340.1562-1-march511@gmail.com> <20180408.125114.2111042327285982582.davem@davemloft.net>
 <CAN6D2npQd9AowLCz5CXGNPPib+10nABh1dOvLWV15r1z6FvF8w@mail.gmail.com>
 <20180410163216.GB3661@localhost.localdomain> <CAN6D2nrPeWG-LxurpT=u8-kS-2jVQPpWnkth7bxqFn_U=VZJvA@mail.gmail.com>
From: Wenhua Shi <march511@gmail.com>
Date: Wed, 11 Apr 2018 15:59:41 +0200
Message-ID: <CAN6D2nqAQER08TQGm1SBijEdSWMK=sD2H_sd0uwurLJU3yET3g@mail.gmail.com>
Subject: Re: [PATCH] make net_gso_ok return false when gso_type is zero(invalid)
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that TCP stack now works with GSO being always on.
> 0a6b2a1dc2a2 ("tcp: switch to GSO being always on")

I've tested on the latest net-next branch
17dec0a949153d9ac00760ba2f5b78cb583e995f. The problem still exists. My
patch won't work. Reverting commit 0a6b2a1dc2a2 won't help.
