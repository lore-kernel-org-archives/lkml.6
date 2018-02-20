Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeBTSRw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:17:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeBTSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:17:51 -0500
Date: Tue, 20 Feb 2018 19:18:00 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tariq Toukan <tariqt@mellanox.com>
cc: linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1802201917200.24268@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Thomas Gleixner wrote:
> On Tue, 20 Feb 2018, Tariq Toukan wrote:
> 
> Is there CPU hotplugging in play?
> 
> I'll come back to you tomorrow with a plan how to debug that after staring
> into the code some more.

Do you have a rough idea what the test case is doing?

Thanks,

	tglx
