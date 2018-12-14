Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B676E2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbeLNWD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:03:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbeLNWDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:03:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B08A9A6E13;
        Fri, 14 Dec 2018 22:03:25 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDD0D19C65;
        Fri, 14 Dec 2018 22:03:24 +0000 (UTC)
Subject: Re: [PATCH 1/2] livepatch: fix non-static warnings
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
 <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
 <20181214215129.mshuswyuqlcx76wz@treble>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <20aa1e58-7af3-ddaa-5d3a-87f93e8718e5@redhat.com>
Date:   Fri, 14 Dec 2018 17:03:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181214215129.mshuswyuqlcx76wz@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 14 Dec 2018 22:03:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2018 04:51 PM, Josh Poimboeuf wrote:
> On Fri, Dec 14, 2018 at 04:34:23PM -0500, Joe Lawrence wrote:
>> BTW, Petr/Miroslav/Josh, should we be annotating the selftests in
>> similar fashion?
> 
> Probably so.
> 

Just to clarify for Nicholas, the self-tests we're referring to are part
of another patch series currently under review -- no need to worry about
them for the changes here.

Thanks,

-- Joe
