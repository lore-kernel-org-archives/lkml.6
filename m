Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeEKKTo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:19:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:53165 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeEKKTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:19:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="55026393"
Date: Fri, 11 May 2018 13:19:38 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm_tis: verify locality released before returning from
 release_locality
Message-ID: <20180511101938.GF20210@linux.intel.com>
References: <20180505195453.10431-1-jsnitsel@redhat.com>
 <20180505200315.x7jt33j7psizmfyi@cantor>
 <e2d0e88a-d4b7-9a4e-45c5-b2409d6c6cab@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2d0e88a-d4b7-9a4e-45c5-b2409d6c6cab@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:21:39PM +0200, Laurent Bigonville wrote:
> Le 05/05/18 à 22:03, Jerry Snitselaar a écrit :
> > On Sat May 05 18, Jerry Snitselaar wrote:
> > > [...]
> > > 
> > 
> > Laurent,
> 
> Hello Jerry,
> 
> > Can you try this patch with your system since it is the one
> > that has exhibited the problem so far. I've tested on a
> > tpm2.0 and tpm1.2 system here.
> 
> I just tested the patch and the driver is loading fine again and the device
> in /dev is present again, so it seems to work.
> 
> But for some reason the tpm is again locked (for no visible reason) due to
> "dictionary attack" so I cannot test further ATM :/
> 
> Regards,
> 
> Laurent
> 
> > 
> > Regards,
> > Jerry
> 

Can you response with the tested-by tag as soon as you can? Before we
have tested-by, I cannot land the fix.

/Jarkko
