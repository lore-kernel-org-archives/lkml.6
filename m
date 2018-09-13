Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12931C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE1E20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE1E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIMNoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:44:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:40676 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeIMNoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:44:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8D8Zc8C025126;
        Thu, 13 Sep 2018 03:35:39 -0500
Message-ID: <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error
 handling
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Date:   Thu, 13 Sep 2018 10:35:38 +0200
In-Reply-To: <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
         <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> 
> I really want to make sure the powerpc folks are plugged into any PCI core
> error handling discussions.  Please let me know if there's a better way
> than this patch, or if there are other people who should be added.

Sounds good. Oliver, you want to be looped in as well ?

Cheers,
Ben.


