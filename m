Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5744C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D42083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9D42083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeGZM4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:56:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729384AbeGZM4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:56:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65DC2AE29;
        Thu, 26 Jul 2018 11:40:12 +0000 (UTC)
Date:   Thu, 26 Jul 2018 13:40:11 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com,
        syzbot <syzbot+b51c77ef956678a65834@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in rds_ib_get_mr
Message-ID: <20180726114011.zm74p7cwi4kjjda3@linux-x5ow.site>
References: <089e082ce58896ad350567ee4825@google.com>
 <20180513211058.GE677@sol.localdomain>
 <27665604-6a26-36e2-3a58-9c8b3d9eab80@oracle.com>
 <20180704213506.GH725@sol.localdomain>
 <04c882dc-332e-92d6-fe76-b1dd3bedd71c@oracle.com>
 <20180705070641.ske6jjvk4zp5kg2f@linux-x5ow.site>
 <3bb47711-870e-90c6-d404-3fe61f0ab9a0@oracle.com>
 <20180706081113.kwrwcat5l6o7ozar@linux-x5ow.site>
 <a879fe73-1755-8e4c-6f23-203b8d46a373@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a879fe73-1755-8e4c-6f23-203b8d46a373@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 08:58:43PM -0700, santosh.shilimkar@oracle.com wrote:
> On 7/6/18 1:11 AM, Johannes Thumshirn wrote:
> > On Thu, Jul 05, 2018 at 09:09:44AM -0700, Santosh Shilimkar wrote:
> > > OK. we will look into it if an interim fix can be made....
> > 
> > Thanks a lot.
> > 
> Intermediate fix is posted here [1]
> 
> Regards,
> Santosh
> 
> [1] https://patchwork.ozlabs.org/patch/949010/

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
