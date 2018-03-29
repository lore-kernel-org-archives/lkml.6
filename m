Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeC2S4s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:56:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbeC2S4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:56:47 -0400
Date: Thu, 29 Mar 2018 18:56:45 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v5 1/9] sysctl: Add flags to support min/max range
 clamping
Message-ID: <20180329185645.GQ30543@wotan.suse.de>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
 <1521224030-2185-2-git-send-email-longman@redhat.com>
 <20180317011021.GB4449@wotan.suse.de>
 <35f54e8f-b80e-aa3b-b008-79ba7ca3bff2@redhat.com>
 <20180329181515.GL30543@wotan.suse.de>
 <3e2b8e6a-f6d1-f80a-ed43-e937d8ca8383@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2b8e6a-f6d1-f80a-ed43-e937d8ca8383@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 02:47:18PM -0400, Waiman Long wrote:
> On 03/29/2018 02:15 PM, Luis R. Rodriguez wrote:
> > On Mon, Mar 19, 2018 at 11:39:19AM -0400, Waiman Long wrote:
> >> On 03/16/2018 09:10 PM, Luis R. Rodriguez wrote:
> >>> On Fri, Mar 16, 2018 at 02:13:42PM -0400, Waiman Long wrote:
> >>>> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table
> >>>> entry, any update from the userspace will be clamped to the given
> >>>> range without error if either the proc_dointvec_minmax() or the
> >>>> proc_douintvec_minmax() handlers is used.
> >>> I don't get it.  Why define a generic range flag when we can be mores specific and
> >>> you do that in your next patch. What's the point of this flag then?
> >>>
> >>>   Luis
> >> I was thinking about using the signed/unsigned bits as just annotations
> >> for ranges for future extension. For the purpose of this patchset alone,
> >> I can merge the three bits into just two.
> > Only introduce flags which you will actually use in the same patch series.
> >
> >   Luis
> 
> Yes, will do. Since the merge window is coming, should I wait until it
> is over to send out the new patch?

Probably best. May be too tight for review now if Linus spins out a release
this weekend.

  Luis
