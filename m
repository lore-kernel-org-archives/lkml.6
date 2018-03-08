Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936146AbeCHRwY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:52:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44187 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932087AbeCHRwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:52:22 -0500
Date: Thu, 8 Mar 2018 17:52:19 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/6] sysctl: Add kdoc comments to
 do_proc_do{u}intvec_minmax_conv_param
Message-ID: <20180308175219.GC4449@wotan.suse.de>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <1519926220-7453-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519926220-7453-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 12:43:36PM -0500, Waiman Long wrote:
> Kdoc comments are added to the do_proc_dointvec_minmax_conv_param
> and do_proc_douintvec_minmax_conv_param structures thare are used
> internally for range checking.
> 
> The error codes returned by proc_dointvec_minmax() and
> proc_douintvec_minmax() are also documented.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
