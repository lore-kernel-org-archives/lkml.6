Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC5DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429DA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392108AbfAPMJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:09:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55245 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbfAPMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:09:42 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 04f99bc5341b697c; Wed, 16 Jan 2019 13:09:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2] ACPI / tables: table override from built-in initrd
Date:   Wed, 16 Jan 2019 13:08:48 +0100
Message-ID: <1855294.Hn0iI1CQLe@aspire.rjw.lan>
In-Reply-To: <2e88277db20e4f72a78116b9c199ccf1@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1545112965-2692-1-git-send-email-shunyong.yang@hxt-semitech.com> <CAJZ5v0iEVUXZ=jV9JosNM+UwEC4y-i-GzJDJPyCiEXJPY8-h+Q@mail.gmail.com> <2e88277db20e4f72a78116b9c199ccf1@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 10, 2019 3:17:23 AM CET Yang, Shunyong wrote:
> Hi, Rafael
> 
>   Got it. Many thanks!
> 
> Shunyong.
> 
> On 2019/1/9 17:58, Rafael J. Wysocki wrote:
> > On Wed, Jan 9, 2019 at 3:41 AM Yang, Shunyong
> > <shunyong.yang@hxt-semitech.com> wrote:
> >>
> >> Hi, Rafael,
> >>
> >> Gentle ping for this patch.
> > 
> > It is in my queue, I'll get to it when the most urgent 5.0-candidate
> > fixes have been pushed.

Now applied (with some minor cleanups), thanks!

