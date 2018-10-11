Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB3C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC6120659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC6120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeJKXbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:31:04 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:47960 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729226AbeJKXEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C47C65B3C;
        Thu, 11 Oct 2018 15:37:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mist42_213832ce0c619
X-Filterd-Recvd-Size: 1467
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Oct 2018 15:37:08 +0000 (UTC)
Message-ID: <64a18d4b6390e0c7011f440a5f1970371ce43dec.camel@perches.com>
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
Date:   Thu, 11 Oct 2018 08:37:07 -0700
In-Reply-To: <yq1d0sh459q.fsf@oracle.com>
References: <cover.1537183087.git.joe@perches.com>
         <yq1d0sh459q.fsf@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-10 at 21:54 -0400, Martin K. Petersen wrote:
> Joe,
> 
> > Several defects exist in the logging uses
> > 
> > o Missing KERN_<LEVEL>
> > o Unnecessary KERN_<LEVEL> uses with panic
> > o Mismatched MPT3SAS_FMT and %s: with name and __func__
> > 
> > Correct these defects and perhaps add some clarity to the logging.
> 
> Applied to 4.20/scsi-queue, thanks!

Is this branch also applied to Stephen Rothwell's -next?


