Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967935AbeBOMCR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:02:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967843AbeBOMCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:02:15 -0500
Date: Thu, 15 Feb 2018 06:58:23 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Philipp Hahn <pmhahn@pmhahn.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] namei: fix hardlink speeling error
Message-ID: <20180215115823.qlxpq2wqqvvgxx4k@madcap2.tricolour.ca>
References: <68d4b8c4ad6b85d4336f2a2893e3ea04ffdc7794.1518661649.git.rgb@redhat.com>
 <4ed8e95b-0aa8-ae26-7ec4-e01235583e8f@pmhahn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed8e95b-0aa8-ae26-7ec4-e01235583e8f@pmhahn.de>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-15 10:57, Philipp Hahn wrote:
> Hello,
> 
> Am 15.02.2018 um 03:28 schrieb Richard Guy Briggs:
> > Fix handlink to hardlink.
> 
> and introduce a new sp*el*ling error in the subject line ;-)

That one was quite intentional for ironic effect.  I could have added an
extra "e" for exaggerated effect if you like.  :-)

As for filedescriptor, that one I chose to leave alone due to 7 other
instances (out of ~700), while handlink stood alone (out of 126 hardlink
without and 77 with space) and was clearly misspelled in the context of
the source file.

I can file a followup patch to fix all "filedescriptor" in the same
patch if desired, but I'm not so sure that one is warranted.

> Philipp

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
