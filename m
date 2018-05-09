Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935232AbeEIOv0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:51:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:38735 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934517AbeEIOvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:51:25 -0400
Date: Wed, 9 May 2018 16:51:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thiebaud Weksteen <tweek@google.com>, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ltp <ltp@lists.linux.it>
Subject: Re: [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
Message-ID: <20180509145121.z3jmvznojhi5mjiz@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-3-tweek@google.com>
 <20180420053926.GB15364@linux.intel.com>
 <1525725397.3551.10.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525725397.3551.10.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> [Cc'ing Petr Vorel and the ltp mailing list]

> Hi Jarrko,

> On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> > On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

> I just noticed this is queued in your next branch.

> Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
> tests includes walking the TPM binary_runtime_measurements in order to
> calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
> measurement in the IMA measurement list.

Did you meant that this commit ([2]) in linux-tpmdd/next changed location of
binary_runtime_measurements in sysfs?

IMHO these commits ([1], [2], [3]) just put source code into eventlog/ subdirectory:

> Mimi

Kind regards,
Petr

[1] 75d647f5de69 tpm: Move eventlog declarations to its own header
[2] 9b01b5356629 tpm: Move shared eventlog functions to common.c
[3] 0bfb23746052 tpm: Move eventlog files to a subdirectory
