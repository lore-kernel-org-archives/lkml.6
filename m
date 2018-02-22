Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeBVO5d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:57:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:9606 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeBVO5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:57:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="206142929"
Message-ID: <1519311443.2535.55.camel@gmail.com>
Subject: Re: regression: SCSI/SATA failure
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Herring, Jan-kristian Augustin"
        <jan-kristian.augustin.herring@intel.com>
Date: Thu, 22 Feb 2018 16:57:23 +0200
In-Reply-To: <1519311270.2535.53.camel@intel.com>
References: <1519311270.2535.53.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-22 at 16:54 +0200, Artem Bityutskiy wrote:
> Hi Christoph,
> 
> one of our test box Skylake servers does not boot with v4.16-rcX.
> Bisection lead us to this commit:
> 
> 84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs
> 
> Reverting this single commit fixes the problem.

I meant to send the e-mail from the my @gmail.com address, sorry for
the company disclaimers that will probably be appended to the message.

Artem.
