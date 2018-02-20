Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeBTP0t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeBTP0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:26:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C2420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 20 Feb 2018 10:26:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/17] trace doc: convert trace/ftrace.txt to rst format
Message-ID: <20180220102644.38218f27@gandalf.local.home>
In-Reply-To: <20180220132700.iz27aumgy5o2agp3@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
        <1518845990-20733-6-git-send-email-changbin.du@intel.com>
        <CAOFm3uE78DosAoZDNfD_YRaGPhpxW=4_cd3d9MafV-mdk5BuxQ@mail.gmail.com>
        <20180220132700.iz27aumgy5o2agp3@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018 21:27:00 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> > > @@ -0,0 +1,3332 @@
> > > +========================
> > > +ftrace - Function Tracer
> > > +========================
> > > +
> > > +Copyright 2008 Red Hat Inc.
> > > +
> > > +:Author:   Steven Rostedt <srostedt@redhat.com>
> > > +:License:  The GNU Free Documentation License, Version 1.2
> > > +          (dual licensed under the GPL v2)  
> > 
> > 
> > Do you mind using an SPDX id per [1] rather that this?

One it should be a separate patch. Two, how does SPDX deal with dual
licenses?

-- Steve
