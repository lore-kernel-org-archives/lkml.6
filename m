Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934221AbeCEMQj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:16:39 -0500
Received: from foss.arm.com ([217.140.101.70]:48874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933036AbeCEMQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:16:38 -0500
Date: Mon, 5 Mar 2018 12:16:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Kostya Serebryany <kcc@google.com>
Subject: Re: [PATCH] kasan, arm64: clean up KASAN_SHADOW_SCALE_SHIFT usage
Message-ID: <20180305121641.GD8571@arm.com>
References: <44281e784702443f06edb837ec672984783a9621.1519923749.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44281e784702443f06edb837ec672984783a9621.1519923749.git.andreyknvl@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 06:07:12PM +0100, Andrey Konovalov wrote:
> This is a follow up patch to the series I sent recently that cleans up
> KASAN_SHADOW_SCALE_SHIFT usage (which value was hardcoded and scattered
> all over the code). This fixes the one place that I forgot to fix.
> 
> The change is purely aesthetical, instead of hardcoding the value for
> KASAN_SHADOW_SCALE_SHIFT in arch/arm64/Makefile, an appropriate variable
> is declared and used.

Cheers, I'll pick this up.

Will
