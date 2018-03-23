Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCWPTU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:19:20 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41854 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751717AbeCWPTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:19:18 -0400
Date: Fri, 23 Mar 2018 16:19:13 +0100
From: Willy Tarreau <w@1wt.eu>
To: Maurice R Volaski <maurice.volaski@einstein.yu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Did kernel 3.11 never work?
Message-ID: <20180323151913.GG15012@1wt.eu>
References: <E513F076-24D5-4F67-A204-D2E6E1135FDE@einstein.yu.edu>
 <20180323145428.GF15012@1wt.eu>
 <8BF385DA-7EB8-446D-9005-64509D7C7CB8@einstein.yu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BF385DA-7EB8-446D-9005-64509D7C7CB8@einstein.yu.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 02:58:46PM +0000, Maurice R Volaski wrote:
> I'm trying to build a computer with network diagnostic tool,
> https://software.internet2.edu/ndt/ and it requires patches to the kernel,
> https://www.web10g.org/. The latest kernel for which there are patches, 3.17,
> doesn't compile with the patches, so I had to progressively retrogress until
> I can found one that did.

In my opinion you'd waste much less time trying to port these patches to
a more recent, still maintained kernel. 3.16 is still maintained by Ben,
and not too far from 3.17 (less than 3.11). You may have more luck there
and also more luck to get it to boot on a recent machine.

Also on web10g I'm seeing patches for kernels 3.2 to 3.4. 3.2 is also
still maintained by Ben. You can try this one, maybe it'll work, who
knows.

Willy
