Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeCZUKF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:10:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:51719 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeCZUKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:10:04 -0400
Date: Mon, 26 Mar 2018 12:57:45 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/3] drivers/irqchip: update supports_deactivate static
 key to modern api
Message-ID: <20180326195745.gg5w5q7iaarea73j@linux-n805>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-3-dave@stgolabs.net>
 <671202a1-4080-0104-abd8-4718c53dd61e@arm.com>
 <20180326135456.a6z6tvbx2kdqbopr@linux-n805>
 <56064180-053b-2987-d10e-7e5f36c579a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <56064180-053b-2987-d10e-7e5f36c579a1@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018, Marc Zyngier wrote:
>Odd. I don't see how you can avoid this failure at link time...

yeah, I must have only compiled drivers/ or drivers/irqchip/.
Had I done a full build, I would have realized that I left out
all the static definitions Peter pointed out. Sending a v2.

Thanks,
Davidlohr
