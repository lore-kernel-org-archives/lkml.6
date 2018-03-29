Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeC2OeE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:34:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35816 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC2OeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:34:01 -0400
X-Google-Smtp-Source: AIpwx48s9OiueyffU8x4vpsA9GEMmAx7dyat/J7oKDmK4GBMO7qnALSllynVu3y74uQpABJ71cFCIw==
Date: Thu, 29 Mar 2018 16:33:58 +0200
From: Paolo Pisati <p.pisati@gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Message-ID: <20180329143358.GA4556@harukaze>
References: <1521808032-29645-1-git-send-email-p.pisati@gmail.com>
 <1521808032-29645-3-git-send-email-p.pisati@gmail.com>
 <CANk1AXRAXQ8cURb+ObS5SpaBKQLdoFFB6nmLTnmA1gQowmoVbw@mail.gmail.com>
 <CANk1AXQyZdoxXnLTtwR0fkYjgdB36XABQSwdxk6eQoQJtLC80w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQyZdoxXnLTtwR0fkYjgdB36XABQSwdxk6eQoQJtLC80w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 03:03:42PM -0500, Alan Tull wrote:
> On Wed, Mar 28, 2018 at 11:26 AM, Alan Tull <atull@kernel.org> wrote:
> > On Fri, Mar 23, 2018 at 7:27 AM, Paolo Pisati <p.pisati@gmail.com> wrote:
> >
> > Hi Paolo,
> 
> One more thing.  The api for registering a FPGA manager is changing.
> It won't be hard to adapt.  I've pushed a branch that includes the
> patches that add this change.  Please rebase on top of that branch so
> your patch can go in on top of that.
> 
> My git repo is at:
> git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
> 
> The branch name is
> for-review-next-20180327-drvdata-v3

Ok, i'll fix all the issues you raised in the previous email, rebase on
this branch and resend.
-- 
bye,
p.
