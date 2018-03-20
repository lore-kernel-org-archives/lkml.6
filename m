Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeCTMhk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:37:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35370 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbeCTMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:37:30 -0400
Date: Tue, 20 Mar 2018 13:37:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net,
        rjw@rjwysocki.net, lenb@kernel.org, hpa@zytor.com
Subject: Re: [PATCH 1/5] x86/smpboot: Add the missing description of
 possible_cpus
Message-ID: <20180320123712.GR4043@hirez.programming.kicks-ass.net>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-2-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320110432.28127-2-douly.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 07:04:28PM +0800, Dou Liyang wrote:

> +	possible_cpus=	[s390,x86_64] Use this to set hotpluggable cpus.
> +			This option sets possible_cpus bits in cpu_possible_map.
> +			Thus keeping the numbers of bits set constant even if
> +			the machine gets rebooted.

That description, esp. the last sentence, doesn't make any kind of sense
to me. What?
