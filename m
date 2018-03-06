Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeCFPjl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:39:41 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34644 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeCFPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:39:39 -0500
X-Google-Smtp-Source: AG47ELsJ1KDfl8DzuvKFH35s5RNJj/AECFeRX1sJ+w171kIODWJiTuG6z2ZeZ0Rh115YjuT0P+D96A==
Date: Tue, 6 Mar 2018 08:39:36 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm_crb: use __le64 annotated variable for response
 buffer address
Message-ID: <20180306153936.GA13395@ziepe.ca>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180304121205.16934-3-tomas.winkler@intel.com>
 <20180305130320.GC3425@linux.intel.com>
 <20180306082821.GB5705@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306082821.GB5705@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:28:21AM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 05, 2018 at 03:03:20PM +0200, Jarkko Sakkinen wrote:
> > On Sun, Mar 04, 2018 at 02:12:05PM +0200, Tomas Winkler wrote:
> > > This suppresses sparse warning
> > > drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64
> > > 
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > >  drivers/char/tpm/tpm_crb.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > The guideline is that you should describe what is wrong rather than
> > copy-paste the sparse message.
> 
> Jason, didn't yo give the feedback to some patch 1-2 years ago that
> instead of copy-pasting parse error one should write a clear commit
> msg or is this OK?

The standard is to give some explaination why the tool complaint is
valid and then if suitable include the tool complaint itself.

Eg bad:

Fix sparse warning on resp

Good:

use __le64 annotated variable for response buffer address

IMHO, the subject line sufficiently describes the patch, and it is
generally OK to clip the tool warning into the body..

Jason
