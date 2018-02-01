Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeBAOFJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:05:09 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:32981 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeBAOFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:05:06 -0500
X-Google-Smtp-Source: AH8x226b9BnfSTeXhPEPQh/nyrQlhH3E7yWvqruiyXUOakw+Mgdg1QWd+OtkC15iOTAJulcZnbnYTw==
Date: Thu, 1 Feb 2018 15:05:03 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180201140503.GE21802@cbox>
References: <20180201125512.7bc96674@canb.auug.org.au>
 <20180201104707.GA21802@cbox>
 <20180202002227.36db3356@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202002227.36db3356@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 12:22:27AM +1100, Stephen Rothwell wrote:
> Hi Christoffer,
> 
> On Thu, 1 Feb 2018 11:47:07 +0100 Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >
> > While the suggested fix is functional it does result in some code
> > duplication, and the better resolution is the following:
> 
> OK, I will use that resolution form tomorrow on.
> 
> Someone needs to remember to let Linus know when the pull request is
> sent.
> 
I've sent a separate notice to Paolo and Radim, so I'm sure they'll take
care of it.

Thanks,
-Christoffer
