Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933876AbeE1UJx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:09:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39369 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeE1UJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:09:49 -0400
Date: Mon, 28 May 2018 22:09:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Song Liu <songliubraving@fb.com>
cc: Song Liu <liu.song.a23@gmail.com>, Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com>
Message-ID: <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com> <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com> <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de> <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com> <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Song Liu wrote:
> This doesn't fix the issue with bnxt. Here is a trace with this patch:

That's just the backtrace which is not really helpful. The real question is
what leads to this scenaria.

What I was asking for is to enable the irq_vector and irq_matrix trace
points along with ftrace_dump_on_oops. The latter dumps the trace buffer
when the problem happens and that should give us a hint what actually
causes that.

Thanks,

	tglx
