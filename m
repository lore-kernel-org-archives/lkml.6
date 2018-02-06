Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeBFPZc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:25:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbeBFPZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:25:22 -0500
Date: Tue, 6 Feb 2018 16:23:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Colin King <colin.king@canonical.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][btrfs-next] Btrfs: extent map selftest: add missing void
 parameter to btrfs_test_extent_map
Message-ID: <20180206152307.GC31890@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Colin King <colin.king@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180108230632.8101-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108230632.8101-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2018 at 11:06:32PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Add a missing void parameter to function btrfs_test_extent_map, fixes
> sparse warning:
> 
> warning: non-ANSI function declaration of function 'btrfs_test_extent_map'
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Added to next, thanks.
