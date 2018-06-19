Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD0B2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD0B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757320AbeFSOch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:32:37 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34878 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeFSOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:32:36 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fVHgQ-0005rC-2a; Tue, 19 Jun 2018 22:32:34 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fVHgM-0007HH-L5; Tue, 19 Jun 2018 22:32:30 +0800
Date:   Tue, 19 Jun 2018 22:32:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
        arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com,
        frankja@linux.ibm.com, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 0/2] Detect & register virtio-crypto algos only if it
 can be supported by backend
Message-ID: <20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
References: <cover.1528921468.git.alifm@linux.ibm.com>
 <44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
 <0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:08:05PM +0200, Christian Borntraeger wrote:
> On 06/19/2018 03:26 PM, Farhan Ali wrote:
> > A polite ping :)
> > 
> > If no one has any more comments/feedback then I would like to how to merge these patches to the mainline kernel tree.
> 
> I think it should go via Michael Tsirkin or Jason Wang (Adding Jason).
> Also adding Herbert Xu as FYI.
> 
> 
> I have not looked into the details of the patch, but I like the idea.
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Please post crypto patches to linux-crypto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
