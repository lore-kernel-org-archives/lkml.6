Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCWHng (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:43:36 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35754 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCWHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:43:35 -0400
Date: Fri, 23 Mar 2018 08:38:58 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: gitster@pobox.com
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: git send-email and sending the cover-letter to all cc addresses
 found in a patch series
Message-ID: <20180323073858.GA12077@light.dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-24-linux@dominikbrodowski.net>
 <20180322172959.GX4043@hirez.programming.kicks-ass.net>
 <CA+55aFwM8mMyZZ9wH2ExAkTKg9Mwie1hOtXz87ivi0nhsZ49Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwM8mMyZZ9wH2ExAkTKg9Mwie1hOtXz87ivi0nhsZ49Ug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:44:54AM -0700, Linus Torvalds wrote:
> On Thu, Mar 22, 2018 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > But why !? Either Cc me on more of the series such that the whole makes
> > sense, or better yet, write a proper Changelog.
> 
> This is a common issue. We should encourage people to always send at
> least the cover-page to everybody who gets cc'd, even if they don't
> get the whole series.

Will try to do that in future. Does git send-email have such an option? Or
do I have to specify all cc addresses in the cover letter manually? I found
some reference to an unresolved discussion on git@ of that topic in 2016, so
I might not be the only one who could make use of that feature...

Thanks,
	Dominik
