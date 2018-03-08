Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbeCHCvN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:51:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:58073 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934149AbeCHCvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:51:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,438,1515484800";
   d="scan'208";a="32198981"
Date: Thu, 8 Mar 2018 10:42:07 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "Du, Changbin" <changbin.du@intel.com>, mingo@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Include linux trace docs to Sphinx TOC tree
Message-ID: <20180308024207.x7mxbo75gtk433is@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
 <20180227093421.yd674oaklthaljgh@intel.com>
 <20180227174337.37ecb348@vmware.local.home>
 <20180307104649.4db521a5@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307104649.4db521a5@lwn.net>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 10:46:49AM -0700, Jonathan Corbet wrote:
> On Tue, 27 Feb 2018 17:43:37 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 27 Feb 2018 17:34:22 +0800
> > "Du, Changbin" <changbin.du@intel.com> wrote:
> >
> > > Ten days past, will you accept this serias? Thank you!
> > 
> > Currently I'm very overloaded with other code that needs to get done
> > ASAP, and I need to balance what is critical and what is not. I don't
> > have time to review this, as this isn't critical, and can wait.
> > 
> > If Jon can review it to make sure that it doesn't change the
> > readability of the text, then I'll trust his judgment. 
> 
> So I've spent a while working through the patches.  I think it's a
> well-done RST conversion carried out with a light hand; I do not believe
> there are any readability issues with the resulting text files.
> 
> I will note that the series adds some new build warnings:
> 
> > Documentation/trace/events.rst:45: WARNING: Inline emphasis start-string without end-string.
> > Documentation/trace/events.rst:49: WARNING: Inline emphasis start-string without end-string.
> > Documentation/trace/events.rst:193: WARNING: Inline emphasis start-string without end-string.
> > Documentation/trace/events.rst:114: WARNING: Unknown target name: "common".
> > Documentation/trace/ftrace.rst:2620: WARNING: Inline emphasis start-string without end-string.
> 
> These point to places where the resulting formatted docs are, in fact,
> incorrect.  I had to append the attached patch to the series to make those
> problems go away.  The warnings are there for a purpose!
> 
> Anyway, with that, the patch series is applied.  Thanks for helping to
> improve the docs, and my apologies for taking so long to get to this.
> 
> jon
> 
I am also appriciated for your review. And I am glade to see these docs can appear
in the new beautiful html documentation! Thnak you.

- changbin
