Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933746AbeCGSYv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:24:51 -0500
Received: from ms.lwn.net ([45.79.88.28]:58668 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754577AbeCGSYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:24:48 -0500
Date: Wed, 7 Mar 2018 11:24:47 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Message-ID: <20180307112447.1eff794a@lwn.net>
In-Reply-To: <1520440503.10396.534.camel@linux.vnet.ibm.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
        <20180305125642.GA3425@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
        <20180306074932.GB3624@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
        <1520353933.5393.21.camel@HansenPartnership.com>
        <1520361396.10396.396.camel@linux.vnet.ibm.com>
        <20180307085454.2c820a13@lwn.net>
        <1520440503.10396.534.camel@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2018 11:35:03 -0500
Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> Some maintainers are saying to put the Changelog after the "---" so
> that it isn't included in the patch description.
> 
> One of the reasons for including the Changelog in the patch
> description, is to credit people with bug fixes, important rework of
> the patch, etc.
> 
> Do you have any thoughts on this?

Not sure I have a strong opinion there.  We do have various tags meant to
ensure proper credit; I would lean toward using those when possible rather
than including long change histories that, in the long term, don't help
readers to understand why the patch was applied.

Thanks,

jon
