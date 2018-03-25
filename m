Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeCYQOr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 12:14:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46577 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCYQOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 12:14:46 -0400
Date: Sun, 25 Mar 2018 09:02:31 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: move /proc/sysvipc creation to where it belongs
Message-ID: <20180325160231.nbg5deo63sydyfqx@linux-n805>
References: <20180216161732.GA10297@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180216161732.GA10297@avx2>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Alexey Dobriyan wrote:

>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked. However, a small redundant description might be nice.

"
Move the proc_mkdir() call within the sysvipc subsystem such that we avoid
polluting proc_root_init() with petty cpp.
"

Thanks,
Davidlohr
