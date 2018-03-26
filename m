Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeCZWlw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:41:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCZWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:41:51 -0400
Date: Mon, 26 Mar 2018 15:41:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joe Perches <joe@perches.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Use octal not symbolic permissions
Message-Id: <20180326154149.4045ec03645d6983de6f11b3@linux-foundation.org>
In-Reply-To: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
References: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 15:22:32 -0700 Joe Perches <joe@perches.com> wrote:

> mm/*.c files use symbolic and octal styles for permissions.
> 
> Using octal and not symbolic permissions is preferred by many as more
> readable.
> 
> https://lkml.org/lkml/2016/8/2/1945
> 
> Prefer the direct use of octal for permissions.

Thanks.  I'll park this until after -rc1 because the
benefit-to-potential-for-whoopsies ratio is rather low.
