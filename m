Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeCOHbR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:31:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeCOHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:31:15 -0400
Date: Thu, 15 Mar 2018 00:31:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Joshua R. Poulson" <jrp@pun.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] x86/hyper-v: move hyperv.h out of uapi
Message-ID: <20180315073112.GA25591@infradead.org>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-2-vkuznets@redhat.com>
 <20180314161317.GA19701@infradead.org>
 <CABHrTiKEEes69gewMjQNwiC4SmEM6BS+LF40bsKQFYGUQY1kRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHrTiKEEes69gewMjQNwiC4SmEM6BS+LF40bsKQFYGUQY1kRw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 09:42:42AM -0700, Joshua R. Poulson wrote:
> >> Move the file renaming to hyperv-tlfs.h to avoid confusing it with
> >> mshyperv.h. In future, all definitions from TLFS should go to it and
> >> all kernel objects should go to mshyperv.h or include/linux/hyperv.h.
> >
> > What is TLFS?  And hows does it differe from mshyperv.h?
> 
> The TLFS is the "Top-Level Functional Specification" for Hyper-V.
> 
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

Please put that reference in the changelog and header.
