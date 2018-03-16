Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeCPIsg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:48:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeCPIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:48:35 -0400
Date: Fri, 16 Mar 2018 01:48:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de
Subject: Re: [PATCH v2 16/36] fs: add ksys_dup{,3}() helper; remove in-kernel
 calls to sys_dup{,3}()
Message-ID: <20180316084834.GE4151@infradead.org>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-17-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315190529.20943-17-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 08:05:09PM +0100, Dominik Brodowski wrote:
> Using ksys_dup() and ksys_dup3() as helper functions allows us to
> avoid the in-kernel calls to the sys_dup() and sys_dup3() syscalls.

do_dup/dup3 or kern_dup/dup3, please.
