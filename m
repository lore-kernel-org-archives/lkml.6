Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeCLUx6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:53:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:48334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932326AbeCLUx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:53:56 -0400
Date: Mon, 12 Mar 2018 20:53:55 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 6/6] test_sysctl: Add range clamping test
Message-ID: <20180312205355.GC4449@wotan.suse.de>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-7-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520885744-1546-7-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:15:44PM -0400, Waiman Long wrote:
> Add a range clamping test for the msgmni sysctl parameter to verify

No! We don't want to test production values, please add a new test
entry which is similar but does *not* modify system production values!

  Luis
