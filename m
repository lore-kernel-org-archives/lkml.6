Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9253CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FBF222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549913092;
	bh=gmDvfU8q6MqpB5PWIzB5MIP3/zdzjAK0XWpL5EQIDWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyFCz/jYEGQa21ZMLoA+QD6UmB2mv/aq5KfPMyf8lNTQOByC1wgJKvxsUvyPf2fqO
	 wRMGoLZ4hEEXIh1FnjS2FrXHTMDqD4oqBjwSaoV2gKykTIgmQsQBqgDrsadl+Yapxc
	 VdcXR0P5klOUYBk8J1cR8CAkiLtS3CwLUvjC59AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfBKTYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfBKTYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:24:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA6C21B25;
        Mon, 11 Feb 2019 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549913089;
        bh=gmDvfU8q6MqpB5PWIzB5MIP3/zdzjAK0XWpL5EQIDWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAOMZc5jo15PFbRyQ+fBKUVghOt7OomvpZHyeKO8oZaESbbD6Z9CKCCqijb5bOpm/
         wkCkzbMBi3w5RRmNvpfeqt+p4GZwcOCwvm/tJEZAy6I4i624/KqWg95pXgl7iHaYGA
         0pvQqqvii5JMI7DPIkhsZOwVhC8tuBsuVrjFiu48=
Date:   Mon, 11 Feb 2019 20:24:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lin Ming <ming.m.lin@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@elte.hu>, He Zhe <zhe.he@windriver.com>
Subject: Re: [PATCH 4.9 137/137] perf: Add support for supplementary event
 registers
Message-ID: <20190211192447.GB13134@kroah.com>
References: <20190211141811.964925535@linuxfoundation.org>
 <20190211141824.827389473@linuxfoundation.org>
 <20190211181153.GF16922@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211181153.GF16922@tassilo.jf.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:11:53AM -0800, Andi Kleen wrote:
> On Mon, Feb 11, 2019 at 03:20:18PM +0100, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > commit a7e3ed1e470116c9d12c2f778431a481a6be8ab6 upstream.
> 
> The patch doesn't seem to match the commit log.
> 
> Did something got mixed up?

Yes, that's odd, sorry about that.  Now fixed up, I have no idea how
that happened :(

greg k-h
