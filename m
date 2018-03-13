Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeCMIjl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:39:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:19589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbeCMIjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:39:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="38323153"
Message-ID: <1520930375.20980.213.camel@gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Ming Lei <ming.lei@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Mar 2018 10:39:35 +0200
In-Reply-To: <20180313083535.GA21612@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
         <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
         <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
         <20180309012458.GD5228@ming.t460p>
         <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
         <20180309120833.GB30257@ming.t460p>
         <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
         <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
         <1520926721.20980.210.camel@gmail.com> <20180313083535.GA21612@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 16:35 +0800, Ming Lei wrote:
> Then looks this issue need to fix by making possible CPU count
> accurate
> because there are other resources allocated according to
> num_possible_cpus(),
> such as percpu variables.

Short term the regression should be fixed. It is already v4.16-rc6, we
have little time left.

Longer term, yeah, I agree. Kernel's notion of possible CPU count
should be realistic.

Artem.
