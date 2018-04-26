Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeDZTmY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:42:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50020 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753603AbeDZTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:42:23 -0400
Date: Thu, 26 Apr 2018 21:42:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jacek Tomaka <jacekt@dug.com>
cc: linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacek Tomaka <jacek.tomaka@poczta.fm>, mingo@kernel.org, hpa@zytor.com
Subject: Re: [tip:x86/urgent] x86/cpu/intel: Add missing TLB cpuid values
In-Reply-To: <alpine.DEB.2.21.1804262138090.1596@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1804262141560.1596@nanos.tec.linutronix.de>
References: <20180423161425.24366-1-jacekt@dugeo.com> <tip-88ba3829dfd83219bb2b1954acb0c206a602ce83@git.kernel.org> <CAKVxXCU4G2JNL1dCh5BH7Sc8WjEOg72_jdt3hCwf5J4LU3Fi6A@mail.gmail.com> <alpine.DEB.2.21.1804262138090.1596@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018, Thomas Gleixner wrote:
> On Fri, 27 Apr 2018, Jacek Tomaka wrote:
> 
> > Hi Thomas,
> > 
> > Looks like the patch has lost a coma after 128.
> > +       { 0x6c, TLB_DATA_2M_4M,         128     " TLB_DATA 2 MByte or 4
> > MByte pages, 8-way associative" },
> > should be :
> > +       { 0x6c, TLB_DATA_2M_4M,         128,     " TLB_DATA 2 MByte or 4
> > MByte pages, 8-way associative" },
> > 
> > Do you want me to resend the patch with your updates?
> 
> Nah. I fix it up as I fatfingered it when I cleaned up the whitespace
> damage.

As a bonus I enable INTEL support when compiling it.
