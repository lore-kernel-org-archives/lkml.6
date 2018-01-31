Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeAaVqg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:46:36 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42931 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752098AbeAaVqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:46:35 -0500
X-ME-Sender: <xms:OjlyWrdh-5x69FsWSu1mS0G-g_8GCEhR94WC0vmDZPDsdXqGUu069g>
Date: Thu, 1 Feb 2018 08:46:30 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Subject: checkpatch changes for 4.16
Message-ID: <20180131214630.GF11433@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Can I please bother you with a maintainer question.  I know everyone is
super busy right now, I'm asking for a smidgen of your time instead of
doing it wrong and taking up some of Linus' time since it's merge window
and all that.

I have the checkpatch set queued ready to do a GIT PULL to Linus.  My
concern is that the subject line may not be unique if checkpatch changes
are coming in from various trees this merge window. I have tagged the
pull request with

	checkpatch-4.16-rc1

with the subject line

	[GIT PULL] checkpatch changes for 4.16-rc1

If there are no other changes to checkpatch going in this merge window
then this issue dissolves.  If there are, should I add something to the
subject line to ensure it is unique?

Thanks and sorry for targeting you with this question, I'm sure you have
better things to do also.

	Tobin
