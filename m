Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77358C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB1D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB1D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJIBgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIBgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:36:02 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3902064E;
        Mon,  8 Oct 2018 18:23:02 +0000 (UTC)
Date:   Mon, 8 Oct 2018 14:23:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, knut.omang@oracle.com
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
Message-ID: <20181008142300.3aacaabe@gandalf.local.home>
In-Reply-To: <CACT4Y+Y+6arxj4=72DZSj45u5kjKRksJZ7c6pBLeFDxUSBFwOg@mail.gmail.com>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
        <CACT4Y+Y+6arxj4=72DZSj45u5kjKRksJZ7c6pBLeFDxUSBFwOg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 19:02:51 +0200
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Wed, Sep 19, 2018 at 7:13 PM, Dhaval Giani <dhaval.giani@gmail.com> wrote:
> > Hi folks,
> >
> > Sasha and I are pleased to announce the Testing and Fuzzing track at
> > LPC [ 1 ]. We are planning to continue the discussions from last
> > year's microconference [2]. Many discussions from the Automated
> > Testing Summit [3] will also continue, and a final agenda will come up
> > only soon after that.
> >
> > Suggested Topics
> >
> > - Syzbot/syzkaller
> > - ATS
> > - Distro/stable testing
> > - kernelci
> > - kernelci auto bisection
> > - Unit testing framework
> >
> > We look forward to other interesting topics for this microconference
> > as a reply to this email.  
> 
> Hi Dhaval and Sasha,
> 
> My syzbot talk wasn't accepted to main track, so I would like to do
> more or less full-fledged talk on the microconf. Is it possible?

Hi Dmitry,

Note, microconfs are not for full-fledged talks. They are to be
discussion focused. You can have a 5-10 minute presentation that leads
up to discussion of future work, but we like to refrain from any talks
about what was done if there's nothing to go forward with.

-- Steve
