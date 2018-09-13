Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC1C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F4B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qzXmo6g5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F4B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeIMHeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:34:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43207 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbeIMHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:34:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B583218FD;
        Wed, 12 Sep 2018 22:27:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Sep 2018 22:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=S+CU6Y
        hvjuHgNhUVT/HgkV8Tf9YVQEcO/L9EEfQj4MY=; b=qzXmo6g5AFM91FjFNUxjCG
        2yPsPaQ4f9uvmsntlpveZumPQ6QNPcx8Voofkw1a0pTKwZleE1aXZMxfKYlueFwz
        EJZqS/4MTzAVEyGB6GbyDQDoU9rtnE7DrdoP8CmyyFAav+QKMdJG7EVt5mrLeZzg
        rNCOaWBV56D99lZHbGX1/SHmUDiIIZU5fp6s/CmAO0pZ0Cg7btxN6PwSFatMtTC1
        +fJ53ZKaWdinPGjMQ5BOsnu7BBK+TWVRnWSUZGW/U/9CX0EZtAnYuPyeIGhH/qb+
        6/CXYpwPC+38gQHNQfnNjWHvGtikFpaksgyFAnJsNq/G1Aq57UIhujZWBzET85Rw
        ==
X-ME-Proxy: <xmx:9sqZW4S9LS6B-3wSn1Mhq1CR24eW9D-84fKw9S2tluPnZ4dewxLitQ>
    <xmx:9sqZW1XgFY8VcOstpgSZbap9n49JVVTBpqSiGtibmgwNBzJVweg8Kw>
    <xmx:9sqZW8Qyuceqkv8cZ8yfuwDcztrEO4fVZHkPP2Rm5Y8678kcGgW7wA>
    <xmx:9sqZW7mD8rMAyEpsEvbxjNTqLneHZ_XW9VsIXDNG9J1aseBQa1wMhQ>
    <xmx:9sqZW49pK3SOXP9jNKoVUFKeeukg7cgTi-72zsk5Ilauawv7cJMjHg>
    <xmx:98qZW_N5i8UkqCpcdYswHiZyHl-fSMHDIdz4Z2ZWLqXTDJWbYM_CEw>
X-ME-Sender: <xms:9sqZW6SwLpojUdGezZVvrcqLgbDjkg9TyZucU18XQFsuJOJqJZysbg>
Received: from snap.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5EF0C102D9;
        Wed, 12 Sep 2018 22:26:58 -0400 (EDT)
Message-ID: <94b8929d44af6dd965600b7d159458312d500582.camel@russell.cc>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error
 handling
From:   Russell Currey <ruscur@russell.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sbobroff@linux.ibm.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, oohall@gmail.com
In-Reply-To: <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
         <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 13 Sep 2018 12:26:55 +1000
Mime-Version: 1.0
X-Mailer: Evolution 3.28.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The original PCI error recovery functionality was for the powerpc-specific
> > IBM EEH feature.  PCIe subsequently added some similar features, including
> > AER and DPC, that can be used on any architecture.
> > 
> > We want the generic PCI core error handling support to work with all of
> > these features.  Driver error recovery callbacks should be independent of
> > which feature the platform provides.
> > 
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> 
> I really want to make sure the powerpc folks are plugged into any PCI core
> error handling discussions.  Please let me know if there's a better way
> than this patch, or if there are other people who should be added.

I think this patch is definitely a good idea.

Alongside this (whether you want to include it in your patch or not, Bjorn),
Sam Bobroff should replace myself as maintainer.  He's been very active in fixing,
reworking and reviewing in EEH land and will probably do a better job of keeping
his finger on the pulse of the generic PCI error handling code than I did.

- Russell

> 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  MAINTAINERS |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7e10ba65bfe4..d6699597fd89 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11202,6 +11202,10 @@ PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> >  M:	Russell Currey <ruscur@russell.cc>
> >  L:	linuxppc-dev@lists.ozlabs.org
> >  S:	Supported
> > +F:	Documentation/PCI/pci-error-recovery.txt
> > +F:	drivers/pci/pcie/aer.c
> > +F:	drivers/pci/pcie/dpc.c
> > +F:	drivers/pci/pcie/err.c
> >  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> >  F:	arch/powerpc/kernel/eeh*.c
> >  F:	arch/powerpc/platforms/*/eeh*.c
> > 
