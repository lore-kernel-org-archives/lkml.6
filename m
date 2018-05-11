Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeEKPN1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:13:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeEKPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:13:25 -0400
Date: Fri, 11 May 2018 08:13:20 -0700
From: Darren Hart <dvhart@infradead.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: futex: delete RUN_TESTS and EMIT_TESTS
 overrides
Message-ID: <20180511151320.GA6391@fury>
References: <20180502211848.22404-1-shuah@kernel.org>
 <20180502211848.22404-2-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502211848.22404-2-shuah@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 03:18:45PM -0600, Shuah Khan (Samsung OSG) wrote:
> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
> lib.mk. Common defines work just fine and there is no need to define
> custom overrides.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

I was concerned because this override was a deliberate decision made in:

9705315b7562 selftests/futex: Update Makefile to use lib.mk

But reviewing lib.mk today, the RUN_TESTS and EMIT_TESTS perform the same
function running TEST_PROGS.

Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>

-- 
Darren Hart
VMware Open Source Technology Center
