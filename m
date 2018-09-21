Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CB1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD0A21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD0A21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390068AbeIUS4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:56:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeIUS4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:56:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B87BE88E6D;
        Fri, 21 Sep 2018 13:07:28 +0000 (UTC)
Received: from redhat.com (ovpn-116-83.phx2.redhat.com [10.3.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 703068750A;
        Fri, 21 Sep 2018 13:07:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=vm-rhel7)
        by redhat.com with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <fche@redhat.com>)
        id 1g3L9a-0003O6-CG; Fri, 21 Sep 2018 09:07:26 -0400
From:   fche@redhat.com (Frank Ch. Eigler)
To:     Rik van Riel <riel@surriel.com>
Cc:     Edward Cree <ec429@cantab.net>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
        <20180919081812.020f19e3@lwn.net>
        <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
        <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
        <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
        <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
Date:   Fri, 21 Sep 2018 09:07:25 -0400
In-Reply-To: <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com> (Rik
        van Riel's message of "Thu, 20 Sep 2018 21:48:01 -0400")
Message-ID: <87zhwbj8xe.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 21 Sep 2018 13:07:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@surriel.com> writes:

> [...]  The goal of the code of conduct is to make the community
> welcoming, and to help people with being a part of the Linux
> community.  [...]

That may well be the goal.  But the proper way to evaluate policy is not
the laudability of its goals but its forseeable and/or actual effects.
Is there any plan to evaluate the CoC empirically somehow to see if it
accomplishes what its proponents hope?

- FChE
