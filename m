Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7476C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B918F2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfBGAca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:32:30 -0500
Received: from ms.lwn.net ([45.79.88.28]:35670 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfBGAca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:32:30 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 64AD44FA;
        Thu,  7 Feb 2019 00:32:29 +0000 (UTC)
Date:   Wed, 6 Feb 2019 17:32:28 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, juri.lelli@redhat.com,
        mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Documentation: Explain EAS and EM
Message-ID: <20190206173228.30e99cf4@lwn.net>
In-Reply-To: <20190121111724.18234-1-quentin.perret@arm.com>
References: <20190121111724.18234-1-quentin.perret@arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 11:17:21 +0000
Quentin Perret <quentin.perret@arm.com> wrote:

> The recently introduced Energy Aware Scheduling (EAS) feature relies on
> a large set of concepts, assumptions, and design choices that are
> probably not obvious for an outsider. Moreover, enabling EAS on a
> particular platform isn't straightforward because of all its
> dependencies. This series tries to address this by introducing proper
> documentation files for the scheduler's part of EAS and for the newly
> introduced Energy Model (EM) framework. These are meant to explain not
> only the design choices of EAS but also to list its dependencies in a
> human-readable location.

So these have been sitting in my folder waiting for acks or some other
sort of discussion, but it's been awfully quiet.  Should I take them, or
do they need further work or ... ?

Thanks,

jon
