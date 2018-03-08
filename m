Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeCHNZ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:25:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:15161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755284AbeCHNZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:25:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="32301855"
Message-ID: <1520515521.20980.33.camel@gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Date: Thu, 08 Mar 2018 15:25:21 +0200
In-Reply-To: <1520515113.20980.31.camel@gmail.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
         <1520515113.20980.31.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 15:18 +0200, Artem Bityutskiy wrote:
> Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Link: https://lkml.kernel.org/r/1519311270.2535.53.camel@intel.com

And for completeness:
Linux-Regression-ID: lr#15a115
