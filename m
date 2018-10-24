Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A4ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E87207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E87207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeJYBJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:09:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeJYBJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:09:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEE5E3082B71;
        Wed, 24 Oct 2018 16:41:01 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7D8561B9A;
        Wed, 24 Oct 2018 16:41:01 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B66361800540;
        Wed, 24 Oct 2018 16:41:01 +0000 (UTC)
Date:   Wed, 24 Oct 2018 12:41:01 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <479471988.24247710.1540399261450.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAHk-=wjMjVx_swPnhRWejvvrMvDqOY0MW2Ov9GNt8vn4UEjchw@mail.gmail.com>
References: <1929897739.23623737.1540322729596.JavaMail.zimbra@redhat.com> <200314933.23623823.1540322768252.JavaMail.zimbra@redhat.com> <CAHk-=wjMjVx_swPnhRWejvvrMvDqOY0MW2Ov9GNt8vn4UEjchw@mail.gmail.com>
Subject: Re: GFS2: Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.65, 10.4.195.30]
Thread-Topic: GFS2: Pull request (merge window)
Thread-Index: 0Iezq9bBFeaQ2u2R3pAfakhZgZC+Sg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Oct 2018 16:41:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> On Tue, Oct 23, 2018 at 8:26 PM Bob Peterson <rpeterso@redhat.com> wrote:
> >
> > Please consider pulling the following changes for the GFS2 file system.
> 
> Pulled.
> 
> Just FYI - I end up editing your notes to look a bit more like most
> other people send them. No need to change anything, I just thought I'd
> mention it.
> 
>             Linus
> 
Thanks. In the future I'll try to make future pull requests more like the others.

Regards,

Bob Peterson
