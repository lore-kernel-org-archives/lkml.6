Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7AEC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0F8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0F8206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeKUDT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:19:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:55940 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKUDT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:19:56 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6971535A;
        Tue, 20 Nov 2018 16:49:51 +0000 (UTC)
Date:   Tue, 20 Nov 2018 09:49:50 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Pavel Machek <pavel@ucw.cz>, Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        timmurray@google.com, joelaf@google.com, surenb@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181120094950.11978b68@lwn.net>
In-Reply-To: <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
References: <20181031150625.147369-1-dancol@google.com>
        <20181105132205.138695-1-dancol@google.com>
        <20181119105426.GD28607@amd>
        <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 10:05:21 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> Why can't the documentation describe the current implementation, and
> change in the future if the implementation changes? I doubt somebody
> would ever rely on the pid being reused while having the descriptor
> open. How would that make sense?

In the hopes of ending this discussion, I'm going to go ahead and apply
this.  Documenting current behavior is good, especially in situations
where that behavior can surprise people; if the implementation changes,
the docs can change with it.

Thanks,

jon
