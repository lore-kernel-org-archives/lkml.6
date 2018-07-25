Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B771720891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B771720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeGYN7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:59:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbeGYN7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:59:03 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C222308625E;
        Wed, 25 Jul 2018 12:47:30 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A982308BDA9;
        Wed, 25 Jul 2018 12:47:30 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2CA503F7CB;
        Wed, 25 Jul 2018 12:47:30 +0000 (UTC)
Date:   Wed, 25 Jul 2018 08:47:29 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>,
        nilal@redhat.com, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org,
        david@redhat.com, ross zwisler <ross.zwisler@intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        hch@infradead.org, pbonzini@redhat.com, mst@redhat.com,
        stefanha@redhat.com, niteshnarayanlal@hotmail.com,
        imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>,
        lcapitulino@redhat.com
Message-ID: <4226742.54063347.1532522849803.JavaMail.zimbra@redhat.com>
In-Reply-To: <d3fe397a-024d-faf7-8854-bb8e9ea17f53@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com> <20180713075232.9575-4-pagupta@redhat.com> <783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com> <399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com> <d3fe397a-024d-faf7-8854-bb8e9ea17f53@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.240, 10.4.195.15]
Thread-Topic: qemu: Add virtio pmem device
Thread-Index: 6vgDseTXz9KGgRBkFfGIW55ClGoGrA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 25 Jul 2018 12:47:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> 
> >>
> >> This patch has no n/M in the subject line; but is included in a thread
> >> that also has a 0/2 cover letter, as well as 1/2 and 2/2 patches in
> >> separate mails.  Is that intentional?
> > 
> > Yes, kernel series has 0-2 patches and Qemu has this one. I thought its
> > good to keep separate numbering for both the sets.
> 
> Ah, that makes sense. The cover letter didn't make it obvious to me that
> this was two separate series to two projects, but related enough that
> both series have to be incorporated for the feature to work and thus
> cross-posted under a single cover letter.

Will try to make it more clear in next posting.

Thanks,
Pankaj
