Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeEUClY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:41:24 -0400
Received: from imap.thunk.org ([74.207.234.97]:59930 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeEUClW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:41:22 -0400
Date: Sun, 20 May 2018 22:41:09 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Wang Long <wanglong19@meituan.com>
Cc: darrick.wong@oracle.com, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: remove the conditional test
Message-ID: <20180521024109.GF4464@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Wang Long <wanglong19@meituan.com>, darrick.wong@oracle.com,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517840679-5902-1-git-send-email-wanglong19@meituan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517840679-5902-1-git-send-email-wanglong19@meituan.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 10:24:39PM +0800, Wang Long wrote:
> kmem_cache_destroy already handles null pointers, so we can remove the
> conditional test entirely.
> 
> This patch also set NULL after the kmem_cache_destroy in function
> jbd2_journal_destroy_handle_cache.
> 
> Signed-off-by: Wang Long <wanglong19@meituan.com>

Thanks; I clarified the patch summary to be:

    jbd2: remove NULL check before calling kmem_cache_destroy()

and have applied it.  Apologies for not getting to this earlier.

    	 	      		    - Ted
