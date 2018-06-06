Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 555B96083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeFFMmE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:42:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50021 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeFFMmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:42:01 -0400
Date: Wed, 6 Jun 2018 14:41:57 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Masatake YAMATO <yamato@redhat.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: Re: [PATCH] x86/iommu: Fix a typo in a macro parameter
In-Reply-To: <alpine.DEB.2.21.1806061409150.1579@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806061440000.1579@nanos.tec.linutronix.de>
References: <20180606051026.29535-1-yamato@redhat.com> <alpine.DEB.2.21.1806061235330.1579@nanos.tec.linutronix.de> <20180606.201529.867663362891798169.yamato@redhat.com> <alpine.DEB.2.21.1806061409150.1579@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018, Thomas Gleixner wrote:
> On Wed, 6 Jun 2018, Masatake YAMATO wrote:
> > On Wed, 6 Jun 2018 12:37:34 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Wed, 6 Jun 2018, Masatake YAMATO wrote:
> > > 
> > > Can you please explain why 0 is the wrong value.
> > 
> > I don't know such constants, 0 and 1.
> > 
> > What I change is just the name of macro parameter as 
> > 
> >      s/detect/_detect/
> 
> OOps. Misread the patch. Sorry.

But the fix is pretty pointless. IOMMU_INIT_POST_FINISH() is completely
unused and should just be removed.

Thanks,

	tglx
