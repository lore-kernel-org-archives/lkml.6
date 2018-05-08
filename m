Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeEHPTL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:19:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:35562 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbeEHPTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:19:10 -0400
Date: Tue, 8 May 2018 09:19:06 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Cai Zhiyong <caizhiyong@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: block: cmdline-partition.txt fixes and
 additions
Message-ID: <20180508091906.7d085bf4@lwn.net>
In-Reply-To: <dba389fc-2745-34b1-e33e-fc83f53eaf42@infradead.org>
References: <dba389fc-2745-34b1-e33e-fc83f53eaf42@infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2018 11:50:29 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Make the description of the kernel command line option "blkdevparts"
> a bit more flowing and readable.
> 
> Fix a few typos.
> Add the optional <size> and <offset> suffixes.
> Note that size can be "-" to indicate all of the remaining space.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

jon
