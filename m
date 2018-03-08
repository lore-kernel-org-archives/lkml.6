Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeCHSep (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:34:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbeCHSeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:34:44 -0500
Date: Thu, 8 Mar 2018 18:34:42 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/5] sysctl: Enable easy addition of range showing sysctl
 parameters
Message-ID: <20180308183442.GJ4449@wotan.suse.de>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520454869-13871-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:34:24PM -0500, Waiman Long wrote:
> 
>   % cat msgmni_range
>   [0, 32768]

All that sounds promising but I think you are jumping a few
steps ahead of what needs to get done. Let's first sort out the
first series well.

  Luis
