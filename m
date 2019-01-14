Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F82C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9752087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfANPqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:46:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:36758 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANPqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:46:17 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7C5002E5;
        Mon, 14 Jan 2019 15:46:16 +0000 (UTC)
Date:   Mon, 14 Jan 2019 08:46:15 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Royer <seroyer@linux.ibm.com>
Subject: Re: [PATCH] Documentation: add ibmvmc to toctree(index) and fix
 warnings
Message-ID: <20190114084615.4f38b265@lwn.net>
In-Reply-To: <bd222e7e-33cd-37ce-f702-238a8e93dfc8@infradead.org>
References: <bd222e7e-33cd-37ce-f702-238a8e93dfc8@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2019 19:21:46 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix Sphinx warnings in ibmvmc.rst, add an index.rst file in
> Documentation/misc-devices/, and insert that index file into the
> top-level index file.
> 
> Documentation/misc-devices/ibmvmc.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/misc-devices/ibmvmc.rst:: WARNING: document isn't included in any toctree
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Royer <seroyer@linux.ibm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>

Rather than make another new top-level entry to add to the mess there, I
do wonder if this isn't better placed in the driver-api manual.  I *think*
that's appropriate, though the document is a bit vague to use that way.

Oh well, bringing it in and killing some warnings is better than what we
have now, so I've applied it.  We can always move it around later.

Thanks,

jon
