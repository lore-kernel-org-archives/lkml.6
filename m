Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeBSRPf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:15:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753228AbeBSRPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:15:33 -0500
Date: Mon, 19 Feb 2018 12:15:32 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Milan Broz <gmazyland@gmail.com>, NeilBrown <neilb@suse.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DM Regression in 4.16-rc1 - read() returns data when it shouldn't
Message-ID: <20180219171531.GA27498@redhat.com>
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <5fca4e3f-536c-9c52-31bb-927e8ab5b6c8@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fca4e3f-536c-9c52-31bb-927e8ab5b6c8@leemhuis.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19 2018 at  8:44am -0500,
Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> JFYI: This issues is tracked in the regression reports for Linux 4.16
> (http://bit.ly/lnxregrep416 ) with this id:
> 
> Linux-Regression-ID: lr#9e195f
> 
> Please include this line in the comment section of patches that are
> supposed to fix the issue. Please also mention the string once in other
> mailinglist threads or different bug tracking entries if you or someone
> else start to discuss the issue there. By including that string you make
> it a whole lot easier to track where an issue gets discussed and how far
> patches to fix it have made it. For more details on this please see
> here: http://bit.ly/lnxregtrackid
> 
> Thx for your help. Ciao, Thorsten

The fix was already merged by Linus on Friday, see:
git.kernel.org/linus/8dd601fa8317243be887458c49f6c29c2f3d719f

But moving forward I have no interest in sprinkling external metadata
references in Linux commit headers. 

Seems more like you're engineering something that gives you, and
possibly a select few others, meaning but that is make work for all
Linux maintainers.

Mike
