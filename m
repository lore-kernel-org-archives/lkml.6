Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164376AbeCBCa0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:30:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:16665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164179AbeCBCaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:30:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="179258885"
Date: Thu, 1 Mar 2018 18:30:23 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: <richard@nod.at>, Andi Kleen <ak@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        jesse.brandeburg@intel.com
Subject: Re: [uml-devel] [PATCH] uml: Fix build with recent glibc
Message-ID: <20180301183023.00002ddf@intel.com>
In-Reply-To: <20180301030844.23448-1-andi@firstfloor.org>
References: <20180301030844.23448-1-andi@firstfloor.org>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018 19:08:44 -0800
Andi Kleen <andi@firstfloor.org> wrote:

> From: Andi Kleen <ak@linux.intel.com>
> 
> Newer glibc did some include namespace "cleanups" and removed
> struct ucontext and friends. This already broke a lot of software,
> and UML seems to be the latest victim.
> 
> Use the typedefs which are still available. They also work on
> older glibcs.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

same patch that I sent on Feb 1st.  Hope you can get more traction than
I did.

https://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg10071.html

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
