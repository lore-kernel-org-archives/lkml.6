Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeEHQvR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:51:17 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36632 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbeEHQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:51:16 -0400
X-Google-Smtp-Source: AB8JxZpzyxcMOt/iKXekyIm0MlVQMFsBxiJBlXfOtMYVg0pn5R3hZe1/zFNOFxAFWe/CBWp6Y/IBmg==
Date: Tue, 8 May 2018 18:51:08 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jeff Layton <jlayton@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Tobin C. Harding" <me@tobin.cc>, SeongJae Park <sj38.park@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Helmut Grohne <h.grohne@intenta.de>
Subject: Re: [PATCH 05/18] docs: core-api: add cachetlb documentation
Message-ID: <20180508165108.GA10555@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <07b59879d34502828467f0190f941e23e08fdc81.1525684985.git.mchehab+samsung@kernel.org>
 <20180508100408.070fa171@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508100408.070fa171@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 10:04:08AM -0600, Jonathan Corbet wrote:
> On Mon,  7 May 2018 06:35:41 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > The cachetlb.txt is already in ReST format. So, move it to the
> > core-api guide, where it belongs.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> I think we could do a better job of this by integrating it with the
> kerneldoc comments.  Meanwhile, though, this is a step in the right
> direction, so I've applied it, thanks.

This depends on what you mean by "the right direction": IMO, breaking
in-sources references and get_maintainer.pl does not qualify as such.

  Andrea


> 
> jon
