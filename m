Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F615C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AA82084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfA2K74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59209 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfA2K74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:59:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E552F7E9C4;
        Tue, 29 Jan 2019 10:59:55 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D25055D96F;
        Tue, 29 Jan 2019 10:59:54 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C43954A460;
        Tue, 29 Jan 2019 10:59:54 +0000 (UTC)
Date:   Tue, 29 Jan 2019 05:59:54 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Message-ID: <1016483826.67536575.1548759594722.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAO-hwJK_WoimsUMR19GR_qEUCk0ZMaKGham3DSJ5SDqtc8oCzw@mail.gmail.com>
References: <20190126170722.8035-1-vdronov@redhat.com> <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com> <20190128111818.GA22143@redhat.com> <CAO-hwJK_WoimsUMR19GR_qEUCk0ZMaKGham3DSJ5SDqtc8oCzw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: debug: fix the ring buffer implementation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.5.180, 10.4.195.20]
Thread-Topic: debug: fix the ring buffer implementation
Thread-Index: xlFuXL6Es++1KOceSMXVd9aIK7Zl2A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 29 Jan 2019 10:59:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I still think that
> >
> >                     __set_current_state(TASK_RUNNING);
> >
> > will look a bit better, but this is really minor.
> 
> Would you mind sending a v3 with this change? I'll apply it ASAP.

Done, please, see inbox.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security | Senior Software Engineer
