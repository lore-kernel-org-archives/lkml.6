Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeCTPp4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:45:56 -0400
Received: from ms.lwn.net ([45.79.88.28]:43952 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTPpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:45:55 -0400
Date: Tue, 20 Mar 2018 09:45:54 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] x86: Force asm-goto
Message-ID: <20180320094554.2bc49dea@lwn.net>
In-Reply-To: <20180319154717.652679334@infradead.org>
References: <20180319154124.337947038@infradead.org>
        <20180319154717.652679334@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018 16:41:25 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> A primary prerequisite for this is of course that the compiler
> supports asm-goto. This effecively lifts the minimum GCC version to
> build an x86 kernel to gcc-4.5.

Given that, how about a patch to Documentation/Changes to reflect the new
reality?  It's not in RST yet, so you should be able to go there without
ill effect :)

Thanks,

jon
