Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC6DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7667A217AE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7667A217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeGCSwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:52:43 -0400
Received: from namei.org ([65.99.196.166]:34604 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbeGCSwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:52:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w63IpZvi006912;
        Tue, 3 Jul 2018 18:51:35 GMT
Date:   Wed, 4 Jul 2018 04:51:35 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module
 shutdown
In-Reply-To: <20180703165102.GB19800@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1807040450340.32123@namei.org>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com> <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com> <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com> <1530631615.3142.6.camel@linux.vnet.ibm.com>
 <20180703165102.GB19800@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:

> On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> 
> OK, I was not sure how that discussion went. I could add myself as
> co-maintainer to MAINTAINERS because I anyway need to go through
> all of these.
> 
> If anyone does not vote against, I'll send a patch.
> 

For Keys?  That would would be useful to help reduce the workload on 
David.

-- 
James Morris
<jmorris@namei.org>

