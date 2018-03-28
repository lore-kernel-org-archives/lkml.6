Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbeC1N7S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:59:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:35113 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752572AbeC1N7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:59:17 -0400
Date: Wed, 28 Mar 2018 06:46:58 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] drivers/irqchip: Update supports_deactivate static
 key to modern api
Message-ID: <20180328134658.rtqprqhy4y54hswp@linux-n805>
References: <20180326210929.5244-1-dave@stgolabs.net>
 <20180326210929.5244-3-dave@stgolabs.net>
 <39333f71-699c-b3b4-ec9d-eb6e83585b3d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <39333f71-699c-b3b4-ec9d-eb6e83585b3d@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Marc Zyngier wrote:

>Looks good to me. How do you want to get this patch merged? Either you
>deal with it as part of this series, (and in which case please add my
>Ack on it), or I can take it via the irqchip tree.

Considering Ingo picked up the patches in his jurisdiction, I think it
is preferable if you pick this one up yourself.

Thanks,
Davidlohr
