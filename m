Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB77AC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820A4205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820A4205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeJLHbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:31:20 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:33564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbeJLHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:31:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 90575182CF66F;
        Fri, 12 Oct 2018 00:01:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: park68_48ebe86727841
X-Filterd-Recvd-Size: 1365
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 12 Oct 2018 00:01:40 +0000 (UTC)
Message-ID: <e606c5059731c3deafa5b839ab6859f22a957eb0.camel@perches.com>
Subject: Re: [PATCH 0/7] Neaten logging uses
From:   Joe Perches <joe@perches.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Oct 2018 17:01:39 -0700
In-Reply-To: <yq1efcw12xm.fsf@oracle.com>
References: <cover.1537183087.git.joe@perches.com>
         <yq1d0sh459q.fsf@oracle.com>
         <64a18d4b6390e0c7011f440a5f1970371ce43dec.camel@perches.com>
         <yq1efcw12xm.fsf@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 19:25 -0400, Martin K. Petersen wrote:
> Joe,
> 
> > > Applied to 4.20/scsi-queue, thanks!
> > 
> > Is this branch also applied to Stephen Rothwell's -next?
> 
> Yes.

Via what tree?  It doesn't seem directly pulled.

