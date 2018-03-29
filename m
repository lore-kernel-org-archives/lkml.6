Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeC2IeC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:34:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750707AbeC2IeB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:34:01 -0400
Date: Thu, 29 Mar 2018 10:33:58 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 0/5] Support perf -vv
Message-ID: <20180329083358.GA28857@krava>
References: <1522335382-11983-1-git-send-email-yao.jin@linux.intel.com>
 <20180329072006.yrsujdaayek2wpfo@gmail.com>
 <ef9f7e74-d94a-895d-fb26-35f2820fd95f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9f7e74-d94a-895d-fb26-35f2820fd95f@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 03:49:18PM +0800, Jin, Yao wrote:

SNIP

> > That would make it easier to grep around in the source looking for where code
> > related a particular features is located.
> > 
> 
> Good idea, thanks! I will support it in v4.
> 
> > BTW. #2: to the compulsive perfectionist in me "HAVE_DWARF_GETLOCATIONS" is now
> > sticking out like a sore thumb: it's the only library flag left that doesn't have
> > the _SUPPORT suffix. Rename it to HAVE_DWARF_GETLOCATIONS_SUPPORT perhaps?
> > 
> > Thanks,
> >
> > 	Ingo
> >
> 
> OK, I will rename it to HAVE_DWARF_GETLOCATIONS_SUPPORT in v4.

thanks for doing this, I'll ack the new version then

jirka
