Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A2ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340B420824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340B420824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeJYJrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:47:02 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:60188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbeJYJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:47:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6228A8368EF7;
        Thu, 25 Oct 2018 01:16:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: laugh88_1c0caea4a8017
X-Filterd-Recvd-Size: 2061
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Oct 2018 01:16:32 +0000 (UTC)
Message-ID: <dda151c160e42aeb07d158d9c7cd4c1a3341ab5f.camel@perches.com>
Subject: Re: [PATCH] Change judgment len position
From:   Joe Perches <joe@perches.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Willy Tarreau <w@1wt.eu>, David Miller <davem@davemloft.net>,
        wanghaifine@gmail.com, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@intel.com>,
        Philip Li <philip.li@intel.com>
Date:   Wed, 24 Oct 2018 18:16:31 -0700
In-Reply-To: <20181025011111.bhbstq5wtrwk26b5@wfg-t540p.sh.intel.com>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
         <20181024.101028.1211941922121897721.davem@davemloft.net>
         <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
         <20181024204852.GA25509@1wt.eu>
         <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
         <20181025011111.bhbstq5wtrwk26b5@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 09:11 +0800, Fengguang Wu wrote:
> CC Philip and LKP team.
> > 	Please try to make your first patch in drivers/staging
> > 	to get familiar with submitting patches to the kernel.
> > 	https://kernelnewbies.org/FirstKernelPatch
> > 
> > Maybe there's utility in creating a filtering and auto-reply
> > tool for first time patch submitters for all the vger mailing
> > lists using some combination of previously known submitters
> > and the 0-day robot to point those first time submitters of
> > defective patches to kernelnewbies and staging.
> 
> Yeah good idea. That feature can be broken into 2 parts:
> 
> - an email script, which could be added to Linux scripts/ dir 
> - maintain records for telling whether someone is first-time patch submitters

Maybe run checkpatch on those first-time submitter patches too.


