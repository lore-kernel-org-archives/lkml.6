Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeBIA1Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:27:25 -0500
Received: from ozlabs.org ([103.22.144.67]:47049 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBIA1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:27:24 -0500
Date: Fri, 9 Feb 2018 11:27:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: linux-next: build failure after merge of the btrfs-kdave tree
Message-ID: <20180209112722.38713da5@canb.auug.org.au>
In-Reply-To: <20180208234846.GF3003@suse.cz>
References: <20180209104057.0e999c19@canb.auug.org.au>
        <20180208234846.GF3003@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, 9 Feb 2018 00:48:46 +0100 David Sterba <dsterba@suse.cz> wrote:
>
> Right, I had fixed it in my local branch but did not push the update,
> sorry.  Current for-next, top commit 993b08a92e32 builds fine.

Thanks.

-- 
Cheers,
Stephen Rothwell
