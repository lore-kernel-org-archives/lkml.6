Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C74C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E04223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E04223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeKPFxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:53:04 -0500
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:38674 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725742AbeKPFxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:53:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DBABA6D70;
        Thu, 15 Nov 2018 19:43:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mind54_4b811205932d
X-Filterd-Recvd-Size: 2447
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Nov 2018 19:43:52 +0000 (UTC)
Message-ID: <e4efcfd8c99ef197714230cb1eb246b39dc83151.camel@perches.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
From:   Joe Perches <joe@perches.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>
Date:   Thu, 15 Nov 2018 11:43:51 -0800
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D459E55@ORSMSX110.amr.corp.intel.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
         <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
         <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
         <20181115061036.1575223d@silica.lan>
         <20181115162008.GO3759@mtr-leonro.mtl.com>
         <20181115110919.46978343@silica.lan>
         <20181115193520.GA24359@mtr-leonro.mtl.com>
         <3908561D78D1C84285E8C5FCA982C28F7D459E55@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-15 at 19:40 +0000, Luck, Tony wrote:
> > I would recommend to remove this section at all.
> > New maintainers won't come out of blue, but will be come
> > from existing community and such individuals for sure will see
> > and judge by themselves to whom they trust and to whom not.
> 
> Perhaps this is more of a hint to contributors than to maintainers
> (see earlier discussion on who is the target audience for these documents).
> 
> It would help contributors know some names of useful reviewers (and
> thus this list should be picked up by scripts/get_maintainer.pl to help
> the user compose Cc: lists for e-mail patches).

Trusted reviewers should be specifically listed
in the MAINTAINERS file with an "R:" entry.

get_maintainers should not look anywhere else.


