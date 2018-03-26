Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeCZQcw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:32:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:54948 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752522AbeCZQcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:32:50 -0400
Date: Mon, 26 Mar 2018 10:32:49 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Gary R Hook <gary.hook@amd.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/CodingStyle: Add an example for braces
Message-ID: <20180326103249.42789cdb@lwn.net>
In-Reply-To: <724fc548-0e40-11a3-2a9b-3dd0db0de880@amd.com>
References: <152114372879.3142.8833111074324091904.stgit@taos>
        <20180321091701.7d56445d@lwn.net>
        <87woy4iide.fsf@intel.com>
        <724fc548-0e40-11a3-2a9b-3dd0db0de880@amd.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 11:28:03 -0500
Gary R Hook <gary.hook@amd.com> wrote:

> Submitting a v3 because the example could better illuminate the options 
> by using loop construct inside of an if, addressing Jani's point but 
> without opening the door to later criticism.
> 
> I also like the verbage in v2/3 better, but I'll let Jonathan make the call.

As I told you, I was applying the first version; I did that last week.

> BTW which tree should these be developed against? I used torvalds, but 
> I'm not entirely sure that was the proper one?

The MAINTAINERS file will (almost) always answer that question for
you:	

	T:	git git://git.lwn.net/linux.git docs-next

For a patch like this it doesn't matter, since there's is no other work on
the file to conflict with.

THanks,

jon
