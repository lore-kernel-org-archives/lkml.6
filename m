Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753762AbeD2Qv1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:51:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37795 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbeD2QvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:51:25 -0400
X-Google-Smtp-Source: AB8JxZpupn+xU/uvbsPLmzDjW/MPtHseZrDrRZwezgrTnfiZiBkL+6U5CJbC47620UhlcKP8ICNGEA==
Date: Sun, 29 Apr 2018 19:51:24 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: Mark up large pm4/5 constants with UL
Message-ID: <20180429165124.frht65qz6bqoklwd@kshutemo-mobl1>
References: <20180429114832.14552-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429114832.14552-1-chris@chris-wilson.co.uk>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 12:48:32PM +0100, Chris Wilson wrote:
> To silence sparse while maintaining compatibility with the assembly, use
> _UL which conditionally only appends the UL suffix for C code.

http://lkml.kernel.org/r/nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm

-- 
 Kirill A. Shutemov
