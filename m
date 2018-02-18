Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeBRNSj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:18:39 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38188 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeBRNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:18:36 -0500
X-Google-Smtp-Source: AH8x224Rw3Ft27ipPmi4JZW9ZDCDStlyFIMA9GAorWDbjJAS/n8Y9dLW9LL8CPen+pg9z6jqipbdlw==
Date: Sun, 18 Feb 2018 05:18:32 -0800
From: Tejun Heo <tj@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] pata_arasan_cf: Move two variable assignments in
 arasan_cf_probe()
Message-ID: <20180218131832.GA695913@devbig577.frc2.facebook.com>
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
 <0f5492bc-d239-401e-6f77-a27897e4ede5@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f5492bc-d239-401e-6f77-a27897e4ede5@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 05:00:11PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 16:42:26 +0100
> 
> Move assignments for the local variables "irq_handler" and "pdata"
> so that their setting will only be performed after a call
> of the function "devm_kzalloc" succeeded by this function.
> Thus adjust a corresponding if statement.

I'm not gonna apply this.  If there's something preventing the
compiler from optimizing it, the right thing to do is fixing that.

Thanks.

-- 
tejun
