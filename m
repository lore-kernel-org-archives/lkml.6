Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeEUCpf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:45:35 -0400
Received: from imap.thunk.org ([74.207.234.97]:59954 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbeEUCpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:45:33 -0400
Date: Sun, 20 May 2018 22:45:24 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sean Fu <fxinrong@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Remove unnecessary NULL checks in ext4.
Message-ID: <20180521024524.GG4464@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sean Fu <fxinrong@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517915730-11198-1-git-send-email-fxinrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517915730-11198-1-git-send-email-fxinrong@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 07:15:30PM +0800, Sean Fu wrote:
> NULL check is done in kmem_cache_destroy. So remove NULL checks in ext4.
> 
> Signed-off-by: Sean Fu <fxinrong@gmail.com>

Thanks, applied.  I clarified the patch summary to be:

    ext4: remove NULL check before calling kmem_cache_destroy()

    	  	      	    	   	   - Ted
