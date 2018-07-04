Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD4CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8212083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8212083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934414AbeGDIsS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:48:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932439AbeGDIsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:48:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81329AFF8;
        Wed,  4 Jul 2018 08:48:14 +0000 (UTC)
Date:   Wed, 4 Jul 2018 10:48:12 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC] scsi: switch to scsi-mq by default
Message-ID: <20180704084812.jfeqju3sqtkuwnhu@linux-x5ow.site>
References: <20180703065413.6098-1-jthumshirn@suse.de>
 <7ab21471b799d2a60ccfd8579b2548f58915568a.camel@wdc.com>
 <282521f4-762c-86a5-5ac8-f8cc33b050cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <282521f4-762c-86a5-5ac8-f8cc33b050cc@huawei.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:18:23AM +0100, John Garry wrote:
> We were seeing performance drops previously for hisi_sas when originally
> enabled by default, but results on 4.18 seem almost identical with and
> without MQ default.
> 
> FWIW,
> 
> Acked-by: John Garry <john.garry@huawei.com>

Thanks for letting me know.
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
