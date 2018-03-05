Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeCEORk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:17:40 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:56758 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932183AbeCEORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:17:38 -0500
Subject: Re: regression: SCSI/SATA failure
To: dedekind1@gmail.com, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Herring, Jan-kristian Augustin"
        <jan-kristian.augustin.herring@intel.com>
References: <1519311270.2535.53.camel@intel.com>
 <1519311443.2535.55.camel@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <c405f270-1bea-d34e-259e-fd9f372a495c@leemhuis.info>
Date: Mon, 5 Mar 2018 15:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519311443.2535.55.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1520259458;868b42e1;
X-HE-SMSGID: 1esqvh-0007U5-Sb
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! On 22.02.2018 15:57, Artem Bityutskiy wrote:
> On Thu, 2018-02-22 at 16:54 +0200, Artem Bityutskiy wrote:
>> one of our test box Skylake servers does not boot with v4.16-rcX.
>> Bisection lead us to this commit:
>> 84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs
>> Reverting this single commit fixes the problem.

Artem, is this issue still happening? I still have it in my list of
regressions. Side note: I accidentally noticed people continue working
in the area that 84676c1f21e8 touched;  see
https://marc.info/?l=linux-block&m=152021971313902&w=2 ("[PATCH V2 5/5]
genirq/affinity: irq vector spread among online CPUs as far as
possible"). I wonder if that might be related in any way. Ciao, Thorsten
