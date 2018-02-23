Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBWDVg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:21:36 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53832 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750995AbeBWDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:21:35 -0500
Message-ID: <1519356093.4819.28.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.16-rc2
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 22 Feb 2018 22:21:33 -0500
In-Reply-To: <CA+55aFzaAa19T_Wn-PKasUX2txc8i1WMBpQPVQVzUdfUp1u3=w@mail.gmail.com>
References: <1519327705.4819.5.camel@HansenPartnership.com>
         <CA+55aFzaAa19T_Wn-PKasUX2txc8i1WMBpQPVQVzUdfUp1u3=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-22 at 16:37 -0800, Linus Torvalds wrote:
> On Thu, Feb 22, 2018 at 11:28 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-
> > fixes
> 
> When I pull that, I get something completely different from what you
> claim I should get. Much bigger, and a lot more commits.
> 
> Hmm?
> 
> Dropped.

OK, I see the problem, but I don't currently have an explanation for
how it happened.  The scsi-fixes tag somehow became attached to a push
of the misc tree for the next merge window instead of the fixes branch.

I've reset it to where it should be

commit 1bc5ad3a6acdcf56f83272f2de1cd2389ea9e9e2
Author: Manish Rangankar <manish.rangankar@cavium.com>
Date:   Sun Feb 11 22:48:41 2018 -0800

    scsi: qla4xxx: skip error recovery in case of register disconnect.

So it should all be correct if you re-pull.

I suppose it's good that the checks and balances of changelog +
diffstat caught this; I'll poke about in my current preparation scripts
to see if I can find out what went wrong.

James
