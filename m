Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeCPInM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:43:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeCPInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:43:10 -0400
Date: Fri, 16 Mar 2018 01:43:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>, x86@kernel.org
Subject: Re: [PATCH v2 13/36] x86/ioport: add ksys_ioperm() helper; remove
 in-kernel calls to sys_ioperm()
Message-ID: <20180316084308.GB4151@infradead.org>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-14-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315190529.20943-14-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 08:05:06PM +0100, Dominik Brodowski wrote:
> Using this helper allows us to avoid the in-kernel calls to the sys_ioperm()
> syscall.

Why not do_ioperm or kernel_ioperm as for most other syscalls?
