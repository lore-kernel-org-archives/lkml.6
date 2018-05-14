Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeENMDq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:03:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeENMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:03:45 -0400
Date: Mon, 14 May 2018 05:03:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Rob Herring <robh@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] sh: switch to NO_BOOTMEM
Message-ID: <20180514120343.GB5265@infradead.org>
References: <20180511134559.13464-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511134559.13464-1-robh@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> unflattening could also fix this, but removing bootmem is desired. So
> enable NO_BOOTMEM on SH like other architectures have done.

Can you send out similarly shoot in the wild conversion for the
remaining architectures while you are at it?  We still seem to be
missing: alpha, c6x, hexagon, ia64, m68k, mips, nios2 and unicore32.
