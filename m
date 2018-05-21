Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeEUCwq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:52:46 -0400
Received: from imap.thunk.org ([74.207.234.97]:59978 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbeEUCwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:52:44 -0400
Date: Sun, 20 May 2018 22:52:33 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        Li Xi <lixi@ddn.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: report delalloc reserve as non-free in statfs
 mangled by project quota
Message-ID: <20180521025233.GH4464@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>, Li Xi <lixi@ddn.com>,
        Jan Kara <jack@suse.cz>
References: <151756800585.979296.13086151972011935611.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151756800585.979296.13086151972011935611.stgit@buzz>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 01:40:05PM +0300, Konstantin Khlebnikov wrote:
> This reserved space isn't committed yet but cannot be used for allocations.
> For userspace it has no difference from used space. XFS already does this.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 689c958cbe6b ("ext4: add project quota support")

Applied, thanks.  Apologies for the delay in applying the patch.

					- Ted
