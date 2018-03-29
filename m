Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeC2SxX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:53:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbeC2SxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:53:22 -0400
Date: Thu, 29 Mar 2018 18:53:19 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v5 0/9] ipc: Clamp *mni to the real IPCMNI limit &
 increase that limit
Message-ID: <20180329185319.GP30543@wotan.suse.de>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
 <20180329181935.GN30543@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329181935.GN30543@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 06:19:35PM +0000, Luis R. Rodriguez wrote:
> Andrew,
> 
> please drop these patches until further notice. I would recommend we avoid merging
> these patches until we get proper Acked-by for the entire set. Waiman has a bit more
> work to do and even after the 5th iteration this is not right yet.

Sorry or the noise, I see they are not merged.

  Luis
