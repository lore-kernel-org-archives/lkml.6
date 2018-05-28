Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939843AbeE1QNx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:13:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933474AbeE1QNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:13:48 -0400
Date: Mon, 28 May 2018 12:35:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Chengguang Xu <cgxu519@gmx.com>
Cc: linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jlayton@redhat.com,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/affs: fix potential memory leak in option parsing
Message-ID: <20180528103508.GS6649@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chengguang Xu <cgxu519@gmx.com>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <1526963065-21134-1-git-send-email-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526963065-21134-1-git-send-email-cgxu519@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:24:25PM +0800, Chengguang Xu wrote:
> When specifying option 'prefix' multiple times,
> current option parsing will cause memory leak.
> Hence, call kfree for previous one in this case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Thanks, the patch and others that may queue up will be in my git tree
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git in a
branch with 'affs' somewhere in the name.
