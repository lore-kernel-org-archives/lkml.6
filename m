Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeDSQpC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:45:02 -0400
Received: from imap.thunk.org ([74.207.234.97]:33518 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753622AbeDSQpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:45:00 -0400
Date: Thu, 19 Apr 2018 12:44:56 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "zhenwei.pi" <zhenwei.pi@youruncloud.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4 : fix comments in ext4_swap_extents
Message-ID: <20180419164456.GI23194@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, "zhenwei.pi" <zhenwei.pi@youruncloud.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1521448449-25916-1-git-send-email-zhenwei.pi@youruncloud.com>
 <20180419145028.44fqs4wy5ofhvn5z@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419145028.44fqs4wy5ofhvn5z@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:50:28PM +0200, Jan Kara wrote:
> On Mon 19-03-18 16:34:09, zhenwei.pi wrote:
> > "mark_unwritten" in comment and "unwritten" in variable
> > argument lists is mismatch.
> > 
> > Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
> 
> This seems to have fallen through cracks. The patch looks good to me. Ted,
> can you please merge it? Thanks!

It landed in 4.17-rc1, commit id: dcae058a8da9c

Cheers,

					- Ted
