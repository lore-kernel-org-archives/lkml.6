Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935311AbeBNU2s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:28:48 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38578 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932096AbeBNU2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:28:45 -0500
Message-ID: <1518640122.3223.46.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.16-rc1
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 14 Feb 2018 12:28:42 -0800
In-Reply-To: <1518639578.3223.44.camel@HansenPartnership.com>
References: <1518639578.3223.44.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 12:19 -0800, James Bottomley wrote:
> These are mostly fixes for problems with merge window code.  In
> addition we have one doc update (alua) and two dead code removals
> (aiclib and octogon) a spurious assignment removal (csiostor) and a
> performance improvement for storvsc involving better interrupt
> spreading and increasing the command per lun handling.

Actually, can I cancel this.  We've had a tree rebase between mine and
Martin's which means I need to do a reset.  I'll do that now and submit
a new pull request next week.

Thanks,

James
