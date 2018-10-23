Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC00C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE620651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAE620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeJWMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:35:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34640 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJWMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:35:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEo5C-0003Hi-S6; Tue, 23 Oct 2018 04:14:18 +0000
Date:   Tue, 23 Oct 2018 05:14:18 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        reiserfs-devel@vger.kernel.org
Subject: Re: Reiser4 Linux 4.17.19-1 hangs in Google cloud VM, too.
Message-ID: <20181023041418.GU32577@ZenIV.linux.org.uk>
References: <20181022101912.3CE2E292B005@huitzilopochtli.metztli-it.com>
 <20181023033852.GR32577@ZenIV.linux.org.uk>
 <20181023034719.tqkvdj2eakh2uh2q@shells.gnugeneration.com>
 <20181023035425.GS32577@ZenIV.linux.org.uk>
 <20181023040418.iz7gcph3qha4bkab@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023040418.iz7gcph3qha4bkab@shells.gnugeneration.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 09:04:18PM -0700, Vito Caputo wrote:
> > reiser4 has never been in-tree to start with.  And name is completely irrelevant -
> > all I'm refering to is that I have not seen any postings on l-k/fsdevel/etc.
> > from anybody working on that particular out-of-tree codebase.
> > 
> > Put it that way - I would expect the bitrot from (apparent) decade-long
> > inactivity to be a much more serious problem than anything naming-related.
> 
> Would you say bitrot is more or less likely if a project doesn't attract
> fresh meat?

I would say that by now it seems to be a purely academical question - after a while
the bitrot itself is more than enough.  If it's maintained by somebody, take that
question to those somebodies, whoever they are.  I hadn't seen any indications that
it is, and that's literally all I'm trying to comment upon - *IF* it's been
unmaintained, it's almost certainly far past the point of no return due to bitrot.
