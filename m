Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423034AbeCBIi2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:38:28 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:48060 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422939AbeCBIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:38:26 -0500
From: Richard Weinberger <richard@nod.at>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] uml: Fix build with recent glibc
Date: Fri, 02 Mar 2018 09:39:48 +0100
Message-ID: <2427974.ifqE8EITFz@blindfold>
In-Reply-To: <20180301183023.00002ddf@intel.com>
References: <20180301030844.23448-1-andi@firstfloor.org> <20180301183023.00002ddf@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. März 2018, 03:30:23 CET schrieb Jesse Brandeburg:
> On Wed, 28 Feb 2018 19:08:44 -0800
> 
> Andi Kleen <andi@firstfloor.org> wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Newer glibc did some include namespace "cleanups" and removed
> > struct ucontext and friends. This already broke a lot of software,
> > and UML seems to be the latest victim.
> > 
> > Use the typedefs which are still available. They also work on
> > older glibcs.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> same patch that I sent on Feb 1st.  Hope you can get more traction than
> I did.
> 
> https://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg
> 10071.html
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Sorry guys, due to various reasons in the last months I had not much time for 
UML. But things get better now.
The fix from the first sender is in -next and will hit Linus' tree soon.

Thanks,
//richard
