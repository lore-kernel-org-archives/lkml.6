Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934216AbeCGPzA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:55:00 -0500
Received: from ms.lwn.net ([45.79.88.28]:58150 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933728AbeCGPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:54:56 -0500
Date: Wed, 7 Mar 2018 08:54:54 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org\" <linux-security-module@vger.kernel.org>, "@lwn.net,
        linux-kernel@vger.kernel.org,
        " <linux-kernel@vger.kernel.org>"@lwn.net
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Message-ID: <20180307085454.2c820a13@lwn.net>
In-Reply-To: <1520361396.10396.396.camel@linux.vnet.ibm.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
        <20180305125642.GA3425@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
        <20180306074932.GB3624@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
        <1520353933.5393.21.camel@HansenPartnership.com>
        <1520361396.10396.396.camel@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Mar 2018 13:36:36 -0500
Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> I've heard that some maintainers are moving away from cover letters,
> since they are not include in the git repo and are lost.

If I get a patch series with a cover letter that should be preserved, I
apply the series in a branch then do a no-ff merge; the cover letter can
then go into the merge commit.  There's no reason why cover letters need to
be lost.

jon
