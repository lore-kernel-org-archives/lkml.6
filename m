Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeESLUb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:20:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55510 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeESLUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:20:30 -0400
Date: Sat, 19 May 2018 13:20:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dmitry Safonov <0x7f454c46@gmail.com>
cc: Tariq Toukan <tariqt@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018, Dmitry Safonov wrote:
> I'm not entirely sure that it's the same fault, but at least backtrace
> looks resembling.

Yes, it's similar, but not the same issue. I'll stare are the code ...

Thanks,

	tglx
