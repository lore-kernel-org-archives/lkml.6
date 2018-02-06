Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBFOrF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:47:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:54609 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbeBFOq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:46:58 -0500
Date: Tue, 6 Feb 2018 15:44:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Colin King <colin.king@canonical.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][btrfs-next] btrfs: remove redundant check on ret and goto
Message-ID: <20180206144442.GA31890@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Colin King <colin.king@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180112165258.27431-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112165258.27431-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2018 at 04:52:58PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for a non-zero ret is redundant as the goto will jump to
> the very next statement anyway.  Remove this extraneous code.
> 
> Detected by CoverityScan, CID#1463784 ("Identical code for different
> branches")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Added to next, thanks.
