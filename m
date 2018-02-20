Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeBTNfr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:35:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:48624 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbeBTNfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:35:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="36064880"
Date: Tue, 20 Feb 2018 21:27:00 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: changbin.du@intel.com, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/17] trace doc: convert trace/ftrace.txt to rst format
Message-ID: <20180220132700.iz27aumgy5o2agp3@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
 <1518845990-20733-6-git-send-email-changbin.du@intel.com>
 <CAOFm3uE78DosAoZDNfD_YRaGPhpxW=4_cd3d9MafV-mdk5BuxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uE78DosAoZDNfD_YRaGPhpxW=4_cd3d9MafV-mdk5BuxQ@mail.gmail.com>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Feb 20, 2018 at 08:28:24AM +0100, Philippe Ombredanne wrote:
> Changbin, Steven,
> 
> On Sat, Feb 17, 2018 at 6:39 AM,  <changbin.du@intel.com> wrote:
> > From: Changbin Du <changbin.du@intel.com>
> >
> > This converts the plain text documentation to reStructuredText format and
> > add it into Sphinx TOC tree. No essential content change.
> >
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  Documentation/trace/ftrace.rst | 3332 ++++++++++++++++++++++++++++++++++++++++
> >  Documentation/trace/ftrace.txt | 3220 --------------------------------------
> >  Documentation/trace/index.rst  |    1 +
> >  3 files changed, 3333 insertions(+), 3220 deletions(-)
> >  create mode 100644 Documentation/trace/ftrace.rst
> >  delete mode 100644 Documentation/trace/ftrace.txt
> >
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > new file mode 100644
> > index 0000000..636aa9bf
> > --- /dev/null
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -0,0 +1,3332 @@
> > +========================
> > +ftrace - Function Tracer
> > +========================
> > +
> > +Copyright 2008 Red Hat Inc.
> > +
> > +:Author:   Steven Rostedt <srostedt@redhat.com>
> > +:License:  The GNU Free Documentation License, Version 1.2
> > +          (dual licensed under the GPL v2)
> 
> 
> Do you mind using an SPDX id per [1] rather that this?
> 
> Steven, are you OK with this? Can you ack?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
> -- 
> Cordially
> Philippe Ombredanne

I leave this to Steven, since I just converted the format of this doc.

-- 
Thanks,
Changbin Du
