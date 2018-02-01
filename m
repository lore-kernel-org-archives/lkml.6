Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeBANWg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:22:36 -0500
Received: from ozlabs.org ([103.22.144.67]:56371 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752731AbeBANWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:22:32 -0500
Date: Fri, 2 Feb 2018 00:22:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180202002227.36db3356@canb.auug.org.au>
In-Reply-To: <20180201104707.GA21802@cbox>
References: <20180201125512.7bc96674@canb.auug.org.au>
        <20180201104707.GA21802@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoffer,

On Thu, 1 Feb 2018 11:47:07 +0100 Christoffer Dall <christoffer.dall@linaro.org> wrote:
>
> While the suggested fix is functional it does result in some code
> duplication, and the better resolution is the following:

OK, I will use that resolution form tomorrow on.

Someone needs to remember to let Linus know when the pull request is
sent.

-- 
Cheers,
Stephen Rothwell
