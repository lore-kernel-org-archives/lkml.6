Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeBTROO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:14:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:9605 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbeBTRON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:14:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="scan'208";a="176714675"
Message-ID: <1519146846.6941.1.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm: use kmemdup() to copy the event log
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-integrity@vger.kernel.org
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Thiebaud Weksteen <tweek@google.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Date: Tue, 20 Feb 2018 19:14:06 +0200
In-Reply-To: <7756fff1-ec94-1c26-9bbd-938337bc3c45@redhat.com>
References: <20180220114129.9300-1-jarkko.sakkinen@linux.intel.com>
         <7756fff1-ec94-1c26-9bbd-938337bc3c45@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-20 at 15:26 +0100, Javier Martinez Canillas wrote:
> On 02/20/2018 12:41 PM, Jarkko Sakkinen wrote:
> > Replaced kmalloc() + memcpy() in tpm_eventlog_efi.c and
> > tpm_eventlog_of.c.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> 
> Looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

/Jarkko
