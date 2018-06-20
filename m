Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F221C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8D020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754844AbeFTTEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:04:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbeFTTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:33 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6555EA6;
        Wed, 20 Jun 2018 19:04:32 +0000 (UTC)
Date:   Thu, 21 Jun 2018 03:48:43 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 120/189] powerpc/trace/syscalls: Update syscall name
 matching logic
Message-ID: <20180620184843.GB32326@kroah.com>
References: <20180618081209.254234434@linuxfoundation.org>
 <20180618081214.069543596@linuxfoundation.org>
 <1529376134.mmb9hh2cc8.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529376134.mmb9hh2cc8.naveen@linux.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 08:13:21AM +0530, Naveen N. Rao wrote:
> Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> Please drop this and the next patch since these depend on commit
> e145242ea0df6, which is not in v4.14.

Now dropped from all of the stable queues, thanks.

greg k-h
