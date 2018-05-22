Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEVMtB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:49:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:36025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeEVMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:48:58 -0400
Message-ID: <1526993322.6491.7.camel@gmx.de>
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date: Tue, 22 May 2018 14:48:42 +0200
In-Reply-To: <1526982375.6491.3.camel@gmx.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
         <20180504111459.24825-2-bigeasy@linutronix.de>
         <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
         <1525604359.28142.3.camel@gmx.de>
         <20180507073928.shmtfpqyhgxya53b@linutronix.de>
         <1526738996.5365.1.camel@gmx.de>
         <20180522065051.xy42nwvcxz2nekti@linutronix.de>
         <1526977462.6491.1.camel@gmx.de>
         <20180522091408.nt4fodr4f5ikk5ow@linutronix.de>
         <1526982375.6491.3.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:abEkbh571GmWBBNc+bJj+Bgd+k1ByQi5UGqaQ/4fFNfH9TEhVhQ
 mOj1VSbSIgzjGPzhlJNIH/yUvIyxxjZtMxyxRL3kHeR2UNR7/5u65quZ1orc5P0puybEgJM
 fAiyIV4rSH6ukWkNlmk2p/3jvMnTgUmMBMoKeRuYlKwNmHuSdzZLXCK8dOGDZcKMjT0CjJ0
 gT/c07tUnNRbK84DH2FZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OtZqAsSN0qY=:QrvWVpOfsg8L6pCylogrFD
 sXvcs+U2QBiDiho4kUZsyguNqNMgqw64hXntT7zfK5rw6ZrE4YiG+rtNy5djG+NQW5hCq7Llp
 ja1psQNNy3npbIiQJN5lvEy2ZiRt9EwyehNDEL1toTOgylLzTRkTzRoXVjmlaOOhiFtfW3j9G
 LsdnwESq3iYVrhiztOfGiItVpGLACyl3ynCqJPV4aJKxN7mUoAv95tACSjnhfWuFb3TqZH2MZ
 ga+J3HVJ2rla5MHpQIqnZCTRmboupBgRcp9o4OARO2cmSVLznBKB6QzBbY60wSK/c2IoNzHty
 +kMifQdHRzc60XDYk0sZ2FmlyhxquhZhYkGQgarQhi1wtHjmgPxqmQRvSRw0NdH5UbrAcCs2T
 8eCxvZ+8aRmV1y8qAFZkjZZ7+oVq5hRxLKY4NHuaClC0O1VHk/QJTCNPLL8k7CLvO93jy+jk0
 AjRh6UduRn+Mch68wcVstgnd8kdawP/nF4a1oVccoMCtCEiWtFLkIcJ06RGOYz71gShcbJhRl
 y1blVpiCz5LWsfp5xyLRPDJF1GRtYmF2lOK56Jmn6J7WkSyyj+bKdjX+ey/1w75T0Va52w+xe
 O81GiVOUcXmLlLdgzaboPHee3xHmq2g0PIYHED0UzLaW++G6+og5M5XkaVLxfDad7TtZlgjqD
 bAw9TgEcjKzk7RhYokzrb3aL/qU9jNkyLqt33FqnKgkW4JqrCR2rvChEw3DbGJc43uB1FG1KC
 x3Bp7OnUT/UtwMxQeW7eWXuERMoUsju83qRzeK/Af68pZOWeFlm1+QA+p2u4Jo10wSeSyd5I2
 o8HCFFv
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-22 at 11:46 +0200, Mike Galbraith wrote:
> On Tue, 2018-05-22 at 11:14 +0200, Sebastian Andrzej Siewior wrote:
> 
> >  If you suggest that I
> > should stop caring about UV than I do so. Please post a patch that adds
> > a dependency to UV on PREEMPT so that part of the architecture is
> > documented.
> 
> Will do.

On second thought, no I won't.  It's either already known, or it should
be, making any such submission smell funny.

	-Mike
